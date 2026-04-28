```markdown
# Zsh Utility Functions & Aliases

A curated set of Zsh utility functions and aliases for developer productivity, automation, and system hygiene. This `.zshrc` snippet provides handy shortcuts for working with Git, Docker, file management, OpenAI, and more.

---

## Quick Start

### 1. Prerequisites

- **Zsh shell** (recommended: latest version)
- **macOS** (some features are macOS-specific, e.g., Keychain, `cupsfilter`)
- **Homebrew** (for installing dependencies)
- **Optional utilities** (see [Prerequisites](#prerequisites) below)

### 2. Installation

1. **Clone or copy** the `.zshrc` content into your `~/.zshrc` file.

2. **Reload your shell**:

   ```sh
   source ~/.zshrc
   ```

3. **Install required tools** (see [Prerequisites](#prerequisites)).

---

## Function & Alias List

| Name                  | Type      | Description                                                         |
|-----------------------|-----------|---------------------------------------------------------------------|
| `mkcd`                | Function  | Create a directory and move into it                                 |
| `killit`              | Function  | Kill all processes matching a name                                  |
| `extract`             | Function  | Extract almost any compressed file                                  |
| `glog`                | Function  | Show a graphical Git log                                            |
| `duh`                 | Function  | Disk usage (human-readable, default depth 2)                        |
| `brewup`              | Function  | Update, upgrade, and clean Homebrew packages                        |
| `ssh-agent-connect`   | Function  | Start SSH agent and add default key                                 |
| `generate_random_pdf` | Function  | Generate a random PDF file with N characters                        |
| `te3l`                | Function  | Embed a text string or PDF into OpenAI embeddings                   |
| `del`                 | Function  | Remove a file (with error check)                                    |
| `zshrc-push`          | Function  | Auto-commit and push `.zshrc` to S8-Utilities repo                  |
| `symlink`             | Function  | Create a symbolic link (symlink)                                    |
| `gi`                  | Function  | Add directories/files/extensions to `.gitignore` (unique)           |
| `spaceremover`        | Function  | Rename files/directories, replacing spaces with underscores         |
| **Aliases:**          | Alias     |                                                                     |
| `ll`                  | Alias     | `ls -lahG` (long, all, human, color)                               |
| `grep`                | Alias     | `grep --color=auto`                                                 |
| `gs`, `ga`, `gcm`, `gcm-fast`, `gp`, `gpl` | Alias/Function | Git shortcuts                  |
| `pip`, `pip3`         | Alias     | Warn to use `uv pip install` or `python -m pip`                    |
| `dcu`, `dcd`, `dps`   | Alias     | Docker Compose shortcuts                                            |
| `jsondiff-regent`     | Alias     | Run a specific Python JSON diff script                              |
| `spdf`                | Alias     | Launch Stirling-PDF container and open browser                      |
| `n8n`                 | Alias     | Launch n8n container and open browser                               |
| `zshrc-backup`        | Alias     | Alias for `zshrc-push`                                             |

---

## Usage Examples

### Directory & File Management

```sh
mkcd myfolder
# → Creates 'myfolder' and enters it

del file.txt
# → Deletes file.txt if it exists

extract archive.tar.gz
# → Extracts archive.tar.gz (supports .zip, .rar, .7z, etc.)

spaceremover
# → Renames all files/dirs in current tree, replacing spaces with underscores

symlink /path/to/target linkname
# → Creates a symlink named 'linkname' pointing to 'target'
```

### Git Shortcuts

```sh
gs
# → git status

ga
# → git add .

gcm "Commit message"
# → git commit -m "Commit message"

gcm-fast "Quick commit"
# → git commit --no-verify -m "Quick commit"

glog
# → git log --oneline --graph --decorate --all

gi dir node_modules build
# → Add 'node_modules/' and 'build/' to .gitignore (if not already present)

gi file .env
# → Add '.env' to .gitignore

gi filetype log
# → Add '*.log' to .gitignore
```

### Docker Shortcuts

```sh
dcu
# → docker compose up

dcd
# → docker compose down

dps
# → docker ps

spdf
# → Launch Stirling-PDF Docker container and open browser when ready

n8n
# → Launch n8n Docker container and open browser when ready
```

### Disk, Homebrew, SSH

```sh
duh 3
# → Disk usage, depth 3

brewup
# → Update, upgrade, and cleanup Homebrew packages

ssh-agent-connect
# → Start SSH agent and add ~/.ssh/id_rsa
```

### OpenAI / PDF Tools

```sh
generate_random_pdf 1000 /tmp/random.pdf
# → Create a PDF with 1000 random characters at /tmp/random.pdf

te3l "Some text to embed"
# → Get OpenAI embedding for a string, output to te3l-<timestamp>.txt

te3l /path/to/file.pdf
# → Extract text from PDF, get OpenAI embedding, output to te3l-<timestamp>.txt
```

### .zshrc Backup

```sh
zshrc-push
# → Auto-commit and push your .zshrc to solution8-com/S8-Utilities on GitHub

zshrc-backup
# → Alias for zshrc-push
```

---

## Prerequisites

Some functions require additional tools:

- **Homebrew**: [Install here](https://brew.sh/)
- **pdftotext** (for `te3l` PDF embedding):  
  ```sh
  brew install poppler
  ```
- **cupsfilter** (for `generate_random_pdf`):  
  Pre-installed on macOS; otherwise, install CUPS.
- **7z** (for extracting .7z):  
  ```sh
  brew install p7zip
  ```
- **unrar** (for extracting .rar):  
  ```sh
  brew install unrar
  ```
- **uv** (for pip hygiene):  
  [uv project](https://github.com/astral-sh/uv)
- **jq** (for JSON processing, if needed elsewhere):  
  ```sh
  brew install jq
  ```
- **OpenAI API Key** (for `te3l`):  
  Store in macOS Keychain:
  ```sh
  security add-generic-password -a $(whoami) -s "openai_api_key" -w "sk-..."
  ```
- **GitHub Token** (for `zshrc-push`):  
  Store in macOS Keychain:
  ```sh
  security add-generic-password -a $(whoami) -s "github_s8_utilities" -w "ghp_..."
  ```

---

## Notes

- **PATH**: The `.zshrc` sets up a robust `PATH` for Homebrew, Go, Volta, and other tools.
- **Aliases & Functions**: Designed for macOS, but many work cross-platform.
- **Deduplication**: The `typeset -U path` ensures no duplicate entries in your `$PATH`.

---

## License

MIT License (c) Solution8 and contributors.

---

**Happy hacking!**
```