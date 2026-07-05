#!/usr/bin/env bash
# Uses env to locate bash for portability across systems

set -euo pipefail
# -e: exit on error
# -u: treat unset variables as errors
# -o pipefail: fail pipeline if any command fails

REPO_URL="https://github.com/sandunsudara/dev-cli-tools.git"
# Canonical repo location, used as a fallback when there's no local clone
# (e.g. when this script is run via `curl ... | bash` and $0 is just "bash",
# so dirname "$0" can't point at a real repo directory on disk)

CANDIDATE_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)"
# Try to resolve the directory this script lives in. Only meaningful when
# the script is executed as a real file (e.g. ./install.sh from a clone).

if [ -n "$CANDIDATE_DIR" ] && [ -d "$CANDIDATE_DIR/bin" ]; then
  REPO_DIR="$CANDIDATE_DIR"
  # Local clone case: bin/ sits right next to this script, use it directly
else
  TMP_DIR="$(mktemp -d)"
  # No local bin/ found (curl-pipe case) - clone the repo into a temp dir
  git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1
  REPO_DIR="$TMP_DIR"
fi

INSTALL="$HOME/.dev-cli-tools"
# Define installation directory in user's home folder

mkdir -p "$INSTALL/bin"
# Create installation bin directory if it doesn't exist (-p prevents errors)

cp -R "$REPO_DIR/bin/." "$INSTALL/bin/"
# Copy all CLI tools from repo bin folder to install bin folder
# -R ensures recursive copy of all files/folders

chmod +x "$INSTALL/bin"/* || true
# Make all copied files executable
# '|| true' prevents script from failing if no files exist or chmod errors occur

RC="$HOME/.bashrc"; [ "$(basename "${SHELL:-}")" = "zsh" ] && RC="$HOME/.zshrc"
# Detect the user's actual LOGIN shell via $SHELL (set by the OS), not which
# shell happens to be executing this script right now.
# BASH_VERSION is unreliable here: piping into bash (curl ... | bash) always
# sets BASH_VERSION, which would incorrectly point to .bashrc even for zsh
# users. $SHELL reflects the shell the user actually uses day to day.

LINE='export PATH="$HOME/.dev-cli-tools/bin:$PATH"'
# PATH export line that enables global access to installed CLI tools

grep -Fq "$LINE" "$RC" 2>/dev/null || {
  # Check if PATH line already exists in shell config file
  # -F: fixed string match (no regex)
  # -q: quiet mode (no output, only exit status)

  echo ''
  # Add blank line for readability in shell config

  echo '# Dev CLI Tools'
  # Add comment header for easy identification in config file

  echo "$LINE"
  # Append PATH export line
} >> "$RC"
# If LINE is not found, append the block to shell config file

echo "Done. Run: source $RC"
# Print instruction to reload shell configuration in current terminal