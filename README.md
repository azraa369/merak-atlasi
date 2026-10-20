# Azra’nın Merak Atlası

Türkçe, etkileşimli bir keşif sitesi. Ön yüz GitHub Pages üzerinde; uydu notları, ziyaretçi hatıraları ve yönetici girişi Supabase ile çalışır.

## Ziyaretçiler

- Beş gezegen: teknoloji, uzay, müzik, oyun ve hayal gücü.
- Merak pusulası ve “Beni şaşırt”: ziyaretçinin yazdığı konuya göre ilgili gezegenler önerilir. Birden fazla eşleşme seçim olarak sunulur. Eşleşme yoksa ziyaretçiye seçenekler gösterilir. Bu özellik Türkçe anahtar sözcük eşleştirmesidir; genel sorulara yapay zekâ yanıtı üretmez ve yazılan merakları kaydetmez.
- Gezegen deneylerinin altında ziyaretçinin kendi sorusunu yazabileceği ek keşif alanı bulunur.
- Yıldız ekleme, geri alma, renk seçme ve SVG indirme özellikli takımyıldızı. Çizim yalnızca ziyaretçinin tarayıcısında saklanır.
- Hatıralar doğrudan sayfadaki formdan, hesap açmadan gönderilir. Yalnızca yönetici onayından geçenler herkese görünür. Önceki GitHub defterinin yayınlanmış notları da arşiv olarak korunur.

## Azra için yönetim

1. Sayfa sonundaki **Azra’nın yönetim alanı** düğmesine bas.
2. Yönetici e-postanı yazıp giriş bağlantısı iste. E-postadaki bağlantıyı aynı tarayıcıda aç.
3. Kategori, başlık, not ve isteğe bağlı ziyaretçi sorusunu doldurup **Notu herkese yayınla** düğmesine bas.
4. Notlarını düzenleyebilir, arşivleyebilir ve arşivden geri getirebilirsin.
5. Ziyaretçi hatıralarını **Onayla ve yayınla**, **Duvardan gizle** veya **Arşivle** düğmeleriyle yönetebilirsin.

Yetki e-posta doğrulamasından sonra veritabanında kontrol edilir. Yönetim oturumu sekme oturumunda saklanır. Ortak bilgisayarda işin bitince çıkış yap.

## Dosyalar ve yayın

- `index.html`: ana sayfa ve deneyler.
- `explore.css`, `explore.js`: görsel keşif alanları ve takımyıldızı.
- `routing.js`: meraka göre yönlendirme.
- `community.css`, `community.js`: yönetim, veri bağlantıları, uydu notları ve hatıra formu.
- `atlas-config.js`: Supabase proje adresi ve tarayıcıda kullanılabilen publishable anahtar. Gizli service-role anahtarı içermez.
- `backend/schema.sql`: tablolar ve RLS yetki kuralları. Yönetici e-postası bu dosyada bulunmaz; veritabanının özel şemasında tutulur.
- `.github/workflows/publish.yml`: statik ön yüzü yayınlar ve eski GitHub defterinin arşivini korur.

GitHub Pages kaynağı **GitHub Actions** olarak seçilidir. Yeni uydu notu ve hatıra eklemek için kod değiştirmek veya siteyi yeniden yayınlamak gerekmez.

## Geliştirme

HTML, CSS, JavaScript, SVG, Web Audio API, Supabase Postgres ve Supabase Auth kullanılır. Yönetici girişinde Supabase JavaScript istemcisi yüklenir. Yazı tipleri Google Fonts üzerinden gelir; yüklenemezse sistem yazı tipleri kullanılır. Tasarım ve uygulama yapay zekâ desteğiyle hazırlanmıştır.

Ziyaretçi içeriği HTML olarak çalıştırılmaz. Form doğrulaması ve gönderimler arası bekleme veritabanında da uygulanır. Yetkiler ve kontrollere dair notlar `backend/SECURITY.md` içindedir.
