#!/usr/bin/env bash
# ============================================================
# 🚀 EvxoTech SoftEther VPN Installer v2.5 (Final Edition)
# ============================================================
# Compatible with Ubuntu 22.04 / 24.04 / Debian 12+
# Includes GUI Mode + Optional OpenVPN Support
# ============================================================

set -e

echo "============================================="
echo "   🚀 EvxoTech SoftEther VPN Installer v2.5"
echo "============================================="
echo ""

# --- Ask for installation type ---
echo "Select installation type:"
echo "  1) SoftEther VPN Server"
echo "  2) SoftEther VPN Bridge"
echo "  3) SoftEther VPN Client"
echo "  4) Install All (Server + Bridge + Client)"
echo "  5) Uninstall / Remove"
echo "  6) Exit"
read -rp "Enter choice [1-6]: " choice

if [[ "$choice" == "6" ]]; then
  echo "Exiting..."
  exit 0
fi

if [[ "$choice" == "5" ]]; then
  echo "🧹 Removing SoftEther VPN installation..."
  systemctl stop vpnserver vpnbridge vpnclient 2>/dev/null || true
  systemctl disable vpnserver vpnbridge vpnclient 2>/dev/null || true
  rm -rf /usr/local/vpnserver /etc/systemd/system/vpnserver.service /usr/local/vpnbridge /etc/systemd/system/vpnbridge.service /usr/local/vpnclient /etc/systemd/system/vpnclient.service
  systemctl daemon-reload
  echo "✅ SoftEther completely removed."
  exit 0
fi

echo "Installing build dependencies..."
sudo apt update -y
sudo apt install -y git build-essential cmake libreadline-dev libssl-dev zlib1g-dev libncurses5-dev

# --- Clone repository ---
cd ~
REPO_DIR="SoftEtherVPN"
if [ -d "$REPO_DIR" ]; then
  rm -rf "$REPO_DIR"
fi

echo "Cloning SoftEtherVPN repository..."
git clone --depth=1 https://github.com/SoftEtherVPN/SoftEtherVPN.git
cd SoftEtherVPN

# --- Build process ---
mkdir -p build && cd build
cmake ..
make -j"$(nproc)"

echo ""
echo "✅ Build completed successfully."
echo ""

# --- Create target directory ---
sudo mkdir -p /usr/local/vpnserver

# --- Copy binaries automatically ---
if [ -f "vpnserver" ]; then
  sudo cp vpnserver /usr/local/vpnserver/
fi
if [ -f "vpncmd" ]; then
  sudo cp vpncmd /usr/local/vpnserver/
fi
if [ -f "hamcore.se2" ]; then
  sudo cp hamcore.se2 /usr/local/vpnserver/
else
  find ../ -type f -name "hamcore.se2" -exec sudo cp {} /usr/local/vpnserver/ \; 2>/dev/null || true
fi

# --- Set permissions ---
sudo chmod 600 /usr/local/vpnserver/*
sudo chmod 700 /usr/local/vpnserver/vpnserver
sudo chmod 700 /usr/local/vpnserver/vpncmd

# --- Create systemd service ---
echo "🧩 Setting up systemd service..."
cat << 'EOF' | sudo tee /etc/systemd/system/vpnserver.service >/dev/null
[Unit]
Description=SoftEther VPN Server
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/vpnserver/vpnserver start
ExecStop=/usr/local/vpnserver/vpnserver stop
WorkingDirectory=/usr/local/vpnserver/
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# --- Enable and start service ---
sudo systemctl daemon-reload
sudo systemctl enable vpnserver
sudo systemctl start vpnserver

sleep 2

if systemctl is-active --quiet vpnserver; then
  echo "✅ SoftEther VPN Server is running successfully!"
else
  echo "❌ VPN Server failed to start. Please check logs:"
  echo "   systemctl status vpnserver --no-pager -l"
  exit 1
fi

# --- Prompt for admin password setup ---
echo ""
echo "🛡️  To complete setup, run the following command to set the admin password:"
echo ""
echo "   cd /usr/local/vpnserver && sudo ./vpncmd"
echo "   > ServerPasswordSet"
echo ""
echo "You can connect via SoftEther VPN Server Manager GUI from Windows."
echo "Default management port: 5555"
echo ""

# --- Optional OpenVPN setup ---
read -rp "Would you like to enable OpenVPN protocol support? (y/n): " openvpn_choice

if [[ "$openvpn_choice" =~ ^[Yy]$ ]]; then
  echo "⚙️  Enabling OpenVPN protocol..."
  cd /usr/local/vpnserver
  ./vpncmd localhost /SERVER /CMD OpenVpnEnable yes
  ./vpncmd localhost /SERVER /CMD OpenVpnMakeConfig evxotech-client
  echo "✅ OpenVPN enabled! Configuration saved to:"
  echo "   /usr/local/vpnserver/evxotech-client.ovpn"
else
  echo "⏩ OpenVPN support skipped."
fi

echo ""
echo "🎉 Installation Complete!"
echo "Use the Windows SoftEther VPN Server Manager to connect."
echo "-----------------------------------------------"
echo "✔️  Service: sudo systemctl status vpnserver"
echo "✔️  GUI Port: 5555"
echo "✔️  Directory: /usr/local/vpnserver"
echo "-----------------------------------------------"
