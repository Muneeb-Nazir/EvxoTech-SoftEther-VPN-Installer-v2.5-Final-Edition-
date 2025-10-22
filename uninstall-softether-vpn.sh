#!/usr/bin/env bash
# ============================================================
# 🧹 EvxoTech SoftEther VPN Uninstaller v2.5
# Completely removes Server, Bridge, Client & Systemd services
# ============================================================

set -e

echo "============================================="
echo "     🧹 EvxoTech SoftEther VPN Uninstaller"
echo "============================================="

read -rp "Are you sure you want to remove ALL SoftEther components? (y/n): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

# Stop services
systemctl stop vpnserver vpnbridge vpnclient 2>/dev/null || true

# Disable services
systemctl disable vpnserver vpnbridge vpnclient 2>/dev/null || true

# Delete systemd units
rm -f /etc/systemd/system/vpnserver.service
rm -f /etc/systemd/system/vpnbridge.service
rm -f /etc/systemd/system/vpnclient.service

# Remove directories
rm -rf /usr/local/vpnserver
rm -rf /usr/local/vpnbridge
rm -rf /usr/local/vpnclient

systemctl daemon-reload

echo "✅ Removal Completed!"
echo "All SoftEther VPN components have been purged."
