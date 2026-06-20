# Struktur Proyek Aplikasi Ditonton

Dokumen ini menjelaskan daftar direktori dan berkas **kustom (buatan pengembang)** yang krusial untuk menjalankan dan memahami arsitektur aplikasi Ditonton. Berkas atau direktori bawaan Flutter (seperti `android/`, `ios/`, `build/`, `.dart_tool/`, dll.) **tidak** disertakan dalam dokumentasi ini.

Proyek ini telah menerapkan **Modularisasi**, sehingga kode terbagi ke dalam beberapa *package* lokal untuk pemisahan tugas (*separation of concerns*) yang lebih baik.

## 📁 Direktori Utama & Modul

*   **`lib/`**
    Direktori utama berjalannya aplikasi.
    *   **`main.dart`**: *Entry point* dari keseluruhan aplikasi. Di sini kita menginisialisasi rute, *Dependency Injection*, *SSL Pinning*, Firebase (Analytics & Crashlytics), serta mendaftarkan semua BLoC *Provider*.
    *   **`injection.dart`**: Tempat mengatur *Dependency Injection* menggunakan pustaka `get_it`. Menampung registrasi *repository*, *data source*, BLoC, hingga utilitas eksternal seperti *database* dan HTTP *client*.
    *   **`firebase_options.dart`**: Berkas hasil generasi otomatis `flutterfire configure` yang menyimpan *API Keys* dan ID proyek Firebase Anda.
*   **`core/`**
    Modul fondasi utama aplikasi. Semua modul lain bergantung pada `core`.
    *   Berisi utilitas bersama: *Database Helper* (SQLite), HTTP *client* dengan SSL Pinning (`HttpSSLPinning`), *Network Info*, gaya visual (*styles*/tema), kelas kegagalan (*failure*), serta *widget* yang digunakan berulang kali di banyak halaman.
*   **`movie/`**
    Modul yang menangani keseluruhan fitur Film (*Movies*).
    *   Mencakup alur arsitektur bersih (*Clean Architecture*): `data` (sumber data API/lokal), `domain` (entitas dan *use cases*), serta `presentation` (UI halaman dan BLoC).
*   **`tv/`**
    Modul yang menangani keseluruhan fitur Serial Televisi (*TV Series*).
    *   Juga menerapkan *Clean Architecture* layaknya modul `movie`. Terdapat tambahan detail kompleks seperti daftar *Season* dan *Episode*.
*   **`search/`**
    Modul fungsional untuk fitur Pencarian.
    *   Berisi logika presentasi (BLoC & Halaman) pencarian baik untuk *Movie* maupun *TV Series*.
*   **`about/`**
    Modul sederhana yang berisi halaman "Tentang Aplikasi" (About Page).

## 📄 Berkas dan Direktori Pendukung Krusial

*   **`certificates/`**
    Menyimpan sertifikat keamanan `themoviedb.pem`. Berkas ini sangat vital untuk menjalankan fitur **SSL Pinning** saat aplikasi berkomunikasi dengan API penyedia data.
*   **`test.sh`**
    Skrip otomatisasi yang ditulis menggunakan `bash` untuk mengeksekusi semua tes (unit dan *widget*) secara sekuensial di semua modul (`core`, `movie`, `tv`, `search`, `about`, dll.). Skrip ini juga berjasa menghasilkan laporan gabungan kode (*Code Coverage Report*).
*   **`pubspec.yaml`** (di tingkat akar/root)
    Selain mendaftarkan paket pub.dev secara umum, berkas ini mengaitkan semua modul lokal di atas menggunakan parameter `path:` sehingga *root project* (aplikasi utama) bisa merangkai keseluruhan sistem.
*   **`firebase.json`** (di tingkat akar/root)
    Berkas pengaturan dari Firebase CLI yang berfungsi menghubungkan aplikasi Flutter Anda di setiap *platform* dengan ID Aplikasi yang terdaftar di Firebase Console.
*   **`integration_test/`**
    Tempat bersemayam kode untuk pengujian integrasi (*End-to-End Testing*) yang bertugas mensimulasikan penggunaan aplikasi oleh *user* sungguhan secara otomatis.
