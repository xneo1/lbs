# 🐧 Linux Banner Script (LBS)

Welcome to **Linux Banner Script (LBS)** — a simple but powerful tool to add a stylish and informative welcome banner to your Linux VMs and LXCs when connecting via SSH. Perfect for homelabbers, sysadmins, and terminal enthusiasts who want system status at a glance every time they log in.

---

## 📸 Preview

```bash
LLMind
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

- Prompts for custom title and description on install
- Dynamic system info (OS, Hostname, IP)
- Uptime, CPU Load, Memory & Disk Usage
- Auto-installed to `/etc/profile.d/banner.sh`
- No dependencies — pure Bash

---

## 📦 Installation (One-Liner)

```bash
bash <(curl -s https://raw.githubusercontent.com/xneo1/lbs/refs/heads/main/ssh_welcome_banner.sh)
```

You’ll be prompted to:
- Enter a **title** (e.g., "LLMind")
- Enter a **description** (e.g., "Coolify with Ollama, OpenWebUI and LiteLLM")

Then, the script:
- Detects OS, Hostname, IP
- Collects CPU, RAM, Disk, and uptime info
- Writes the banner to `/etc/profile.d/banner.sh`

Just log out and SSH back in to see the result. ✅

---

## 🔧 Manual Installation

```bash
curl -O https://raw.githubusercontent.com/xneo1/lbs/refs/heads/main/ssh_welcome_banner.sh
chmod +x ssh_welcome_banner.sh
sudo ./ssh_welcome_banner.sh
```

---

## 🤖 Use Cases

- Homelab monitoring VMs (e.g., Grafana, Uptime Kuma)
- Docker hosts, Pi clusters, or remote servers
- Anyone who wants a clean and informative SSH login screen

---

## 📜 License

Apache License 2.0 © [xneo1](https://github.com/xneo1)  
See the [LICENSE](LICENSE) file for details.

---

## 🌐 Links

- GitHub Repo: [Linux Banner Script (LBS)](https://github.com/xneo1/lbs)
- Raw Script: [ssh_welcome_banner.sh](https://raw.githubusercontent.com/xneo1/lbs/refs/heads/main/ssh_welcome_banner.sh)
