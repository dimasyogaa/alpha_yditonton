# Panduan Integrasi Continuous Integration (CI) dengan Codemagic

Dokumentasi ini berisi panduan untuk mengimplementasikan Continuous Integration (CI) dan proses *build* menggunakan layanan **Codemagic** pada proyek Flutter ini.

---

## 1. Menghubungkan Repository ke Codemagic

Langkah pertama adalah mendaftarkan proyek Anda ke platform Codemagic agar bisa saling terhubung.

1. Buka tautan [Codemagic.io](https://codemagic.io/) pada browser, lalu lakukan registrasi atau login. Sangat disarankan memilih opsi **Login menggunakan akun GitHub** agar proses sinkronisasi lebih mudah.
2. Setelah mendaftar dan masuk, Anda akan diminta menghubungkan Codemagic dengan repository. Pilih layanan yang Anda gunakan (**GitHub**) lalu klik **Authorize integration**.
3. Tambahkan akses Codemagic ke repository proyek Anda (`alpha_yditonton`). Anda dapat memberikan akses ke seluruh repository atau hanya repository tertentu saja.
4. Jika sudah, pilih repository `alpha_yditonton` untuk digunakan. Tentukan juga tipe proyeknya, yaitu **Flutter Application**. Setelah itu klik **Add application**.

---

## 2. Mengonfigurasi CI/CD Menggunakan `codemagic.yaml`

Sebenarnya Anda bisa mengonfigurasi *workflow* secara manual melalui UI (tampilan web) Codemagic yang biasa disebut *Default Workflow*. Namun, **praktik terbaik (best practice)** adalah menyimpannya dalam bentuk kode menggunakan file `codemagic.yaml`.

Pada proyek ini, file `codemagic.yaml` sudah disiapkan untuk menjalankan *dependencies fetching*, *unit test*, dan proses *build APK*.

**Langkah Mengaktifkan Mode YAML di Codemagic:**
1. **Pastikan Anda telah melakukan `git commit` dan `push`** (*deploy*) file `codemagic.yaml` ini ke GitHub repository Anda agar server Codemagic bisa menemukannya.
2. Di halaman pengaturan aplikasi Anda di Codemagic, perhatikan bagian tengah layar di sebelah *dropdown* **Workflow: Default Workflow**.
3. Klik teks tautan bertuliskan **"Switch to YAML configuration"**.
4. Codemagic akan otomatis beralih mode dan langsung membaca skrip CI/CD yang ada di dalam repository Anda.
5. Setelah itu, klik tombol biru **Start your first build** di sudut kanan atas untuk memicu proses *testing* dan *build* untuk pertama kalinya.

---

## 3. Mendapatkan Hasil Build (APK)

Setelah proses CI/CD selesai berjalan di Codemagic:
1. Anda tidak perlu selalu memantau prosesnya. Saat proses selesai (sukses/gagal), Anda akan mendapat **notifikasi melalui email**.
2. Di dalam email tersebut, apabila sukses, akan ada tautan untuk langsung mengunduh *artifact* berupa file `.apk`.
3. Anda juga bisa mengunduhnya secara langsung di *dashboard* Codemagic pada menu **Builds**. File apk hasil *build* dapat langsung di-install ke perangkat Android Anda.

---

## 4. Menambahkan Build Status Badges Codemagic ke README

Agar status build terbaru selalu terlihat, kita bisa menambahkan *Codemagic Badge* di file `README.md`.

Format Markdown yang digunakan adalah:
```markdown
[![Codemagic build status](https://api.codemagic.io/apps/<app-id>/<workflow-id>/status_badge.svg)](https://codemagic.io/app/<app-id>/<workflow-id>/latest_build)
```

**Cara Mengisi Parameter:**
1. **`<app-id>`**: Dapatkan dari URL saat Anda membuka aplikasi di Codemagic UI. Salin teks ID yang berada setelah `https://codemagic.io/app/`. (Contoh: `5fcd4dc959d78f8de3d0af97`).
2. **`<workflow-id>`**: Ini adalah nama *workflow* yang didefinisikan di dalam `codemagic.yaml`. Pada proyek ini, gunakan ID: `release-workflow`.

Sehingga contoh penerapannya di `README.md` nanti akan terlihat seperti ini:
```markdown
[![Codemagic build status](https://api.codemagic.io/apps/masukkan_app_id_anda/release-workflow/status_badge.svg)](https://codemagic.io/app/masukkan_app_id_anda/release-workflow/latest_build)
```

---

## 5. FAQ (Pertanyaan yang Sering Diajukan)

**Q: Jika saat awal saya menghubungkan repository menggunakan opsi "Add URL manually", apakah ke depannya bisa diubah menggunakan integrasi langsung seperti opsi "GitHub"?**

**A:** Ya, tentu saja bisa diubah! Anda bebas mengubah cara proyek terhubung kapan pun tanpa harus khawatir kehilangan konfigurasi CI/CD Anda. 

Jika ke depannya Anda ingin beralih menggunakan opsi integrasi **GitHub**, Anda bisa melakukan salah satu dari dua cara berikut:
1. **Mengubah via Pengaturan Aplikasi (Settings):** Masuk ke halaman aplikasi Anda di Codemagic, buka pengaturan repository, dan ubah metode otentikasi/koneksinya agar langsung terhubung ke akun GitHub Anda yang telah diotorisasi (*Authorized*).
2. **Membuat Ulang Koneksi (Add new application):** Anda bisa menghapus proyek Codemagic yang menggunakan URL manual tersebut, lalu membuat proyek baru (*Add application*) dengan memilih opsi integrasi **GitHub**. Codemagic akan secara cerdas otomatis mendeteksi file `codemagic.yaml` yang sudah ada di repository Anda, sehingga seluruh pengaturan *testing* dan *build* akan langsung berjalan sempurna tanpa perlu Anda seting ulang dari nol!

**Q: Apa saja limitasi atau Fair Usage Policy (FUP) untuk pengguna akun Personal (Gratis) di Codemagic?**

**A:** Untuk pengguna tier gratis (*Free Personal Account*), Codemagic memberikan fasilitas yang terbilang sangat cukup untuk pengembangan proyek pribadi dan pembelajaran, dengan batasan (FUP) sebagai berikut:
1. **500 Menit Build per Bulan:** Anda mendapatkan kuota gratis sebanyak 500 menit setiap bulannya. Kuota ini akan di-reset (diperbarui) kembali pada tanggal 1 bulan berikutnya.
2. **1 Proses Build Bersamaan (*1 Concurrent Build*):** Anda hanya bisa menjalankan maksimal 1 *build* dalam satu waktu. Jika ada banyak *push* dalam waktu berdekatan, proses *build* yang lainnya akan diantrekan (*queued*) sampai *build* yang pertama selesai.
3. **Pilihan Mesin Build (Instance):** Pengguna gratis dapat menggunakan mesin *virtual* standar seperti **Linux** (sangat cepat untuk build Android), Windows, dan macOS Standard (Intel). Untuk mesin premium (macOS Apple Silicon seri M), biasanya diperuntukkan khusus pengguna berbayar.
4. **Batas Durasi Maksimal (Timeout):** Secara *default*, batas waktu maksimal untuk 1 kali proses *build* adalah 60 menit (atau maksimal 120 menit). Jika proses memakan waktu lebih lama dari itu, *build* akan otomatis dihentikan oleh sistem.

**Q: Kalau begitu, apakah saya bisa mem-build aplikasi Flutter ke versi iOS (file .ipa) tanpa harus memiliki perangkat MacBook/Mac?**

**A:** **Sangat bisa!** Itulah salah satu keuntungan terbesar menggunakan layanan CI/CD seperti Codemagic. Codemagic akan menyediakan mesin *virtual macOS* di *cloud* untuk melakukan proses *build* ke iOS. Jadi, meskipun Anda mengembangkan aplikasi menggunakan sistem operasi Windows atau Linux, Anda tetap bisa mem-build aplikasi iOS dan mendapatkan file *artifact*-nya, asalkan konfigurasinya (*dependencies*, *signing*, dll) sudah diatur dengan benar di `codemagic.yaml`.
**Q: Lalu jika sudah berhasil mem-build file `.ipa`, apakah proses *upload* ke TestFlight atau App Store tetap membutuhkan MacBook?**

**A:** **Sama sekali TIDAK!** Semua proses dari hulu ke hilir bisa dilakukan tanpa Mac fisik. Anda bisa mengotomatisasi proses pengiriman aplikasi langsung ke TestFlight dari Codemagic. 

Syaratnya, Anda hanya perlu membuat *App Store Connect API Key* (berupa *Issuer ID*, *Key ID*, dan file kunci privat) dari akun Apple Developer Anda. Data-data tersebut nantinya disimpan di dalam pengaturan *Environment Variables* Codemagic, lalu Anda tinggal menambahkan bagian `publishing` di dalam skrip `codemagic.yaml`. Dengan begitu, setelah proses *build* iOS selesai, mesin Codemagic-lah yang akan langsung terbang mengunggah (*upload*) aplikasi Anda ke sistem Apple secara otomatis!

**Q: Tapi untuk mengatur konfigurasi *native* iOS dan *permission* (seperti akses internet, kamera, dll), bukankah kita wajib membuka aplikasi Xcode di MacBook?**

**A:** **Tidak wajib!** Memang benar, memiliki aplikasi Xcode di MacBook akan membuat pengaturan *native* jauh lebih mudah karena ada antarmuka visualnya (UI). Namun, secara teknis Anda bisa melakukan semuanya langsung dari Windows atau Linux melalui VS Code Anda.
- **Konfigurasi Permission:** Pengaturan izin (permission) iOS sejatinya hanya disimpan di dalam sebuah file teks berbasis XML. Anda cukup membuka file `ios/Runner/Info.plist` di VS Code, lalu menambahkan pasangan *key-value* permission yang dibutuhkan (misalnya `NSCameraUsageDescription`) dengan cara mengetik manual.
- **App Icons & Splash Screen:** Anda tidak perlu mengaturnya lewat Xcode. Cukup gunakan *package* Flutter seperti `flutter_launcher_icons` atau `flutter_native_splash`, maka *package* tersebut yang akan otomatis meracik file *native* iOS-nya.
- **Tantangannya:** Ketiadaan perangkat Mac fisik baru akan sangat terasa menyiksa jika proyek Anda mengalami *error* di level kode *native* (Swift/Objective-C) atau jika *dependency* iOS (*CocoaPods*) bentrok. Saat hal itu terjadi, Anda terpaksa harus menebak masalah secara "buta" (*blind debugging*) hanya dengan membaca file log dari *error* di Codemagic CI/CD.

**Q: Bagaimana dengan fitur *Background Manager*, *Scheduler*, atau *Push Notification*? Bukankah itu butuh menyalakan "Capabilities" khusus yang mengharuskan kita buka Xcode di Mac?**

**A:** **Pengamatan yang sangat tajam! Ya, Anda benar.**
Untuk fitur-fitur *advanced* iOS yang membutuhkan pengaktifan **Capabilities** (seperti *Background Modes*, *Push Notifications*, atau *Sign in with Apple*), ketiadaan MacBook akan menjadi batasan yang cukup merepotkan. 

Secara teori Anda masih bisa mengakalinya dari Windows, tapi sangat **tidak disarankan**. Alasannya:
- Saat Anda menyalakan *Capabilities* di Xcode, Xcode tidak hanya mengubah `Info.plist`, melainkan ia juga membuat file khusus bernama `Runner.entitlements` dan mengubah kode di dalam file inti proyek yaitu `project.pbxproj`.
- File `project.pbxproj` ini adalah "jantung"-nya proyek iOS yang strukturnya sangat panjang, rumit, dan di-*generate* otomatis oleh mesin. Memodifikasi file ini dengan mengetik manual lewat VS Code di Windows sangat berisiko membuat seluruh *build* iOS Anda *corrupt* (rusak/gagal *compile*).
- Solusi terbaik jika Anda membutuhkan fitur *Capabilities* ini tanpa membeli MacBook adalah: meminjam Mac milik teman selama 10 menit, atau menyewa layanan *Cloud Mac* (seperti MacinCloud) hanya untuk membuka Xcode, mencentang *Capabilities* yang dibutuhkan, dan menyimpannya (*push*) kembali ke GitHub.
