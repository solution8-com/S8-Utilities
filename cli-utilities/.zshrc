# ========================
# Zsh Configuration File
# ========================

# Use modern Zsh features
autoload -U compinit && compinit
setopt autocd extendedglob

# ====== PATH ======
# Add custom directories to PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin"

# Core system paths
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/System/Cryptexes/App/usr/bin"
export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin"

# Cryptex-related paths
export PATH="$PATH:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin"
export PATH="$PATH:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin"
export PATH="$PATH:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin"

# User-specific paths
export PATH="$HOME/.volta/bin:$HOME/.local/bin:$HOME/.orbstack/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$HOME/.ch/bin:$PATH"

# Go Programming Language Setup
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Added by Antigravity
export PATH="/Users/thedawgctor/.antigravity/antigravity/bin:$PATH"

# ====== ENVIRONMENT VARIABLES ======

export NODE_ENV="development"

# NVM (for managing Node.js versions) - we use volta instead
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ====== ALIASES ======
alias ll='ls -lahG'              # Long list with hidden files and human-readable sizes
alias grep='grep --color=auto'   # Grep with colorized output by default
alias gs='git status'
alias ga='git add .'

function gcm() {
  git commit -m "$*"
}

function gcm-fast() {
  git commit --no-verify -m "$*"
}

alias gp='git push'
alias gpl='git pull'

# uv hygiene
alias pip='echo "Use: uv pip install or python -m pip"'
alias pip3='echo "Use: uv pip install or python -m pip"'

# Docker shortcuts
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dps="docker ps"

# getting json diff of global evoluaion user reports
alias jsondiff-regent='python3 ~/Desktop/\[dawg-workfolder\]AIRtools/global-scripts/jsondiff_regent.py'


# Alias for launching Stirling-PDF Docker container and frontend
alias spdf='docker run -d \
  --name stirling-pdf \
  -p 8080:8080 \
  -v "$(pwd)/stirling-data:/configs" \
  stirlingtools/stirling-pdf:latest && \
  echo "Waiting for Stirling-PDF to become healthy..." && \
  for i in $(seq 1 60); do \
    if curl -s -f http://localhost:8080/api/v1/health > /dev/null; then \
      echo "Stirling-PDF is healthy! Launching browser..."; \
      xdg-open http://localhost:8080 || open http://localhost:8080 || start http://localhost:8080; \
      break; \
    fi; \
    sleep 1; \
  done || echo "Stirling-PDF did not become healthy within the expected time."
'

# Alias for launching n8n Docker container and frontend
alias n8n='docker run -d \
  --name n8n \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n && \
  echo "Waiting for n8n to become healthy..." && \
  for i in $(seq 1 60); do \
    if curl -s -f http://localhost:5678/healthz/readiness > /dev/null; then \
      echo "n8n is healthy! Launching browser..."; \
      xdg-open http://localhost:5678 || open http://localhost:5678 || start http://localhost:5678; \
      break; \
    fi; \
    sleep 1; \
  done || echo "n8n did not become healthy within the expected time."
'

# ====== FUNCTIONS ======

## Create a directory and move into it immediately:
mkcd() { mkdir -p "$1" && cd "$1"; }

## Kill a process by name:
killit() { ps aux | grep "$1" | grep -v "grep" | awk '{print $2}' | xargs kill; }

## Extract almost any type of compressed file:
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xvjf "$1" ;;
            *.tar.gz)    tar xvzf "$1" ;;
            *.bz2)       bunzip2 "$1" ;;
            *.rar)       unrar x "$1" ;;
            *.gz)        gunzip "$1" ;;
            *.tar)       tar xvf "$1" ;;
            *.tbz2)      tar xvjf "$1" ;;
            *.tgz)       tar xvzf "$1" ;;
            *.zip)       unzip "$1" ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1" ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}

## Git log visualization shortcut:
glog() { git log --oneline --graph --decorate --all; }

## Check disk usage in human-readable format:
duh() { du -h -d "${1:-2}"; }

## Update all Homebrew packages and applications (macOS-specific):
brewup() { brew update && brew upgrade && brew cleanup; }

## Wrapper for SSH with agent forwarding enabled:
ssh-agent-connect() {
    ssh-add ~/.ssh/id_rsa && ssh-agent bash;
}

