```markdown
# 🛠️ ZSH Utility Functions & Aliases

A curated set of Zsh utility functions and aliases for developer productivity, automation, and system hygiene. This README documents the `.zshrc` utilities, their usage, and prerequisites.

---

## 🚀 Quick Start

1. **Clone or Copy** the `.zshrc` content into your `~/.zshrc` file.
2. **Reload your shell**:
   ```sh
   source ~/.zshrc
   ```
3. **(Recommended)** Install required tools (see [Prerequisites](#-prerequisites)).

---

## 📝 Function List

| Function / Alias       | Description                                                         |
|------------------------|---------------------------------------------------------------------|
| `mkcd`                 | Create a directory and move into it                                 |
| `killit`               | Kill all processes by name                                          |
| `extract`              | Extract almost any compressed file                                  |
| `glog`                 | Visualize git log as decorated graph                                |
| `duh`                  | Disk usage in human-readable format                                 |
| `brewup`               | Update & clean all Homebrew packages (macOS)                       |
| `ssh-agent-connect`    | Start ssh-agent and add default key                                 |
| `generate_random_pdf`  | Generate a random PDF with N characters                             |
| `gi`                   | Add filename to `.gitignore`                                        |
| `te3l`                 | Get OpenAI text-embedding-3-large embedding for a string            |
| `del`                  | Remove a file (with existence check)                                |
| `zshrc-push`           | Backup `.zshrc` to S8-Utilities repo (with GitHub token)            |
| `symlink`              | Create a symbolic link                                              |

**Aliases:**

- `ll`           — List files (long, human-readable)
- `grep`         — Grep with color output
- `gs`, `ga`, `gcm`, `gp`, `gpl` — Git shortcuts
- `pip`, `pip3`  — Reminders to use `uv pip install` or `python -m pip`
- `dcu`, `dcd`, `dps` — Docker Compose shortcuts
- `jsondiff-regent` — Run a JSON diff script
- `spdf`         — Launch Stirling-PDF Docker container and open browser
- `n8n`          — Launch n8n Docker container and open browser
- `zshrc-backup` — Alias for `zshrc-push`

---

## 💡 Usage Examples

### Directory & File Utilities

```sh
mkcd myfolder
# → Creates 'myfolder' and enters it

del myfile.txt
# → Deletes 'myfile.txt' if it exists
```

### Process & System

```sh
killit node
# → Kills all processes named 'node'

duh 3
# → Shows disk usage up to depth 3 (default: 2)
```

### Archives

```sh
extract archive.tar.gz
# → Extracts the archive based on its extension
```

### Git Shortcuts

```sh
glog
# → Pretty git log graph

gi .env
# → Adds '.env' to .gitignore
```

### Docker Shortcuts

```sh
dcu
# → docker-compose up

spdf
# → Launches Stirling-PDF in Docker, waits for health, opens browser

n8n
# → Launches n8n in Docker, waits for health, opens browser
```

### Homebrew

```sh
brewup
# → Updates, upgrades, and cleans Homebrew packages
```

### OpenAI Embeddings

```sh
te3l "hello world"
# → Saves embedding to a timestamped file (requires OpenAI API key in Keychain)
```

### Random PDF Generation

```sh
generate_random_pdf 1000 ~/Desktop/random.pdf
# → Creates a PDF with 1000 random characters
```

### Symlinks

```sh
symlink /path/to/target mylink
# → Creates symlink 'mylink' pointing to target
```

### Zshrc Backup

```sh
zshrc-push
# → Pushes your .zshrc to S8-Utilities repo (requires GitHub token in Keychain)
zshrc-backup
# → Same as above (alias)
```

---

## ⚙️ Prerequisites

Some functions require additional tools or environment setup:

- **General**
  - [Zsh](https://www.zsh.org/)
  - [git](https://git-scm.com/)
  - [curl](https://curl.se/)

- **Archive Extraction**
  - `unrar`, `unzip`, `7z`, `bunzip2`, `gunzip`, `tar`, `uncompress`

- **PDF Generation**
  - `cupsfilter` (usually present on macOS with CUPS installed)

- **OpenAI Embeddings**
  - macOS Keychain entry for API key:
    ```sh
    security add-generic-password -a "$(whoami)" -s "openai_api_key" -w "sk-..." 
    ```
  - Internet access

- **zshrc-push (Backup)**
  - macOS Keychain entry for GitHub token:
    ```sh
    security add-generic-password -a "$(whoami)" -s "github_dawg_cli_cmds" -w "ghp_..." 
    ```
  - Access to [solution8-com/S8-Utilities](https://github.com/solution8-com/S8-Utilities) repo

- **Docker Utilities**
  - [Docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/)

- **Homebrew**
  - [Homebrew](https://brew.sh/) (macOS package manager)

- **Other**
  - `xdg-open` or `open` (for opening URLs, Linux/macOS)
  - `security` (macOS Keychain CLI)

---

## 🗂️ Notes

- **PATH** is carefully constructed to include Homebrew, Volta, Orbstack, Go, and Antigravity directories.
- **Aliases** for `pip` and `pip3` remind you to use [uv](https://github.com/astral-sh/uv) or `python -m pip` for hygiene.
- **Deduplication**: `typeset -U path` ensures no duplicate entries in `$PATH`.

---

## 🧑‍💻 Contribution

Feel free to fork and adapt these utilities for your own workflow!
```
