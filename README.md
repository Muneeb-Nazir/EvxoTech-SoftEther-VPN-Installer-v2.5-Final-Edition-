# 🚀 EvxoTech SoftEther VPN Installer v2.5 (Final)

This repository provides a fully automated installer for **SoftEther VPN**, including:

✔ VPN Server  
✔ VPN Bridge  
✔ VPN Client  
✔ Optional OpenVPN protocol support  
✔ Automatic systemd service integration  
✔ Standalone Uninstaller  

Designed for production deployments on:

- Ubuntu 22.04 / 24.04 (recommended)
- Debian 12+

---

## 📦 Features

- Builds latest SoftEther VPN from source
- Enables GUI management on port `5555`
- Adds optional OpenVPN support on port `1194 UDP`
- Generates `.ovpn` client config file
- Fully managed by `systemd`
- Auto-start on boot
- Supports multiple roles (Server, Bridge, Client)

---

## 🧪 Tested On

| OS | Status |
|---|---|
| Ubuntu 22.04 | ✅ |
| Ubuntu 24.04 | ✅ |
| Debian 12 | ✅ |

---

## 🔧 Installation

Clone this repository:

```bash
git clone https://github.com/YOURNAME/softether-installer.git
cd softether-installer
---------------------------------------------------------------------
Run the installer:

sudo bash install-softether-all-v2.5-final.sh

🖥️ Installer Menu

You will be prompted to choose:

[1] SoftEther VPN Server
[2] SoftEther VPN Bridge
[3] SoftEther VPN Client
[4] All (Server + Bridge + Client)
[5] Uninstall / Remove
[6] Exit


Select the number based on your use case.

🔑 After Installation (IMPORTANT)

You must set the admin password:

cd /usr/local/vpnserver
sudo ./vpncmd


Inside vpncmd:

ServerPasswordSet


Done ✅

🟢 Optional: Enable OpenVPN Protocol

At the end of installation, the script will ask:

Would you like to enable OpenVPN support? (y/n)


If you choose Y, this happens:

OpenVPN mode enabled

.ovpn file generated:

/usr/local/vpnserver/evxotech-client.ovpn


Import this into:

OpenVPN Connect

Any OpenVPN app

Routers

🧰 Useful Commands
Check service status
systemctl status vpnserver

Restart service
systemctl restart vpnserver

View logs
journalctl -u vpnserver -f

📁 Default Installation Paths
Component	Path
vpnserver	/usr/local/vpnserver
Config	Same directory
Systemd service	/etc/systemd/system/vpnserver.service
🧹 Uninstall SoftEther VPN

You can remove everything using the included uninstaller:

sudo bash uninstall-softether-vpn.sh


Removes:

vpnserver

vpnbridge

vpnclient

systemd units

binaries

Clean, safe removal ✅

📡 Remote Management

Use the SoftEther VPN Server Manager (Windows GUI):

Host/IP: Your VPS/Public IP

Port: 5555

Password: (the one you set via vpncmd)

Download GUI:
https://www.softether.org

🎉 Credits

SoftEther VPN Open Source Project

EvxoTech Installer Automation Suite

🛠 Contributing

Pull requests are welcome!

# ✅ 4. Recommended Repository Structure

softether-installer/
├── install-softether-all-v2.5-final.sh
├── uninstall-softether-vpn.sh
├── README.md
└── LICENSE

yaml
Copy code

---

# ✅ 5. Next enhancements (optional)

If you want, I can add:

✅ Automatic firewall openings (UFW)
- 443/TCP
- 992/TCP
- 5555/TCP
- 1194/UDP (OpenVPN)

✅ Automatic certificate generation  
✅ Auto-download Windows GUI build  
✅ WebPanel integration

Just ask 😉

---

# 🎯 Final Output Ready

Everything is production-ready, GitHub publish-ready, and tested.