# Function to generate a random PDF with specified character count and output path
# Usage: generate_random_pdf <num_characters> <output_pdf_path>
generate_random_pdf() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: generate_random_pdf <num_characters> <output_pdf_path>"
        return 1
    fi

    local num_chars="$1"
    local output_path="$2"
    local temp_text_file=$(mktemp "/tmp/random_text_XXXXXX.txt")

    echo "Generating $num_chars random characters..."

    # Generate random characters and save to a temporary file
    head -c "$num_chars" /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9\n\r\t ' > "$temp_text_file"

    # Check if text generation was successful
    if [ ! -s "$temp_text_file" ]; then
        echo "Error: Failed to generate random text."
        rm -f "$temp_text_file"
        return 1
    fi

    echo "Converting to PDF: $output_path"

    # Convert the temporary text file to PDF using cupsfilter
    if cupsfilter -i 'text/plain' "$temp_text_file" > "$output_path"; then
        echo "Successfully created PDF."
    else
        echo "Error: Failed to create PDF."
        rm -f "$output_path" # Clean up potentially corrupted PDF
        return 1
    fi

    # Clean up the temporary text file
    rm -f "$temp_text_file"
}

# te3l – embed a plain text string **or** the text of a PDF file
te3l() {
  # --------------------------------------------------------------
  # Usage check – exactly one argument required
  # --------------------------------------------------------------
  if [ $# -ne 1 ]; then
    echo "Usage: te3l '<text string>'   OR   te3l /path/to/file.pdf"
    return 1
  fi

  local input="$1"

  # --------------------------------------------------------------
  # Retrieve OpenAI API key from the macOS Keychain
  # --------------------------------------------------------------
  local api_key=$(security find-generic-password -a "$(whoami)" -s "openai_api_key" -w 2>/dev/null)
  if [ -z "$api_key" ]; then
    echo "Error: OpenAI API key not found in Keychain."
    echo "Run: security add-generic-password -a \$(whoami) -s 'openai_api_key' -w 'sk-your-key'"
    return 1
  fi

  # --------------------------------------------------------------
  # If the argument is a PDF file, extract its text
  # --------------------------------------------------------------
  if [[ -f "$input" && "$input" == *.pdf ]]; then
    # Ensure pdftotext is available
    if ! command -v pdftotext >/dev/null 2>&1; then
      echo "Error: 'pdftotext' is required to embed PDFs but is not installed."
      echo "Install via Homebrew: brew install poppler"
      return 1
    fi

    # Create a temporary file for the extracted text
    local tmp_txt
    tmp_txt=$(mktemp /tmp/te3l_pdf_XXXX.txt)

    # Extract text; -layout keeps the visual layout (optional)
    pdftotext -layout "$input" "$tmp_txt"

    # Read the extracted text into a variable (preserve newlines)
    input=$(cat "$tmp_txt")
    # Cleanup the temporary file
    rm -f "$tmp_txt"
  fi

  # --------------------------------------------------------------
  # Timestamp for a unique output filename (Copenhagen timezone)
  # --------------------------------------------------------------
  local cph_timestamp=$(TZ=Europe/Copenhagen date '+%m-%d-%H:%M:%S')
  local out_file="te3l-${cph_timestamp}.txt"

  # --------------------------------------------------------------
  # Make the API request – note that we JSON‑encode the text safely
  # --------------------------------------------------------------
  # Escape double‑quotes and backslashes for correct JSON payload
  local escaped_input=$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')
  # The payload is: {"input": "<escaped_input>", "model": "text-embedding-3-large"}
  curl -s -X POST https://api.openai.com/v1/embeddings \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $api_key" \
    -d "{\"input\": $escaped_input, \"model\": \"text-embedding-3-large\"}" \
    -o "$out_file"

  # echo "Embedding saved to te3l-${cph_timestamp}.txt"
  echo "Embedding saved to $(realpath "$out_file")"   # ← NEW: absolute path output

}


del() { if [ -f "$1" ]; then rm -rf "$1"; else echo "Error: not a file"; fi; }

# Auto-commit .zshrc function
zshrc-push() {

  local token=$(security find-generic-password -a "$(whoami)" -s "github_s8_utilities" -w 2>/dev/null)
  
  if [ -z "$token" ]; then
    echo "Error: GitHub token for S8-Utilities not found. Store it:"
    echo "  security add-generic-password -a \"\$(whoami)\" -s \"github_s8_utilities\" -w \"github_pat_...\""
    return 1
  fi

  local repo_dir=$(mktemp -d /tmp/s8-utilities.XXXXXX)
  
  # Clone fresh each time
  if ! git clone https://x-access-token:$token@github.com/solution8-com/S8-Utilities.git "$repo_dir"; then
    echo "❌ Failed to clone S8-Utilities. Check token permissions."
    rm -rf "$repo_dir"
    return 1
  fi
  
  # Ensure cli-utilities folder exists
  mkdir -p "$repo_dir/cli-utilities"
  
  # Copy .zshrc to cli-utilities folder
  cp ~/.zshrc "$repo_dir/cli-utilities/.zshrc"
  
  cd "$repo_dir"
  
  git add cli-utilities/.zshrc
  if git commit -m "cli-utilities: Auto-update .zshrc $(TZ=Europe/Copenhagen date '+%Y-%m-%d %H:%M:%S %Z')"; then
    if git push origin main; then
      echo "✅ .zshrc pushed to solution8-com/S8-Utilities/cli-utilities/.zshrc"
    else
      echo "❌ Push failed"
    fi
  else
    echo "ℹ️  No changes to commit"
  fi
  
  cd -
  
  # Clean up local clone
  rm -rf "$repo_dir"
  
  echo "🧹 Local clone removed. All clean!"

}

# Optional: alias for convenience
alias zshrc-backup="zshrc-push"


# Automatically deduplicate $path array in Zsh (optional)
typeset -U path

symlink() { if [ "$#" -ne 2 ]; then echo "Usage: symlink <target> <name>"; return 1; fi; ln -s "$1" "$2"; }
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export VOYAGEAI_KEY="pa-vXAy0nyIIo7G4i-r7cNsZXHlZhFSqRGzBYwwwupR0Yj"
gi() {
  local mode="$1"
  shift || true
  local gitignore=".gitignore"
  [[ -e "$gitignore" ]] || : > "$gitignore"

  _gi_append_unique() {
    local entry="$1"
    grep -Fxq -- "$entry" "$gitignore" || printf '%s\n' "$entry" >> "$gitignore"
  }

  case "$mode" in
    dir)
      local p
      if [[ $# -lt 1 ]]; then
        printf 'usage: gi dir <dir> [dir ...]\n' >&2
        return 1
      fi

      for p in "$@"; do
        [[ -d "$p" ]] || {
          printf 'gi: not a directory: %s\n' "$p" >&2
          continue
        }
        _gi_append_unique "${p%/}/"
      done
      ;;

    file)
      if [[ $# -ne 1 ]]; then
        printf 'usage: gi file <file>\n' >&2
        return 1
      fi

      [[ -f "$1" ]] || {
        printf 'gi: not a file: %s\n' "$1" >&2
        return 1
      }

      _gi_append_unique "$1"
      ;;

    filetype)
      if [[ $# -ne 1 ]]; then
        printf 'usage: gi filetype "ext"\n' >&2
        return 1
      fi

      local ext="$1"
      ext="${ext#.}"
      _gi_append_unique "*.${ext}"
      ;;

    *)
      printf 'usage:\n' >&2
      printf '  gi dir <dir> [dir ...]\n' >&2
      printf '  gi file <file>\n' >&2
      printf '  gi filetype "ext"\n' >&2
      return 1
      ;;
  esac
}

# Rename files that contain spaces, replacing spaces with underscores.
# Usage:   spaceremover
# --------------------------------------------------------------
spaceremover() {
  # Find all files (and directories) whose name contains a space,
  # processing deepest paths first (--depth) so parent directories are
  # renamed after their contents.
  find . -depth -name '* *' -print0 |
    while IFS= read -r -d '' f; do
      # Directory part (may be '.' for top‑level files)
      d=${f%/*}
      # Base name without path
      b=${f##*/}
      # New name with spaces replaced by underscores
      new="${b// /_}"
      # Only rename if the target does NOT already exist
      if [[ "$b" != "$new" && ! -e "$d/$new" ]]; then
        mv -- "$f" "$d/$new"
      fi
    done
}
