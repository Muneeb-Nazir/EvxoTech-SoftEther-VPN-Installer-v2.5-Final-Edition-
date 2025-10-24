🚀 SoftEther VPN Auto Installer + GUI + OpenVPN (Optional)

Maintained by: EvxoTech Systems

Fully automated setup of SoftEther VPN Server with optional OpenVPN support on Ubuntu / Debian systems.

🧩 Features

✅ Fully automated install script
✅ Pre-configured ports (443, 1194, 992, 5555)
✅ GUI Admin support via SoftEther VPN Server Manager (Windows/Linux)
✅ Auto-start on boot with systemd
✅ Optional OpenVPN configuration generator
✅ Works on: Ubuntu 20.04 / 22.04 / 24.04 / Debian 12+

⚙️ Installation
1️⃣ Update your system
sudo apt update && sudo apt upgrade -y

2️⃣ Download the Installer Script
wget https://raw.githubusercontent.com/EvxoTech/softether-vpn-installer/main/softether-vpn-installer.sh
chmod +x softether-vpn-installer.sh

3️⃣ Run the Installer
sudo ./softether-vpn-installer.sh


You’ll be asked to:

Enter a VPN admin password (for GUI login)

Optionally enable OpenVPN support

Once complete, it automatically:

Builds SoftEtherVPN from source

Installs it into /usr/local/vpnserver

Enables systemd autostart service

Opens firewall ports (443, 1194, 992, 5555)

🖥️ Configuration Guide

After installation completes:

1️⃣ Connect using VPN Server Manager (GUI)

Download from official site:
🔗 https://www.softether-download.com/en.aspx?product=softether

Then open it and:

Click New Setting

Name: EvxoTech_SecureVPN

Hostname: YOUR_SERVER_IP (e.g., 192.140.147.1)

Port: 5555

Password: (the one you set during installation)

Click Connect ✅
You can now create users, virtual hubs, and VPN accounts.

2️⃣ Setting the Admin Password (Manual Mode)

If you didn’t set a password during install or want to reset it:

sudo /usr/local/vpnserver/vpncmd


Then:

ServerPasswordSet


Enter and confirm your new password.

3️⃣ Enabling OpenVPN Support (Optional)

If you didn’t enable it earlier, you can manually do it:

sudo /usr/local/vpnserver/vpncmd


Then inside vpncmd:

OpenVpnEnable yes /PORTS:1194
OpenVpnMakeConfig openvpn_config.zip


Your .ovpn client files will be created in /usr/local/vpnserver/.

4️⃣ Enable Autostart at Boot

The installer already does this, but if needed:

sudo systemctl enable vpnserver
sudo systemctl start vpnserver
sudo systemctl status vpnserver

🔍 Verify Service & Ports

Run:

sudo ss -tulnp | grep vpn


Expected output (example):

tcp   LISTEN  0  128 0.0.0.0:5555   ... vpnserver
tcp   LISTEN  0  128 0.0.0.0:443    ... vpnserver
tcp   LISTEN  0  128 0.0.0.0:1194   ... vpnserver
tcp   LISTEN  0  128 0.0.0.0:992    ... vpnserver

🧱 Firewall Configuration

If ufw is enabled:

sudo ufw allow 443/tcp
sudo ufw allow 5555/tcp
sudo ufw allow 1194/udp
sudo ufw allow 992/tcp
sudo ufw reload

🧰 Common Troubleshooting
Issue	Solution
Access has been denied	Run vpncmd → ServerPasswordSet to set admin password
Cannot connect from GUI	Ensure port 5555 is open and reachable
Service not starting	Run sudo systemctl restart vpnserver
No internet after VPN connect	Enable IP forwarding and set NAT rules in /etc/sysctl.conf
🔒 Security Notes

Always change default admin password immediately.

Keep ports 443, 992, 1194, and 5555 open in your firewall.

Regularly update your OS and SoftEtherVPN binaries.

🧾 License

This project uses the SoftEther VPN GPLv2 license.
SoftEther © University of Tsukuba, Japan.

👨‍💻 Maintainer

EvxoTech Systems
🌐 https://evxotechnologies.com

📧 support@evxotechnologies.com
