#!/bin/bash

echo "[+] شروع تنظیم فایروال برای جلوگیری از تورنت و حفظ امنیت ترافیک مجاز..."

# لیست پورت‌های مجاز (TCP/UDP)
ALLOWED_PORTS=(80 443 53 2052 2096 2053 8443 2087 34405 2083 2086 2082 22)

# مجاز کردن پورت‌ها برای TCP و UDP
for port in "${ALLOWED_PORTS[@]}"; do
    iptables -A OUTPUT -p tcp --dport $port -j ACCEPT
    iptables -A OUTPUT -p udp --dport $port -j ACCEPT
done

# اجازه به ترافیک بین دکودمودور (IPv6)
ip6tables -A INPUT -s 2002:831b::1 -j ACCEPT
ip6tables -A INPUT -s 2002:831b::2 -j ACCEPT
ip6tables -A OUTPUT -d 2002:831b::1 -j ACCEPT
ip6tables -A OUTPUT -d 2002:831b::2 -j ACCEPT

# بلاک پورت‌های تورنت رایج
iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
iptables -A OUTPUT -p udp --dport 1024:65535 -m string --algo bm --string "BitTorrent" -j DROP
iptables -A OUTPUT -p tcp --dport 6969 -j DROP
iptables -A OUTPUT -p udp --dport 6969 -j DROP

# بلاک امضاهای تورنت
for sig in "BitTorrent" "BitTorrent protocol" "peer_id=" ".torrent" "announce" "info_hash"; do
    iptables -A OUTPUT -m string --algo bm --string "$sig" -j DROP
done

# حذف سرویس‌های تورنت در صورت نصب بودن
for app in transmission-daemon deluged qbittorrent-nox qbittorrent rtorrent aria2; do
    if pgrep -x "$app" > /dev/null; then
        echo "[-] توقف $app ..."
        killall -9 "$app"
        systemctl disable "$app" 2>/dev/null
    fi
done

# ذخیره تنظیمات فایروال
echo "[+] ذخیره تنظیمات..."
apt install -y iptables-persistent > /dev/null 2>&1
netfilter-persistent save

echo "[✓] اسکریپت با موفقیت اجرا شد. تورنت بلاک شد. سرتیفیکیت، پنل و تونل‌ها امن هستند."
