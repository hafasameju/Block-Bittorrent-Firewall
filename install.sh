#!/bin/bash

set -e

echo "📦 دانلود فایل زیپ..."
curl -L -o block_bittorrent_safe_full_package.zip "https://huggingface.co/datasets/hafasameju/bittorrent-blocker/resolve/main/block_bittorrent_safe_full_package.zip"

echo "📂 استخراج فایل‌ها..."
unzip -o block_bittorrent_safe_full_package.zip

echo "🔐 فعال‌سازی دسترسی اجرا برای اسکریپت..."
chmod +x block_bittorrent_safe.sh

echo "⚙️ نصب سرویس systemd..."
cp block_bittorrent_safe.service /etc/systemd/system/

echo "🔄 ریست systemd..."
systemctl daemon-reexec
systemctl daemon-reload

echo "✅ فعال‌سازی سرویس برای اجرای خودکار در بوت..."
systemctl enable block_bittorrent_safe.service

echo "🚀 اجرای سرویس..."
systemctl start block_bittorrent_safe.service

echo "✅ نصب کامل شد. وضعیت سرویس:"
systemctl status block_bittorrent_safe.service --no-pager