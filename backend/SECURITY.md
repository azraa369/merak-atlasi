# Atlas veri erişimi

`atlas_notes` ve `atlas_memories` tablolarında RLS etkindir. Ziyaretçi etkin notları ve onaylı, arşivlenmemiş hatıraları okuyabilir. Not ekleme/güncelleme ve hatıra onaylama, yalnızca doğrulanmış e-postası özel şemadaki sahip kaydıyla eşleşen oturuma açıktır.

`atlas_private` şeması anonim ve giriş yapmış kullanıcılara kapalıdır. Buradaki tablolarda RLS politikası tanımlanmaması kasıtlıdır: doğrudan erişim yoktur. [RLS danışmanı açıklaması](https://supabase.com/docs/guides/database/database-linter?lint=0008_rls_enabled_no_policy).

`is_atlas_owner` ve `submit_atlas_memory` işlevleri, bu kısıtlı tablolara kontrollü erişmek için `SECURITY DEFINER` kullanır. İkisinin de arama yolu boş olarak sabitlenmiştir. İlki yalnızca bir yetki kontrolü sonucu döndürür. İkincisi uzunluk kontrolü, boş bot alanı ve rastgele tarayıcı kimliği başına 60 saniye aralık kontrolü uygular; yalnızca onay bekleyen hatıra ekleyebilir. Bu işlevlerin anonim ve doğrulanmış rollere açık olması amaçlanan davranıştır. [Anonim işlev erişimi danışmanı](https://supabase.com/docs/guides/database/database-linter?lint=0028_anon_security_definer_function_executable), [oturum açmış kullanıcı işlev erişimi danışmanı](https://supabase.com/docs/guides/database/database-linter?lint=0029_authenticated_security_definer_function_executable).

Tarayıcıdaki rastgele kimlik aralık kontrolü, gelişmiş bot engelleme veya IP tabanlı kota değildir. Hatıralar bu nedenle sahibinin onayına düşer. Yönetici e-postası, erişim belirteçleri ve service-role anahtarı site kaynaklarına eklenmez. Publishable anahtar gizli değildir; erişimi RLS kuralları sınırlar.

Kontroller: anonim not yazımının reddi, bekleyen hatıraların anonim kullanıcıdan gizlenmesi, tekrarlı gönderim sınırı, sahip hesabıyla not ekleme/güncelleme/arşivleme ve hatıra onaylama veritabanında geri alınan bir işlem içinde doğrulanmıştır. Test kayıtları bırakılmamıştır.
