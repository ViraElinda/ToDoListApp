Judul Aplikasi
To-Do List App - Flutter x Laravel API (Login menggunakan Token)

Deskripsi Aplikasi
Aplikasi To-Do List ini merupakan aplikasi pencatatan tugas harian berbasis mobile dengan Flutter sebagai frontend dan Laravel sebagai backend. Aplikasi ini mendukung fitur autentikasi menggunakan token (Bearer Token) dari Laravel Sanctum.

Fitur utama aplikasi:

* Login dan register pengguna
* Menambah, mengedit, dan menghapus to-do
* Menandai tugas sebagai selesai
* Melihat daftar tugas yang dibuat
* Menyimpan token login agar tidak perlu login berulang

Halaman dalam Aplikasi
1. Splash screen
2. Halaman login
3. Halaman register
4. Halaman daftar to-do
5. Halaman tambah/edit to-do
6. Halaman profil (opsional)

Database yang Digunakan
Aplikasi ini menggunakan database MySQL. Tabel-tabel utama dalam aplikasi:

* Tabel users: menyimpan data pengguna
* Tabel personal\_access\_tokens: menyimpan token pengguna (dari Laravel Sanctum)
* Tabel todos: menyimpan data tugas yang dibuat oleh pengguna

API Backend Laravel
Backend Laravel menyediakan berbagai endpoint REST API untuk mendukung operasi aplikasi. Endpoint yang tersedia antara lain:

* Register pengguna
* Login pengguna dan menghasilkan token
* Logout pengguna (revoke token)
* Menampilkan daftar to-do milik user
* Menambahkan to-do
* Mengubah isi to-do
* Menghapus to-do

Seluruh endpoint (kecuali register dan login) memerlukan autentikasi token.

Software yang Digunakan
Backend:

* Laravel 10
* Laravel Sanctum
* Composer
* MySQL (via XAMPP)

Frontend:

* Flutter 3
* HTTP package
* Shared Preferences
* Visual Studio Code atau Android Studio

Cara Instalasi
Backend Laravel:

1. Clone proyek Laravel
2. Jalankan `composer install`
3. Duplikat file `.env.example` menjadi `.env`
4. Jalankan `php artisan key:generate`
5. Atur koneksi database di `.env`
6. Jalankan `php artisan migrate`
7. Jalankan `php artisan serve --host=(ip kamu) --port=8000`
8. Pastikan Laravel dapat diakses via IP lokal

Frontend Flutter:

1. Clone proyek Flutter
2. Jalankan `flutter pub get`
3. Pastikan IP API Laravel disesuaikan di file layanan
4. Jalankan `flutter run` pada emulator atau perangkat Android

Cara Menjalankan Aplikasi
1. Jalankan server Laravel menggunakan `php artisan serve`
2. Pastikan perangkat Android terhubung dalam jaringan yang sama dengan backend
3. Jalankan Flutter pada emulator atau perangkat fisik
4. Aplikasi akan terbuka dari halaman splash, lalu login/register, dan masuk ke halaman to-do

Identitas Pembuat
Nama: Vira Elinda Putri
Absen: 32
Kelas: XI RPL 1
