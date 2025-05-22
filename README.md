# 🐧 Linux Banner Script (LBS) - Version 2.0

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
```

---

## 🚀 Features

- Prompts for custom title, description, and optional Proxmox VM/LXC ID
- Automatically appends the ID to the banner title (e.g. `LocalAI | 100`)
- Detects and optionally updates existing community-scripts banners
- Dynamic system info: OS, Hostname, IP, Uptime, CPU, RAM, Disk
- Disk usage color-coded:
  - Green: <60%
  - Yellow: 60–79%
  - Magenta: 80–94%
  - Red (with ⚠ blinking warning): 95% and above
- Fully Bash-based — no external dependencies
- Auto-installs to `/etc/profile.d/banner.sh` or updates existing banner

---

## 📦 Installation (One-Liner)

```bash
bash <(curl -s https://raw.githubusercontent.com/xneo1/lbs/refs/heads/main/ssh_welcome_banner.sh)
```

### You will be prompted to:
- Enter a **Title** (e.g., "LocalAI")
- Enter a **Description** (e.g., "Coolify with Ollama, OpenWebUI and LiteLLM")
- Optionally provide a **Proxmox VM/LXC ID** (e.g., 100)

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

## 🤖 Use Cases

- Homelab VMs and LXCs (e.g., Grafana, Uptime Kuma, LocalAI)
- Docker hosts, Proxmox-managed environments, Raspberry Pi clusters
- Clean visual overview on every SSH login

---

## 🗓 Version

- **Current Version:** 2.0
- **Last Updated:** 22/05/2025

---

## 📜 License

Apache License 2.0 © [xneo1](https://github.com/xneo1)  
See the [LICENSE](LICENSE) file for details.

---

## 🌐 Links

- GitHub Repo: [Linux Banner Script (LBS)](https://github.com/xneo1/lbs)
- Raw Script: [ssh_welcome_banner.sh](https://raw.githubusercontent.com/xneo1/lbs/refs/heads/main/ssh_welcome_banner.sh)
