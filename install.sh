#!/bin/bash

CONFIG_DIR="$HOME/.config"
CONFIG_FILE="$CONFIG_DIR/vpnc.conf"
SHELL_RC=""

# Determine shell configuration file
if [[ "$SHELL" =~ "zsh" ]]; then
    SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL" =~ "bash" ]]; then
    SHELL_RC="$HOME/.bashrc"
else
    echo "Unsupported shell. Please manually add the alias to your shell configuration."
    exit 1
fi

# Check if .config directory exists
if [ ! -d "$CONFIG_DIR" ]; then
    echo "~/.config directory does not exist. Please create it first."
    exit 1
fi

# Prompt for NetID and password
echo -n "Enter your NetID: "
read -r NETID
echo -n "Enter your password: "
stty -echo
read -r PASSWORD
stty echo
echo ""

# Save credentials to vpnc.conf
echo "connect vpn.duke.edu" > "$CONFIG_FILE"
echo "2" >> "$CONFIG_FILE"
echo "$NETID" >> "$CONFIG_FILE"
echo "$PASSWORD" >> "$CONFIG_FILE"
echo "1" >> "$CONFIG_FILE"
chmod 600 "$CONFIG_FILE"

echo "Saved credentials to $CONFIG_FILE"

# Add alias to shell configuration
ALIAS_CMD_on="alias vpnc=\"/opt/cisco/secureclient/bin/vpn -s < $CONFIG_FILE\""
ALIAS_CMD_off="alias vpnd=\"/opt/cisco/secureclient/bin/vpn disconnect\""
ALIAS_CMD_interactive="alias vpni=\"/opt/cisco/secureclient/bin/vpn\""
echo "$ALIAS_CMD_on" >> "$SHELL_RC"
echo "Added alias 'vpnc' to $SHELL_RC"
echo "$ALIAS_CMD_off" >> "$SHELL_RC"
echo "Added alias 'vpnd' to $SHELL_RC"
echo "$ALIAS_CMD_interactive" >> "$SHELL_RC"
echo "Added alias 'vpni' to $SHELL_RC"



# Reload shell
exec "$SHELL"
