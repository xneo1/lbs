# 🐧 Linux Banner Script (LBS) - Version 2.1
Welcome to **Linux Banner Script (LBS)** — a simple but powerful tool to add a stylish and informative welcome banner to your Linux VMs and LXCs when connecting via SSH. Perfect for homelabbers, sysadmins, and terminal enthusiasts who want system status at a glance every time they log in.
---
## 📸 Preview
![Demo](demo/demo.gif)
```bash
LocalAI | 100
  📘  Coolify with Ollama, OpenWebUI and LiteLLM
  🖥️  OS: Ubuntu 24.04.2 LTS - Version: 24.04
  🏷️  Hostname: localai
  🌐  IP Address: 192.168.0.100
  ⏱️  Uptime: up 18 hours, 11 minutes
  🧠  CPU Load: 7.1%
  🗄️  RAM Usage: 2404MB / 32095MB (7.5%)
  💾  Disk Usage: 42G / 293G (15%)
  📁  Starting in: /opt/localai
```
---
## 🚀 Features
- Prompts for custom title, description, and optional Proxmox VM/LXC ID
- Automatically appends the ID to the banner title (e.g. `LocalAI | 100`)
- Detects and optionally updates existing community-scripts banners
- Dynamic system info: OS, Hostname, IP, Uptime, CPU, RAM, Disk
- **🆕 Startup Path Configuration**: Automatically places users in a specified directory after SSH login
- Disk usage color-coded:
  - Green: <60%
  - Yellow: 60–79%
  - Magenta: 80–94%
  - Red (with ⚠ blinking warning): 95% and above
- Fully Bash-based — no external dependencies
- Auto-installs to `/etc/profile.d/banner.sh` or updates existing banner
---
## ✨ New in Version 2.1: Startup Path Feature

The script now allows you to configure a **default startup directory** where users will be automatically placed after SSH login. This is perfect for:

- **Application containers**: Start users directly in the app directory (e.g., `/opt/myapp`)
- **Development environments**: Jump to project directories (e.g., `~/workspace`)  
- **Web servers**: Access web root directories (e.g., `/var/www/html`)
- **Docker environments**: Start in compose or container directories

### Startup Path Features:
- 📁 **Path Validation**: Checks if directory exists before configuration
- 🔧 **Auto-Creation**: Offers to create the directory if it doesn't exist
- 🏠 **Tilde Support**: Supports paths like `~/myapp` and absolute paths
- 🎯 **Interactive Only**: Only affects interactive SSH sessions (not scripts)
- 👁️ **Visual Feedback**: Shows startup path in the banner with 📁 icon

---
## 📦 Installation (One-Liner)
```bash
bash <(curl -s https://raw.githubusercontent.com/xneo1/lbs/refs/heads/main/ssh_welcome_banner.sh)
```
### You will be prompted to:
- Enter a **Title** (e.g., "LocalAI")
- Enter a **Description** (e.g., "Coolify with Ollama, OpenWebUI and LiteLLM")
- Optionally provide a **Proxmox VM/LXC ID** (e.g., 100)
- **🆕 Optionally set a Startup Path** (e.g., `/opt/localai`, `~/workspace`)

If an existing community-script or banner is found, you will be asked whether to overwrite it.
Just log out and SSH back in to see your banner! ✅
---
## 🔧 Manual Installation
```bash
curl -O https://raw.githubusercontent.com/xneo1/lbs/refs/heads/main/ssh_welcome_banner.sh
chmod +x ssh_welcome_banner.sh
sudo ./ssh_welcome_banner.sh
```
---
## 📝 Example Startup Paths

Here are some common use cases for the startup path feature:

| Application Type | Example Path | Description |
|------------------|--------------|-------------|
| **Docker Apps** | `/opt/docker` | Start in Docker compose directory |
| **Web Apps** | `/var/www/html` | Web server document root |
| **Node.js Apps** | `/opt/myapp` | Application installation directory |
| **Development** | `~/workspace` | User development workspace |
| **Git Projects** | `~/projects/myproject` | Specific project directory |
| **Databases** | `/var/lib/postgresql` | Database working directory |

---
## 🤖 Use Cases
- Homelab VMs and LXCs (e.g., Grafana, Uptime Kuma, LocalAI)
- Docker hosts, Proxmox-managed environments, Raspberry Pi clusters
- Development and production servers with specific working directories
- Clean visual overview on every SSH login with automatic directory navigation
---
## 🗓 Version History
- **Current Version:** 2.1
- **Last Updated:** 02/06/2025
- **Changelog:**
  - **v2.1**: Added startup path configuration feature
  - **v2.0**: Initial release with system info banner
---
## 📜 License
Apache License 2.0 © [xneo1](https://github.com/xneo1)  
See the [LICENSE](LICENSE) file for details.
---
## 🌐 Links
- GitHub Repo: [Linux Banner Script (LBS)](https://github.com/xneo1/lbs)
- Raw Script: [ssh_welcome_banner.sh](https://raw.githubusercontent.com/xneo1/lbs/refs/heads/main/ssh_welcome_banner.sh)
