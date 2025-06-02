#!/bin/bash

# Directory where banners are typically placed
PROFILE_DIR="/etc/profile.d"
BANNER_FILE="$PROFILE_DIR/banner.sh"

# Detect existing community-scripts banners
EXISTING_COMMUNITY_BANNER=$(grep -l "community-scripts" $PROFILE_DIR/*.sh 2>/dev/null | head -n 1)

if [[ -n "$EXISTING_COMMUNITY_BANNER" ]]; then
  echo "⚠️  An existing Proxmox community-scripts banner was found: $EXISTING_COMMUNITY_BANNER"
  read -rp "Do you want to overwrite and update it with your custom banner? (y/n): " CONFIRM
  if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Aborted. Community banner retained."
    exit 0
  fi
  BANNER_FILE="$EXISTING_COMMUNITY_BANNER"
elif [ -f "$BANNER_FILE" ]; then
  read -rp "A banner already exists at $BANNER_FILE. Overwrite? (y/n): " CONFIRM
  if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Aborted. Existing banner retained."
    exit 0
  fi
fi

# Prompt for custom title and description
read -rp "Enter title for this container/VM: " TITLE
read -rp "Enter a short description: " DESCRIPTION
read -rp "Enter Proxmox VM/LXC ID (optional): " VMID

# Prompt for startup path
echo ""
echo "📁 Startup Path Configuration"
echo "   You can set a default directory that users will be placed in after SSH login."
echo "   This is useful for applications where you want users to start in the app directory."
echo ""
read -rp "Enter startup path (leave empty to use default home directory): " STARTUP_PATH

# Validate startup path if provided
if [[ -n "$STARTUP_PATH" ]]; then
  # Expand tilde and resolve path
  STARTUP_PATH=$(eval echo "$STARTUP_PATH")
  
  if [[ ! -d "$STARTUP_PATH" ]]; then
    echo "⚠️  Warning: Directory '$STARTUP_PATH' does not exist."
    read -rp "Do you want to create it? (y/n): " CREATE_DIR
    if [[ "$CREATE_DIR" =~ ^[Yy]$ ]]; then
      sudo mkdir -p "$STARTUP_PATH"
      if [[ $? -eq 0 ]]; then
        echo "✅ Directory created: $STARTUP_PATH"
      else
        echo "❌ Failed to create directory. Using default home directory instead."
        STARTUP_PATH=""
      fi
    else
      echo "Using default home directory instead."
      STARTUP_PATH=""
    fi
  else
    echo "✅ Startup path verified: $STARTUP_PATH"
  fi
fi

# Append ID to title if provided
if [[ -n "$VMID" ]]; then
  TITLE+=" | $VMID"
fi

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
RED='\033[1;31m'
BLINK='\033[5m'
NC='\033[0m' # No Color

# System Info
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
VERSION=$(grep VERSION_ID /etc/os-release | cut -d= -f2 | tr -d '"')
UPTIME=$(uptime -p)
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
MEMORY=$(free -m | awk '/Mem:/ {printf "%dMB / %dMB (%.1f%%)", $3, $2, $3*100/$2}')

# Disk Usage Details
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_PERCENT=$(df / | awk 'NR==2 {gsub("%", "", $5); print $5}')
DISK_COLOR="$GREEN"
WARNING=""

if (( DISK_PERCENT >= 95 )); then
  DISK_COLOR="$RED$BLINK"
  WARNING="${RED}${BLINK}⚠ WARNING: Low Disk Space! ⚠${NC}"
elif (( DISK_PERCENT >= 80 )); then
  DISK_COLOR="$MAGENTA"
elif (( DISK_PERCENT >= 60 )); then
  DISK_COLOR="$YELLOW"
fi

# Write banner
sudo tee "$BANNER_FILE" > /dev/null <<EOF
#!/bin/bash

# Github: https://github.com/community-scripts/ProxmoxVE

echo -e "\n${CYAN}$TITLE${NC}"
echo -e "${YELLOW}  📘  $DESCRIPTION${NC}"
echo -e ""
echo -e "  🖥️  OS: ${GREEN}$OS - Version: $VERSION${NC}"
echo -e "  🏷️  Hostname: ${GREEN}$HOSTNAME${NC}"
echo -e "  🌐  IP Address: ${GREEN}$IP${NC}"
echo -e ""
echo -e "  ⏱️  Uptime: ${MAGENTA}$UPTIME${NC}"
echo -e "  🧠  CPU Load: ${MAGENTA}$CPU_LOAD${NC}"
echo -e "  🗄️  RAM Usage: ${MAGENTA}$MEMORY${NC}"
echo -e "  💾  Disk Usage: ${DISK_COLOR}${DISK_USED} / ${DISK_TOTAL} (${DISK_PERCENT}%)${NC}"
EOF

# Append warning if needed
if (( DISK_PERCENT >= 95 )); then
  echo -e "echo -e \"$WARNING\"" | sudo tee -a "$BANNER_FILE" > /dev/null
fi

# Add startup path change if specified
if [[ -n "$STARTUP_PATH" ]]; then
  cat << EOF | sudo tee -a "$BANNER_FILE" > /dev/null

# Change to startup directory for interactive sessions
if [[ \$- == *i* ]] && [[ -d "$STARTUP_PATH" ]]; then
    echo -e "  📁  Starting in: ${GREEN}$STARTUP_PATH${NC}"
    cd "$STARTUP_PATH"
fi
EOF
  echo ""
  echo "📁 Startup path configured: $STARTUP_PATH"
fi

sudo chmod +x "$BANNER_FILE"

echo ""
echo "✅ Enhanced banner installed to: $BANNER_FILE"
if [[ -n "$STARTUP_PATH" ]]; then
  echo "🚀 Users will automatically be placed in: $STARTUP_PATH"
fi
echo "💡 Log out and SSH back in to see the banner and test the startup path."
