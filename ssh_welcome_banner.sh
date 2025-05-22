#!/bin/bash

# Prompt for title and description
read -rp "Enter title for this container/VM: " TITLE
read -rp "Enter a short description: " DESCRIPTION

# Output path
BANNER_FILE="/etc/profile.d/banner.sh"

# Collect static system info
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
VERSION=$(grep VERSION_ID /etc/os-release | cut -d= -f2 | tr -d '"')

# Create the banner script
cat <<EOF | sudo tee "$BANNER_FILE" > /dev/null
#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
RED='\033[1;31m'
NC='\033[0m'

TITLE="$TITLE"
DESCRIPTION="$DESCRIPTION"

# System Information
echo -e "\n\${CYAN}\$TITLE\${NC}"
echo -e "\${YELLOW}  📘  \$DESCRIPTION\${NC}"
echo -e "\n  🖥️  OS: \${GREEN}$OS - Version: $VERSION\${NC}"
echo -e "  🏷️  Hostname: \${GREEN}$HOSTNAME\${NC}"
echo -e "  🌐  IP Address: \${GREEN}$IP\${NC}"

# Uptime
UPTIME=$(uptime -p)
echo -e "\n  ⏱️  Uptime: \${MAGENTA}\$UPTIME\${NC}"

# CPU Usage
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo -e "  🧠  CPU Load: \${MAGENTA}\$CPU_LOAD\${NC}"

# Memory Usage
MEMORY=$(free -m | awk '/Mem:/ {printf "%dMB / %dMB (%.1f%%)", \$3, \$2, \$3*100/\$2}')
echo -e "  🗄️  RAM Usage: \${MAGENTA}\$MEMORY\${NC}"

# Disk Usage
DISK=$(df -h / | awk 'NR==2 {print \$3" / "\$2" ("\$5")"}')
echo -e "  💾  Disk Usage: \${MAGENTA}\$DISK\${NC}"

EOF

# Make it executable
sudo chmod +x "$BANNER_FILE"
echo -e "\n✅ Banner installed at: $BANNER_FILE\nLog out and SSH back in to see it."
