# Azra’nın Merak Atlası

Kendini bir CV ile anlatmak yerine ziyaretçiyi beş küçük deneye davet eden, Türkçe bir kişisel web projesi.

## Deneyler

- Teknoloji: yapay zekâ ve yaratıcılık üzerine seçimler.
- Uzay: yerçekimine göre yaklaşık tartı sonucu.
- Müzik: Web Audio API ile tarayıcıda üretilen üç notalık sesler.
- Oyun: üç çiftli hafıza oyunu.
- Hayal gücü: beklenmedik kavramlarla fikir üretimi.

Keşif pasaportu localStorage ile yalnızca ziyaretçinin tarayıcısında saklanır. Hesap, sunucu veya API anahtarı gerekmez. Site bir yapay zekâ servisine istek göndermez; yapay zekâ desteği geliştirme sürecinde kullanılmıştır.

## Çalıştırma ve yayın

`index.html` dosyasını bir tarayıcıda açmak yeterlidir. GitHub Pages için Settings → Pages → Deploy from a branch → main → / (root) seçilir.

## Teknolojiler

HTML, CSS, JavaScript, SVG, Web Audio API ve localStorage. Yazı tipleri Google Fonts üzerinden yüklenir; yüklenemezse sistem yazı tipleri kullanılır. Harici JavaScript kütüphanesi yoktur.

## Kişiselleştirme

Başlıklar ve giriş metinleri `index.html` içindedir. Gezegen içerikleri script bölümündeki `topics` nesnesinden düzenlenebilir. Bunlar projenin keşif temalarıdır; gerçek kişi hakkında biyografik iddialar içermez.

## Tasarım ve erişilebilirlik

Mobil ekranlara uyumlu düzen, klavyeyle açılıp Escape ile kapanan diyaloglar, odak göstergeleri, etiketli kontroller ve azaltılmış hareket tercihi desteği bulunur.

## Proje fikri

Bir kişisel siteyi bilgi listesinden etkileşimli keşif alanına dönüştürmek. Tasarım ve uygulama yapay zekâ desteğiyle hazırlanmıştır.
