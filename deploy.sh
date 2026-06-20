#!/bin/bash

# Fungsi untuk menahan terminal agar tidak langsung tertutup
pause_and_exit() {
    echo ""
    read -p "Tekan Enter untuk menutup terminal..."
    exit $1
}

# Dapatkan nama branch saat ini
CURRENT_BRANCH=$(git branch --show-current)

# Pastikan kita tidak sedang berada di branch deploy
if [ "$CURRENT_BRANCH" == "deploy" ]; then
    echo "ERROR: Anda sudah berada di branch 'deploy'. Batalkan proses untuk menghindari merge ke diri sendiri."
    pause_and_exit 1
fi

echo "Branch saat ini adalah '$CURRENT_BRANCH'. Memulai proses deploy..."

# Mengecek apakah branch deploy sudah ada di lokal
if git show-ref --verify --quiet refs/heads/deploy; then
    echo "Branch 'deploy' ditemukan di lokal. Berpindah ke branch deploy..."
    if ! git checkout deploy; then
        echo "ERROR: Gagal pindah ke branch deploy. Pastikan tidak ada uncommitted changes."
        pause_and_exit 1
    fi
else
    echo "Branch 'deploy' tidak ditemukan di lokal. Mengecek ketersediaan di remote..."
    # Ambil info terbaru dari remote
    git fetch origin
    
    # Cek apakah branch deploy ada di remote
    if git ls-remote --exit-code --heads origin deploy >/dev/null 2>&1; then
        echo "Branch 'deploy' ditemukan di remote. Membuat local tracking branch..."
        if ! git checkout -b deploy origin/deploy; then
            echo "ERROR: Gagal checkout branch deploy dari remote."
            pause_and_exit 1
        fi
    else
        echo "Branch 'deploy' tidak ada di lokal maupun remote. Membuat branch 'deploy' baru..."
        if ! git checkout -b deploy; then
            echo "ERROR: Gagal membuat branch deploy baru."
            pause_and_exit 1
        fi
    fi
fi

# Merge branch sebelumnya ke branch deploy
echo "Melakukan merge dari '$CURRENT_BRANCH' ke 'deploy'..."
if ! git merge $CURRENT_BRANCH -m "Merge $CURRENT_BRANCH into deploy to trigger CI/CD"; then
    echo "ERROR: Terjadi conflict saat melakukan merge! Silakan selesaikan conflict terlebih dahulu secara manual."
    pause_and_exit 1
fi

# Push perubahan ke origin/deploy untuk memicu GitHub Actions
# Menggunakan flag -u (set-upstream) agar aman jika branch remote belum ada
echo "Mendorong (push) perubahan ke GitHub..."
if ! git push -u origin deploy; then
    echo "ERROR: Gagal melakukan push ke GitHub. Periksa koneksi atau hak akses repositori Anda."
    git checkout $CURRENT_BRANCH
    pause_and_exit 1
fi

# Kembali ke branch awal
echo "Mengembalikan ke branch awal ('$CURRENT_BRANCH')..."
git checkout $CURRENT_BRANCH

echo "SUKSES! Perubahan dari '$CURRENT_BRANCH' berhasil di-deploy (push) ke branch 'deploy' untuk memicu CI/CD."
pause_and_exit 0
