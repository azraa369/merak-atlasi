create schema if not exists atlas_private;
revoke all on schema atlas_private from public, anon, authenticated;
create table atlas_private.owners (email text primary key check (email = lower(email)));
create table atlas_private.guest_limits (device_id uuid primary key, sent_at timestamptz not null default now());
alter table atlas_private.owners enable row level security;
alter table atlas_private.guest_limits enable row level security;

create function public.is_atlas_owner() returns boolean
language sql stable security definer set search_path = ''
as $$ select exists(select 1 from atlas_private.owners where email=lower(auth.jwt()->>'email')); $$;
revoke all on function public.is_atlas_owner() from public;
grant execute on function public.is_atlas_owner() to anon, authenticated;

create table public.atlas_notes (
  id uuid primary key default gen_random_uuid(),
  category text not null check (category in ('curiosity','try','questions')),
  title text not null check (char_length(trim(title)) between 1 and 100),
  body text not null check (char_length(trim(body)) between 1 and 2000),
  question text not null default '' check (char_length(question)<=250),
  archived boolean not null default false,
  created_at timestamptz not null default now()
);
create table public.atlas_memories (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(trim(name)) between 1 and 40),
  message text not null check (char_length(trim(message)) between 3 and 600),
  approved boolean not null default false,
  archived boolean not null default false,
  created_at timestamptz not null default now()
);
create index atlas_notes_category_date on public.atlas_notes(category,created_at desc) where not archived;
create index atlas_memories_public_date on public.atlas_memories(created_at desc) where approved and not archived;
alter table public.atlas_notes enable row level security;
alter table public.atlas_memories enable row level security;
revoke all on public.atlas_notes,public.atlas_memories from anon,authenticated;
grant select on public.atlas_notes,public.atlas_memories to anon,authenticated;
grant insert,update on public.atlas_notes to authenticated;
grant update on public.atlas_memories to authenticated;
create policy notes_read on public.atlas_notes for select using (not archived or public.is_atlas_owner());
create policy notes_owner_insert on public.atlas_notes for insert to authenticated with check(public.is_atlas_owner());
create policy notes_owner_update on public.atlas_notes for update to authenticated using(public.is_atlas_owner()) with check(public.is_atlas_owner());
create policy memories_read on public.atlas_memories for select using ((approved and not archived) or public.is_atlas_owner());
create policy memories_owner_update on public.atlas_memories for update to authenticated using(public.is_atlas_owner()) with check(public.is_atlas_owner());

create function public.submit_atlas_memory(p_name text,p_message text,p_device uuid,p_website text default '') returns uuid
language plpgsql security definer set search_path = '' as $$
declare new_id uuid;
begin
  if char_length(trim(p_name)) not between 1 and 40 or char_length(trim(p_message)) not between 3 and 600
     or p_device is null or p_website is null or char_length(p_website)>0 then
    raise exception 'invalid_memory' using errcode='22023';
  end if;
  perform pg_advisory_xact_lock(hashtext(p_device::text));
  if exists(select 1 from atlas_private.guest_limits where device_id=p_device and sent_at>now()-interval '60 seconds') then
    raise exception 'please_wait' using errcode='P0001';
  end if;
  insert into atlas_private.guest_limits(device_id,sent_at) values(p_device,now())
    on conflict(device_id) do update set sent_at=excluded.sent_at;
  insert into public.atlas_memories(name,message) values(trim(p_name),trim(p_message)) returning id into new_id;
  return new_id;
end $$;
revoke all on function public.submit_atlas_memory(text,text,uuid,text) from public;
grant execute on function public.submit_atlas_memory(text,text,uuid,text) to anon,authenticated;

insert into public.atlas_notes(category,title,body,question) values
('curiosity','Bir fikir ne zaman bir dünyaya dönüşür?','Bir web sayfasının yalnızca okunmasını değil, keşfedilmesini istiyorum. Bir düğme, bir ses, bir seçim… Küçük etkileşimlerin bir fikri nasıl değiştirdiğini merak ediyorum.','Sen bir fikri anlatmak için hangi duyuyu kullanırdın?'),
('try','Birlikte bir gökyüzü kurmak.','Bu atlası ziyaret eden herkesin bir iz bırakabilmesi fikri hoşuma gidiyor. Kendi takımyıldızını çizmek ve başka ziyaretçilerin notlarını okumak, bu evrenin bir sonraki deneyi.','Senin takımyıldızının adı ne olurdu?'),
('questions','Bir site sahibini nasıl anlatır?','Bir insanı tanımak için kaç bilgi gerekir? Belki de doğrudan kendimizi anlatmak yerine, sorduğumuz soruları ve kurduğumuz küçük dünyaları paylaşabiliriz.','Birini, verdiği cevaplardan mı sorduğu sorulardan mı tanırsın?');
