#!/bin/bash

BANNER_FILE="/etc/profile.d/banner.sh"

# Check for existing banner and ask if we should overwrite
if [ -f "$BANNER_FILE" ]; then
  read -rp "A banner already exists. Do you want to update it? (y/n): " CONFIRM
  if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Aborted. Existing banner retained."
    exit 0
  fi
fi

# Prompt for custom title and description
read -rp "Enter title for this container/VM: " TITLE
read -rp "Enter a short description: " DESCRIPTION

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
DISK_BAR=""

# Color based on usage
if (( DISK_PERCENT >= 95 )); then
  DISK_COLOR="$RED$BLINK"
  WARNING="${RED}${BLINK}⚠ WARNING: Low Disk Space! ⚠${NC}"
elif (( DISK_PERCENT >= 80 )); then
  DISK_COLOR="$MAGENTA"
elif (( DISK_PERCENT >= 60 )); then
  DISK_COLOR="$YELLOW"
else
  DISK_COLOR="$GREEN"
fi

# Write banner
sudo tee "$BANNER_FILE" > /dev/null <<EOF
#!/bin/bash

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

sudo chmod +x "$BANNER_FILE"
echo -e "\n✅ Banner installed to: $BANNER_FILE\nLog out and SSH back in to see it."
