# Kriteria Submission

Berikut adalah tabel status pengerjaan kriteria untuk proyek ini berdasarkan pengecekan saat ini:

| Kriteria | Tipe | Status | Keterangan |
| :--- | :---: | :---: | :--- |
| Menerapkan Continuous Integration (CI) | Utama | ✅ Selesai | Sudah dibuatkan berkas konfigurasi GitHub Actions di `.github/workflows/main.yml` |
| Menggunakan Library BLoC | Utama | ✅ Selesai | Sudah terimplementasi dan ada `flutter_bloc` pada `pubspec.yaml` |
| Menerapkan SSL Pinning | Utama | ✅ Selesai | Sudah diimplementasikan melalui `HttpSSLPinning` dan sertifikat `themoviedb.pem` |
| Integrasi Firebase Analytics & Crashlytics | Utama | ✅ Selesai | *Library* `firebase_analytics` & `firebase_crashlytics` telah ditambahkan dan logika pemantauan diimplementasikan di `main.dart` |
| Modularisasi | Opsional | ✅ Selesai | Proyek sudah dibagi menjadi modul `movie`, `tv`, `core`, `search`, dan `about` |
| Season & Episode TV Series | Saran | ✅ Selesai | Fitur *season* & *episode* sudah diimplementasikan beserta BLoC-nya |
| Widget dan Integration Test | Saran | ✅ Selesai | Sudah terdapat penambahan skenario *widget test* & *integration test* di setiap modul |
| Test Coverage >95% | Saran | ✅ Selesai | Seluruh modul sudah mencapai *code coverage* 100% |
| Clean Code & Dart Convention | Saran | ✅ Selesai | Sudah menggunakan `flutter_lints` dan kaidah penulisan Dart |

Terdapat beberapa kriteria utama yang harus Anda penuhi untuk mengembangkan aplikasi Ditonton kali ini.

## Menerapkan Continuous Integration

* Menjalankan pengujian aplikasi secara otomatis. Semua pengujian harus tetap terpenuhi dan mempertahankan fitur dari submission sebelumnya.
* Dijalankan setiap ada push kode terbaru ke dalam repository.
* Anda perlu mengunggah kode ke dalam GitHub repository milik Anda sendiri lalu mencantumkan tautannya sebagai catatan (pastikan repository yang digunakan adalah repository public).
* Menampilkan build status badge pada berkas readme repository GitHub. (Contoh dengan Codemagic).
* Melampirkan screenshot salah satu build dari CI service berupa lampiran (attachment file).
* Anda bebas menggunakan layanan CI apa pun untuk submission.

## Menggunakan Library BLoC

* Melakukan migrasi state management yang sebelumnya menggunakan provider menjadi BLoC.

## Menerapkan SSL Pinning

* Memasang sertifikat SSL pada aplikasi sebagai lapisan keamanan tambahan untuk mengakses data dari API.

## Integrasi dengan Firebase Analytics & Crashlytics

* Memastikan developer tetap mendapat feedback dari pengguna, khususnya terkait stabilitas dan laporan eror. 
* Ditunjukkan dengan screenshot halaman Analytics dan Crashlytics.

---

# Kriteria Opsional Submission

Selain kriteria utama, terdapat beberapa kriteria opsional yang dapat Anda penuhi agar mendapat nilai yang lebih baik.

## Modularisasi

* Membagi aplikasi menjadi modul setidaknya untuk dua fitur movie & TV series.

---

# Kriteria Penilaian Submission

Submission Anda akan dinilai oleh reviewer untuk menentukan nilai submission yang Anda kerjakan.

Submission Anda akan dinilai oleh reviewer dengan skala 1-5. Untuk mendapatkan nilai tinggi, Anda bisa menerapkan beberapa saran berikut:

* Menyelesaikan kriteria opsional, yaitu season & episode.
* Menambahkan Widget dan integration test untuk menguji aplikasi.
* Menerapkan >95% test coverage.
* Menuliskan kode dengan bersih, mudah dibaca, dan memenuhi code convention Dart.

Berikut adalah detail penilaian submission:

* **Bintang 1** : Semua ketentuan wajib terpenuhi, namun terdapat indikasi kecurangan dalam mengerjakan submission.
* **Bintang 2** : Semua ketentuan wajib terpenuhi, tetapi terdapat kekurangan pada penulisan kode.
* **Bintang 3** : Semua ketentuan wajib terpenuhi, tetapi tidak ada improvisasi atau persyaratan opsional yang dipenuhi.
* **Bintang 4** : Semua ketentuan wajib terpenuhi dan menerapkan minimal satu saran di atas.
* **Bintang 5** : Semua ketentuan wajib terpenuhi dan menerapkan seluruh saran di atas.

> **Catatan:**
> Jika submission Anda ditolak maka tidak ada penilaian. Kriteria penilaian bintang di atas hanya berlaku jika submission Anda lulus.

---

# Ketentuan Berkas Submission

* Pastikan Anda melampirkan tautan repository GitHub pada student notes.
* Pastikan repository bersifat publik bukan privat.
* Berkas submission yang dikirim merupakan folder proyek ditonton dalam bentuk ZIP. 
* Pastikan Anda hapus dulu folder build pada folder proyek sebelum mengkompresi dalam bentuk ZIP.
* Jika ukuran berkas Zip > 25MB, Anda dapat mengupload projek Flutter Anda ke dalam GitHub terlebih dahulu, kemudian unduh projek tersebut as Zip.

---

# Submission akan ditolak bila

* Kriteria wajib tidak terpenuhi.
* Ketentuan berkas submission tidak terpenuhi.
* Proyek yang Anda kirim tidak dapat dijalankan dengan baik.
* Aplikasi mengalami eror.
* Menggunakan bahasa pemrograman dan teknologi selain Flutter.
* Melakukan kecurangan seperti tindakan plagiarisme.
* Tidak menggunakan versi Flutter yang terbaru.
