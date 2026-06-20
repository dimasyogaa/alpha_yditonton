#!/bin/bash

# Dapatkan nama branch saat ini
CURRENT_BRANCH=$(git branch --show-current)

# Pastikan kita tidak sedang berada di branch deploy
if [ "$CURRENT_BRANCH" == "deploy" ]; then
    echo "Anda sudah berada di branch 'deploy'. Batalkan proses untuk menghindari merge ke diri sendiri."
    exit 1
fi

echo "Branch saat ini adalah '$CURRENT_BRANCH'. Memulai proses deploy..."

# Pindah ke branch deploy
git checkout deploy

# Merge branch sebelumnya ke branch deploy
git merge $CURRENT_BRANCH -m "Merge $CURRENT_BRANCH into deploy to trigger CI/CD"

# Push perubahan ke origin/deploy untuk memicu GitHub Actions
git push origin deploy

# Kembali ke branch awal
git checkout $CURRENT_BRANCH

echo "Selesai! Berhasil memicu CI/CD dan kembali ke branch '$CURRENT_BRANCH'."
