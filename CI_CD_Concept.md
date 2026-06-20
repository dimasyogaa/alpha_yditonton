# Konsep Continuous Integration (CI/CD)

Continuous Integration (CI) adalah praktik pengembangan perangkat lunak di mana pengembang secara teratur menggabungkan kode mereka ke repositori utama (misalnya GitHub). Setiap penggabungan (*push*) kemudian diverifikasi oleh proses pembuatan aplikasi (*build*) dan pengujian (*test*) otomatis.

Sesuai kriteria submission Dicoding:
- Pengujian otomatis dijalankan setiap kali ada *push* kode.
- Menampilkan *build status badge* pada berkas `README.md`.
- Melampirkan *screenshot* salah satu *build* yang sukses.

## Apa yang Perlu Anda Lakukan Nanti?

Jika Anda menggunakan **GitHub Actions**:
1. Buat folder `.github/workflows/` di root proyek Anda.
2. Buat file `main.yml` di dalam folder tersebut dengan isi skrip otomatis yang akan menjalankan `flutter pub get` dan `flutter test` untuk semua modul proyek.
3. Lakukan `git push` ke GitHub repository Anda (pastikan public).
4. GitHub Actions otomatis berjalan di tab **Actions** repository Anda.
5. Setelah sukses, tambahkan **Badge Status** ke `README.md` Anda. Anda dapat mengambil *markdown link*-nya dari tab Actions.
6. Jangan lupa melakukan tangkapan layar (*screenshot*) saat *build* sukses sebagai lampiran pengumpulan tugas.

Jika Anda menggunakan **Codemagic**:
1. Login ke [Codemagic](https://codemagic.io/) menggunakan akun GitHub Anda.
2. Tambahkan proyek aplikasi ini ke Codemagic.
3. Konfigurasikan *workflow* untuk menjalankan *flutter test*.
4. Memicu *build* secara manual atau melalui *push*.
5. Ambil *URL Badge* dari Codemagic dan tempelkan di `README.md`.
