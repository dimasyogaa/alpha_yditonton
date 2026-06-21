# Y Ditonton - Project Documentation

Dokumentasi ini dibuat untuk memudahkan proses navigasi dan *maintenance* proyek di masa depan. Proyek ini mengadopsi berbagai konsep _Advanced Flutter_ termasuk Modularisasi, BLoC State Management, SSL Pinning, dan CI/CD.

## 1. Arsitektur Proyek (Modularisasi)
Proyek ini memecah fitur menjadi beberapa *module* (package) terpisah agar struktur kode lebih rapi dan dapat digunakan ulang secara independen:
- **`core/`**: Berisi fondasi utama aplikasi seperti utilitas (SSL Pinning, Database Helper), konstanta warna/tema, model umum, serta *dependency injection* yang digunakan lintas modul.
- **`movie/`**: Berisi keseluruhan fitur terkait Film (Movies) mulai dari Data Layer (API/Database), Domain Layer (UseCases), hingga Presentation Layer (UI & BLoC).
- **`tv/`**: Berisi keseluruhan fitur terkait Serial TV (TV Series), termasuk detail *season* dan *episode*, dengan struktur *Clean Architecture* yang mirip dengan modul `movie`.
- **`search/`**: Modul spesifik untuk menangani fungsionalitas pencarian film dan TV.
- **`about/`**: Modul yang hanya berisi halaman About.
- **Root Project (`lib/`)**: Sebagai *entry point* (`main.dart`), mengatur *routing* global, inisialisasi aplikasi, dan Dependency Injection (`injection.dart`).

## 2. State Management (BLoC)
Proyek ini menggunakan **BLoC (Business Logic Component)** melalui *library* `flutter_bloc` untuk memisahkan logika bisnis dari UI.
- Semua *state* kini bersifat *immutable* (`Equatable`).
- UI merespons perubahan *state* melalui `BlocBuilder` (atau `BlocConsumer`/`BlocListener`).
- Berkas BLoC biasanya berada di `[nama_modul]/lib/presentation/bloc/`.
- Ketika ada penambahan fitur/BLoC baru, selalu pastikan ia di-*register* di dalam `lib/injection.dart` dan ditambahkan ke dalam `MultiProvider` di `lib/main.dart`.

## 3. Cara Menjalankan Pengujian (Testing)
Karena proyek ini mengadopsi arsitektur modular, perintah `flutter test` di *root directory* (folder utama proyek) **hanya akan mengeksekusi *test* yang ada di dalam *root* saja**.

Untuk menjalankan *test* di seluruh modul, **Anda tidak bisa hanya menjalankannya di *root* saja**. Anda harus berpindah ke setiap modul dan menjalankan `flutter test` di dalamnya secara spesifik.

**Contoh eksekusi secara manual:**
```bash
cd core && flutter test
cd ../movie && flutter test
cd ../tv && flutter test
cd ../search && flutter test
```
*(Catatan: Anda bisa juga menggunakan skrip bantuan (seperti `test.sh` atau `test.bat`) yang berisi daftar perintah di atas agar otomatis dieksekusi sekaligus).*

## 4. Keamanan (SSL Pinning)
Aplikasi ini dijamin keamanannya menggunakan *SSL Pinning* untuk mencegah serangan *Man-in-the-Middle* (MitM).
- Sertifikat SSL milik `api.themoviedb.org` disimpan di folder `certificates/themoviedb.pem`.
- Sertifikat ini dikonfigurasikan pada berkas `core/lib/utils/http_ssl_pinning.dart`.
- Instansiasi `http.Client` yang diamankan tersebut di-*inject* secara global melalui `lib/injection.dart` sehingga semua pemanggilan API menggunakan klien yang aman ini secara otomatis.

