# Dokumentasi Continuous Integration (CI/CD)

Continuous Integration (CI) adalah praktik pengembangan perangkat lunak di mana pengembang secara teratur menggabungkan kode mereka ke repositori utama (misalnya GitHub). Pada proyek ini, setiap penggabungan (*push*) atau *pull request* ke branch `deploy` akan diverifikasi secara otomatis menggunakan **GitHub Actions**.

## Konfigurasi GitHub Actions

Proyek ini telah dikonfigurasi untuk menjalankan *automated testing* secara otomatis. 

- **File Workflow**: `.github/workflows/main.yml`
- **Tugas yang Dijalankan**:
  1. `flutter pub get` untuk mengunduh semua *dependencies* (root dan semua modul).
  2. `flutter test` untuk menjalankan seluruh *unit test* secara otomatis di setiap modul.

## Kriteria Submission Dicoding

Sesuai dengan kriteria submission Dicoding, proyek ini telah memenuhi:
- [x] Pengujian otomatis dijalankan setiap kali ada *push* kode.
- [x] Menampilkan *build status badge* pada berkas `README.md`.
- [ ] Melampirkan *screenshot* salah satu *build* yang sukses saat pengumpulan tugas.

---

## Tutorial Mengambil Build Status Badge Secara Manual

Jika Anda perlu memperbarui atau mengambil *Build Status Badge* GitHub Actions secara manual untuk diletakkan di file `README.md`, ikuti langkah-langkah berikut:

1. Buka repositori proyek ini di situs web **GitHub**.
2. Klik tab **Actions** yang berada di bagian atas halaman repositori (bersebelahan dengan tab *Pull requests*).
3. Pada panel menu di sebelah kiri, klik nama *workflow* yang telah dibuat (misalnya **Flutter CI**).
4. Perhatikan di pojok kanan atas halaman *workflow* (tepat di bawah deretan menu navigasi atas), terdapat tombol berikon titik tiga (**...**). Klik tombol tersebut, lalu pilih **Create status badge**.
5. Akan muncul sebuah *dialog box*. Pada bagian *Branch*, pastikan Anda memilih branch yang digunakan (misalnya `main` atau `deploy`).
6. Klik tombol **Copy status badge Markdown** untuk menyalin kodenya.
7. Buka file `README.md` di proyek/IDE Anda, lalu *paste* (tempelkan) kode markdown tersebut (idealnya di bagian paling atas).

**Contoh Format Markdown Badge dari GitHub:**
```markdown
[![Flutter CI](https://github.com/dimasyogaa/alpha_yditonton/actions/workflows/main.yml/badge.svg)](https://github.com/dimasyogaa/alpha_yditonton/actions/workflows/main.yml)
```
