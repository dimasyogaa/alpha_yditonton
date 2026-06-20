# Panduan Konfigurasi Firebase CLI (Flutterfire)

Dokumen ini berisi panduan tahap demi tahap untuk menghubungkan aplikasi Anda dengan _project_ Firebase menggunakan akun Google pribadi Anda, menggantikan akun perusahaan Anda sebelumnya.

Karena integrasi kode Dart (`firebase_core`, `firebase_analytics`, `firebase_crashlytics`) sudah diselesaikan, Anda hanya perlu menjalankan langkah-langkah *setup* CLI berikut di komputer Anda.

## Prasyarat
1. **Akun Google/Firebase**: Pastikan Anda sudah login ke [Firebase Console](https://console.firebase.google.com/) menggunakan akun Google pribadi Anda.
2. **Node.js**: Pastikan Anda sudah menginstal Node.js di sistem Anda agar bisa memasang Firebase Tools.

## Langkah-langkah Integrasi

### 1. Buat Proyek Firebase Baru
1. Buka [Firebase Console](https://console.firebase.google.com/).
2. Klik **"Add project"** (Buat proyek).
3. Beri nama proyek Anda (contohnya `DFE - YDitonton` seperti yang sudah Anda buat).
4. Pastikan fitur **Google Analytics** dalam keadaan AKTIF (Enable) saat ditawarkan. Ini wajib karena kita menguji Firebase Analytics.
5. Selesaikan proses pembuatan.

### 2. Instal Firebase CLI & Login
Buka terminal Anda (Command Prompt/PowerShell/Git Bash) dan jalankan perintah berikut secara berurutan:

```bash
# Instal Firebase CLI secara global menggunakan NPM
npm install -g firebase-tools

# Login ke Firebase (Gunakan akun Google pribadi Anda yang baru)
firebase login
```
Jika diminta, pilih *Allow/Izinkan* di *browser* Anda.

### 3. Instal Flutterfire CLI
Alat ini adalah "jembatan" otomatis dari Google untuk memasangkan aplikasi Flutter dengan proyek Firebase Anda.

```bash
# Instal alat FlutterFire
dart pub global activate flutterfire_cli
```

### 4. Konfigurasi Proyek (Langkah Terpenting!)
Pastikan Anda sedang berada di direktori akar (`root`) dari proyek `yditonton` Anda di terminal, lalu jalankan:

```bash
flutterfire configure
```
1. Alat ini akan meminta Anda memilih **proyek Firebase** (pilih proyek `DFE - YDitonton` yang baru saja Anda buat).
2. Anda akan diminta memilih *platform* target. Secara *default*, `android`, `ios`, dan `web` biasanya sudah terpilih (ditandai dengan `√`). Gunakan **tombol panah** untuk navigasi dan tombol **Spasi** untuk mencentang/menghapus centang (misal, hapus centang `web` jika tidak butuh). Setelah selesai, tekan **Enter**.
3. Biarkan skrip berjalan. Secara otomatis ia mendaftarkan aplikasi Anda ke server Firebase, membuat file pengaturan `firebase.json` di direktori utama proyek, serta satu berkas sakti bernama `firebase_options.dart` di dalam folder `lib/`. 

*(Catatan: Saya telah membuat `firebase_options.dart` sementara sebagai *placeholder* agar kode Anda tidak merah. Perintah di atas akan menimpa file sementara saya dengan kredensial asli Anda!)*

### 5. Inisialisasi Firebase di Kode (Dart)

Setelah konfigurasi CLI selesai, langkah terakhir adalah mengaktifkan Firebase di dalam kode aplikasi Anda:

1. Buka file `lib/main.dart`.
2. Pastikan Anda mengimpor paket yang dibutuhkan dan file konfigurasi:
   ```dart
   import 'package:firebase_core/firebase_core.dart';
   import 'package:firebase_crashlytics/firebase_crashlytics.dart';
   import 'firebase_options.dart';
   ```
3. Ubah fungsi `main()` Anda menjadi `async` dan tambahkan inisialisasi Firebase beserta *error handler* untuk Crashlytics:
   ```dart
   void main() async {
     // Wajib dipanggil sebelum inisialisasi Firebase
     WidgetsFlutterBinding.ensureInitialized();
     
     // 1. Inisialisasi Firebase
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
     
     // 2. Kirim semua fatal error (error UI/Framework) ke Crashlytics
     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
     
     // 3. Kirim semua error asynchronous (error logika/background) ke Crashlytics
     PlatformDispatcher.instance.onError = (error, stack) {
       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
       return true;
     };
     
     // ...kode inisialisasi lainnya...
     runApp(const MyApp());
   }
   ```
4. **(Khusus Firebase Analytics)**: Berbeda dengan Crashlytics yang perlu didaftarkan di fungsi `main()`, untuk merekam analitik otomatis per halaman (*screen views*), Anda bisa melihat implementasinya pada `class MyApp` di mana kita membuat *observer*:
   ```dart
   static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
   static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
   ```
   Dan memasukkannya ke dalam `navigatorObservers` di dalam `MaterialApp`. (Ini sudah terpasang secara _default_ di kodingan proyek Anda!)

### 6. Selesai!
Setelah kode ditambahkan, Anda bisa langsung menjalankan aplikasi seperti biasa (`flutter run`). Firebase Analytics dan Crashlytics akan secara otomatis aktif mengirimkan data penggunaan halaman dan mendeteksi *error* jika ada yang terjadi.

## Tambahan: Mengelola Banyak Akun Firebase CLI

Jika Anda memiliki lebih dari satu akun Google (misalnya akun perusahaan dan akun pribadi), Anda dapat mengelola multi-akun di CLI tanpa perlu _logout_ bolak-balik:

### 1. Cek Akun Aktif & Daftar Akun Terpasang
Untuk melihat akun mana yang sedang aktif digunakan dan siapa saja yang sudah *login* di perangkat Anda:
```bash
firebase login:list
```
*(Akun yang sedang aktif biasanya ditandai dengan bintang `*` atau keterangan `current`)*

### 2. Menambah Akun Baru (Tanpa Menghapus yang Lama)
Jika Anda ingin menambahkan akun Firebase lain tanpa me-logout akun yang sudah ada:
```bash
firebase login:add
```
*(Perintah ini akan membuka browser untuk proses login, dan akun yang baru ditambahkan ini akan otomatis menjadi akun yang aktif digunakan)*

### 3. Berpindah Akun (Switch Account)
Untuk beralih menggunakan akun lain yang sudah pernah didaftarkan sebelumnya:
```bash
firebase login:use emailanda@gmail.com
```
*(Ganti `emailanda@gmail.com` dengan alamat email dari daftar `firebase login:list`)*

### 4. Menghapus / Logout Akun Tertentu
Jika Anda ingin mengeluarkan salah satu akun saja dari perangkat:
```bash
firebase logout emailanda@gmail.com
```

## FAQ (Pertanyaan yang Sering Diajukan)

**Q: Saat menjalankan `flutterfire configure`, apakah pilihan platform (Android, iOS, Web, dll) bersifat permanen? Apakah bisa diubah ke depannya?**

**A:** Tidak permanen, dan **bisa diubah kapan saja**. Jika di masa depan Anda ingin menambahkan dukungan untuk platform lain (misalnya Web, macOS, atau Windows), Anda cukup menjalankan ulang perintah `flutterfire configure` di terminal. Alat ini akan meminta Anda memilih platform kembali, dan akan secara otomatis memperbarui file konfigurasi `firebase_options.dart` tanpa merusak integrasi yang sudah berjalan.

**Q: Saya sudah menjalankan `flutterfire configure`, tapi di Firebase Console (bagian Analytics / Crashlytics) masih muncul layar "Add an app to get started". Apakah saya harus mendaftarkannya lagi?**

**A:** **TIDAK PERLU**. Perintah `flutterfire configure` sudah 100% otomatis mendaftarkan aplikasi Anda. Layar tersebut muncul hanya karena Firebase sedang menunggu aplikasi Anda dijalankan untuk pertama kalinya agar SDK dapat mengirimkan data perdana. Cukup jalankan aplikasi Anda (`flutter run`), lakukan satu *test crash* (lalu _restart_ app), maka setelah data terkirim, layar tersebut akan otomatis berubah menjadi *Dashboard*.

**Q: Apakah layanan Analytics dan Crashlytics ini 100% gratis? Apakah ada FUP (Fair Usage Policy) atau limit kuota jika pengguna aplikasi saya nanti sangat banyak?**

**A:** **Ya, 100% GRATIS selamanya dan TANPA FUP!** Google Analytics for Firebase dan Firebase Crashlytics adalah layanan unggulan yang disediakan secara cuma-cuma oleh Google. Tidak peduli seberapa meledak jumlah *user* aktif Anda, berapa triliun *event* analitik yang masuk, atau seberapa sering aplikasi *crash*, Anda tidak akan ditagih biaya sepeser pun. Anda sepenuhnya aman menggunakan paket bawaan (Spark Plan - No cost).
## Cara Menguji Integrasi Analytics & Crashlytics

Setelah integrasi selesai, Anda dapat memverifikasi apakah kedua layanan ini sudah berjalan dengan baik.

### Menguji Firebase Crashlytics
1. Buka salah satu file halaman/widget di proyek Anda (misalnya di halaman utama).
2. Tambahkan sebuah tombol sementara yang saat ditekan akan secara sengaja melempar *error* / *crash*.
   ```dart
   ElevatedButton(
     onPressed: () {
       // Melempar error secara sengaja untuk mengetes Crashlytics
       throw Exception("Ini adalah test crash manual dari YDitonton!");
       // Atau alternatif jika package sudah diimport: FirebaseCrashlytics.instance.crash();
     },
     child: const Text("Test Crash"),
   )
   ```
3. Jalankan aplikasi di perangkat fisik atau emulator.
4. Tekan tombol tersebut hingga aplikasi Anda mengalami *Force Close* (tertutup paksa karena *crash*).
5. **Penting**: Buka kembali aplikasi Anda (restart app). Laporan *crash* baru dikirimkan ke server Firebase pada saat aplikasi dibuka kembali *setelah* crash terjadi.
6. Buka [Firebase Console](https://console.firebase.google.com/) -> Pilih proyek Anda -> Masuk ke menu **Crashlytics**. 
   *(Catatan: Laporan crash pertama kali mungkin membutuhkan waktu sekitar 5 menit untuk diproses dan muncul di dasbor).*

### Menguji Firebase Analytics
1. Firebase Analytics secara *default* sudah otomatis merekam *event* dasar (seperti `screen_view` saat layar berpindah).
2. Untuk memverifikasinya secara _real-time_ tanpa harus menunggu pemrosesan 24 jam, aktifkan fitur **DebugView** di Android Anda.
3. Hubungkan perangkat Anda, buka terminal, lalu jalankan perintah ADB berikut:
   ```bash
   adb shell setprop debug.firebase.analytics.app com.dicoding.ditonton
   ```
   *(Pastikan `com.dicoding.ditonton` adalah package name/application ID aplikasi Anda).*
4. Buka kembali aplikasi Anda (`flutter run`). Cobalah berpindah-pindah halaman atau menekan beberapa tombol.
5. Buka [Firebase Console](https://console.firebase.google.com/) -> Masuk ke menu **Analytics** -> **DebugView**.
6. Aktivitas perangkat Anda seharusnya mulai bermunculan pada _timeline_ di halaman DebugView dalam beberapa detik!
