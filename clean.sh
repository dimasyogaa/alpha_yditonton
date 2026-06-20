#!/bin/bash

echo "Memulai proses flutter clean untuk semua modul..."

# Array dari modul-modul yang ada
modules=("core" "movie" "tv" "search" "about")

# Clean di root project
echo "======================================"
echo "Cleaning root project (yditonton)..."
echo "======================================"
flutter clean

# Looping ke masing-masing modul
for module in "${modules[@]}"; do
    if [ -d "$module" ]; then
        echo "======================================"
        echo "Cleaning module: $module..."
        echo "======================================"
        cd "$module" || exit
        flutter clean
        cd ..
    else
        echo "Modul $module tidak ditemukan, dilewati."
    fi
done

echo "======================================"
echo "✨ Proses clean selesai untuk root dan semua modul! ✨"
echo "======================================"
