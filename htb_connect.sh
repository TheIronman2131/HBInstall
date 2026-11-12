#!/bin/bash

OVPN_FILE=$1

if [ -z "$OVPN_FILE" ]; then
    echo "No File Provided. Searching for .ovpn files in ~/Downloads"
    shopt -s nullglob
    FILES=(~/Downloads/*.ovpn)
    shopt -u nullglob

if [ ${#FILES[@]} -eq 1 ]; then
    OVPN_FILE="${FILES[0]}"
    echo "Found VPN file: $OVPN_FILE"
elif [ ${#FILES[@]} -gt 1 ]; then
    echo "Multiple .ovpn files found in ~/Downloads. Please specify which to use."
    echo "Usage: ./htb_connect.sh ~/Downloads/filename.ovpn"
    exit 1
else
    echo "Error: No .ovpn file found in ~/Downloads."
    echo "Please download it from Hack The Box and follow the documentation if confused."
    echo "Usage ./htb_connect.sh ~/Downloads/filename.ovpn"
    exit 1
fi
fi

echo "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
echo "Homebrew not found. Installing now. You may be prompted for your admin password."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ -x "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        if ! grep -q "/opt/homebrew/bin/brew shellenv" ~/.zprofile 2>/dev/null; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        fi
    elif [ -x "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
        if ! grep -q "/usr/local/bin/brew shellenv" ~/.zprofile 2>/dev/null; then
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        fi
    fi
echo "Homebrew installed and added to PATH sucessfully"
else
    echo "Homebrew is already installed."
fi

echo "Installing required tools..."
brew install nmap inetutils openvpn

if ! grep -q "inetutils/libexec/gnubin" ~/.zshrc; then
    echo 'export PATH="/opt/homebrew/opt/inetutils/libexec/gnubin:$PATH"' >> ~/.zshrc
        else
    echo "Terminal Path already configured."
fi

echo "Initializing HTB VPN Tunnel..."
echo "You may be prompted for an admin password"

sudo openvpn --config "$OVPN_FILE" --daemon
echo "Waiting 5 seconds for the VPN to negotiate connection..."
sleep 5

HTB_IP=$(ifconfig tun0 2>/dev/null | grep 'inet ' | awk '{print $2}')

if [ -z "$HTB_IP" ]; then
    echo "Connection failed"
else
    echo "==================================================="
    echo "[+] SUCCESS! You are connected to the HTB network."
    echo "[+] Your HTB IP (tun0) is: $HTB_IP"
    echo "==================================================="
fi

