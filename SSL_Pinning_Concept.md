# Konsep SSL Pinning

SSL Pinning adalah metode keamanan untuk memastikan bahwa aplikasi mobile berkomunikasi hanya dengan server asli dan tepercaya. Aplikasi akan memeriksa keaslian sertifikat SSL/TLS server sebelum melakukan permintaan HTTPS (*handshake*). Hal ini mencegah serangan *Man-in-the-Middle* (MitM) jika seseorang mencoba menggunakan sertifikat palsu.

Sesuai kriteria submission Dicoding:
- Anda harus memasang sertifikat dari TheMovieDB API ke dalam aplikasi.

## Apa yang Perlu Anda Lakukan Nanti?

1. **Unduh Sertifikat Rantai (Certificate Chain)**:
   Gunakan perintah terminal atau browser untuk mengunduh sertifikat dari `api.themoviedb.org`.
   ```bash
   echo -n | openssl s_client -showcerts -connect api.themoviedb.org:443 </dev/null 2>/dev/null | openssl x509 -outform PEM > themoviedb.pem
   ```
2. **Simpan di Assets**:
   Buat folder `certificates/` dan simpan file `.pem` tersebut di dalamnya.
3. **Daftarkan di `pubspec.yaml`**:
   Pastikan sertifikat dapat diakses aplikasi dengan mendaftarkannya di bagian `assets`.
   ```yaml
   flutter:
     assets:
       - certificates/themoviedb.pem
   ```
4. **Implementasi `SecurityContext` di Dart**:
   Buat konfigurasi *HTTP Client* (seperti `IOClient`) yang membaca sertifikat tersebut menggunakan `SecurityContext(withTrustedRoots: false)` dan menyetel *trusted certificates*.
5. **Gunakan Klien Aman**:
   Gantikan instance `http.Client` biasa yang Anda *inject* (melalui `get_it`) dengan *HTTP Client* yang sudah dipasangi sertifikat ini. Semua pemanggilan API (*Remote Data Source*) akan otomatis dilindungi SSL Pinning.
