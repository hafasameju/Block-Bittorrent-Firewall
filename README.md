# BitTorrent Blocker Script for Ubuntu Server 🚫

This project contains a script and service to **block BitTorrent traffic** on an Ubuntu server, helping you **avoid copyright infringement warnings** and maintain clean network usage.

---

## 🔒 Features

- Blocks **BitTorrent-related traffic patterns** (IPv4 + IPv6)
- Works with `iptables` and `ip6tables`
- Includes a `systemd` service to **auto-run on reboot**
- Safe for tunnel-based setups and reverse proxies (Cloudflare ports not affected)
- Lightweight – almost no extra CPU load

---

## 📁 Files Included

| File Name                      | Description                                 |
|-------------------------------|---------------------------------------------|
| `block_bittorrent_safe.sh`    | Main script to block BitTorrent traffic     |
| `block_bittorrent_safe.service` | systemd unit for auto-start on reboot      |
| `LICENSE`                     | MIT License for free use & modification     |

---

## ⚙️ Installation Guide

### 1. Copy files to your Ubuntu server:
```bash
scp * user@your-server-ip:/root/
```

### 2. SSH into your server:
```bash
ssh user@your-server-ip
```

### 3. Extract and make executable:
```bash
unzip block_bittorrent_safe_full_with_license.zip
chmod +x block_bittorrent_safe.sh
```

### 4. Install and activate the service:
```bash
cp block_bittorrent_safe.service /etc/systemd/system/
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable block_bittorrent_safe.service
systemctl start block_bittorrent_safe.service
```

---

## ✅ Confirm It’s Working
```bash
systemctl status block_bittorrent_safe.service
iptables -L | grep -i bittorrent
```

---

## 📄 License

This project is licensed under the **MIT License** – feel free to use, modify, and share.

---

> Created with ❤️ to help you stay safe and copyright-compliant.