#!/bin/bash

echo "Memulai proses flutter pub get untuk root dan semua modul..."

# Array dari modul-modul yang ada
modules=("core" "movie" "tv" "search" "about")

# Pub get di root project
echo "======================================"
echo "Mendapatkan dependensi untuk root project (yditonton)..."
echo "======================================"
flutter pub get

# Looping ke masing-masing modul
for module in "${modules[@]}"; do
    if [ -d "$module" ]; then
        echo "======================================"
        echo "Mendapatkan dependensi untuk modul: $module..."
        echo "======================================"
        # Menggunakan subshell agar direktori tetap aman jika terjadi error
        (cd "$module" && flutter pub get)
    else
        echo "Modul $module tidak ditemukan, dilewati."
    fi
done

echo "======================================"
echo "Selesai! Semua dependensi berhasil diunduh. 🚀"
echo "======================================"
