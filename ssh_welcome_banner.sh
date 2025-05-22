#!/bin/bash

# Prompt for custom title and description
read -rp "Enter title for this container/VM: " TITLE
read -rp "Enter a short description: " DESCRIPTION

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# System Info
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
VERSION=$(grep VERSION_ID /etc/os-release | cut -d= -f2 | tr -d '"')

# Uptime
UPTIME=$(uptime -p)

# CPU Usage
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

# Memory Usage
MEMORY=$(free -m | awk '/Mem:/ {printf "%dMB / %dMB (%.1f%%)", $3, $2, $3*100/$2}')

# Disk Usage
DISK=$(df -h / | awk 'NR==2 {print $3" / "$2" ("$5")"}')

# Output
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
echo -e "  💾  Disk Usage: ${MAGENTA}$DISK${NC}"
echo ""

# Save to profile.d to persist on login
BANNER_PATH="/etc/profile.d/banner.sh"

sudo bash -c "cat > $BANNER_PATH" <<EOF
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
echo -e "  💾  Disk Usage: ${MAGENTA}$DISK${NC}"
echo ""
EOF

sudo chmod +x "$BANNER_PATH"
echo -e "\n✅ Banner installed to: $BANNER_PATH\nLog out and SSH back in to see it."