## 5. Continuous Integration & Delivery (CI/CD)
Proyek ini mengadopsi struktur *dual-pipeline* untuk memaksimalkan otomatisasi:
- **GitHub Actions (`.github/workflows/main.yml`)**: Digunakan sebagai palang pintu (*gatekeeper*) utama. Setiap kali ada *Push* atau *Pull Request* ke *branch* `deploy`, GitHub Actions otomatis menjalankan `flutter test` untuk memverifikasi bahwa tidak ada kode rusak yang lolos.
- **Codemagic (`codemagic.yaml`)**: Bertindak sebagai mesin *Build* dan *Continuous Delivery* (CD). Ia otomatis mengamankan *database testing*, melakukan kompilasi proyek menjadi rilis Android (`app-release.apk`), lalu mendistribusikannya secara otomatis (*Publish*). Panduan lengkap Codemagic (serta trik penanganan bug UI/server) telah dirangkum khusus di dalam berkas **`Codemagic_Integration_Guide.md`**.

## 6. Firebase Integration (Analytics & Crashlytics)
Untuk memantau stabilitas aplikasi secara langsung di tangan pengguna, proyek ini telah diintegrasikan dengan Firebase:
- **Firebase Crashlytics**: Secara otomatis merekam segala bentuk *error*, baik itu dari lapisan UI (*FlutterFatalError*) maupun *error asynchronous* di *background logic* (`PlatformDispatcher`). Laporannya dikirim langsung ke Dasbor Firebase.
- **Firebase Analytics**: Merekam pergerakan pengguna dari satu halaman ke halaman lainnya secara otomatis karena telah didaftarkan melalui `FirebaseAnalyticsObserver` di `main.dart`.
- Panduan *setup* integrasi selengkapnya (berkenaan dengan `flutterfire configure`) dapat Anda temukan secara detail di dalam berkas **`FIREBASE_INTEGRATION_GUIDE.md`**.

## 7. Skrip Otomatisasi (Shell Scripts)
Mengingat arsitektur Modularisasi yang kita pakai telah memecah aplikasi menjadi berbagai *folder* (seperti `core`, `movie`, `tv`, dll.), maka mengeksekusi perintah dasar Flutter satu per satu di tiap direktori akan sangat memakan waktu. Oleh karena itu, disediakan beberapa skrip otomatisasi di dalam *root directory* untuk membantu *developer*:

- **`pub_get.sh`**: Digunakan untuk mengunduh ulang seluruh *dependencies* (`flutter pub get`) secara otomatis di *root project* dan menyapu seluruh *sub-modul*nya. Sangat berguna untuk di-klik sesaat setelah Anda baru saja melakukan `git pull` atau berpindah *branch*. Eksekusi menggunakan perintah: `bash pub_get.sh` atau `.\pub_get.sh`.
- **`test.sh`**: Digunakan untuk memicu penjalanan *unit/widget test* (`flutter test`) secara massal di semua modul sekaligus. Skrip ini akan berkeliling ke setiap *package* untuk mengeksekusi *testing*, lalu menggabungkan hasil laporan persentasenya (Coverage Report) agar terpusat. Eksekusi menggunakan perintah: `bash test.sh` atau `.\test.sh`.
- **`clean.sh`**: Digunakan untuk membersihkan hasil-*build* (*build cache*, direktori `build/`, dll.) menggunakan perintah `flutter clean` di proyek utama beserta seluruh *sub-modul*nya. Sangat berguna ketika Anda menghadapi error kompilasi acak dan ingin me-reset *cache* aplikasi secara total. Eksekusi menggunakan perintah: `bash clean.sh` atau `.\clean.sh`.
- **`deploy.sh`**: Skrip otomatis yang langsung melakukan penggabungan *branch* (misal dari `main` ke `deploy`), melakukan *push* kode, kemudian memicu *pipeline* Codemagic. Skrip ini ditujukan untuk kepraktisan pengiriman kode (Deployment) dengan sekali klik. Eksekusi menggunakan perintah: `bash deploy.sh` atau `.\deploy.sh`.
