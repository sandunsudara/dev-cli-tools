# dev-cli-tools

Portable personal CLI tools you can install on any machine in seconds.

## What is included

| Tool   | Description                                                  |
|--------|---------------------------------------------------------------|
| `myip` | Shows your local IP address and your public IP address.       |

## Install

There are two ways to install: directly from a cloned copy of the repo, or with a single `curl` command pointed at GitHub.

### Option 1: Install with curl (recommended, from GitHub)

If the repo is published on GitHub, this is the fastest way — no cloning required:

```bash
curl -fsSL https://raw.githubusercontent.com/sandunsudara/dev-cli-tools/main/install.sh | bash
```

Replace `my` with your actual GitHub username or organization if it differs.

### Option 2: Install from a local clone

If you already have the repository on your machine, run the installer from the repo root:

```bash
git clone https://github.com/sandunsudara/dev-cli-tools.git
cd dev-cli-tools
./install.sh
```

### After installing (either option)

The installer copies the tools into `~/.dev-cli-tools/bin` and adds that folder to your shell PATH. Reload your shell so the change takes effect:

| Shell | Command                    |
|-------|-----------------------------|
| zsh   | `source ~/.zshrc`           |
| bash  | `source ~/.bashrc`          |

## How to use

Once installed, run any tool from any terminal:

```bash
myip
```

Example output:

```bash
Local IP:  192.168.1.10
Public IP: 203.0.113.25
```

## Available functions

### `myip`

Shows both the local IP address for your active network interface and the public IP address reported by the internet. Use it whenever you need to quickly check how your machine is seen on the local network vs. the public internet.

## Distributing this project on other platforms

Right now this repo is installed via a raw `curl | bash` script pointed at GitHub. If you want to reach more users or make installation feel more "native," here are the common distribution options, what they involve, and when to use each:

| Platform / Method        | What it involves                                                                                   | Best for                                      |
|---------------------------|-----------------------------------------------------------------------------------------------------|------------------------------------------------|
| **curl + GitHub raw** (current) | Host `install.sh` in the repo; users pipe it to `bash`. No registry, no build step.           | Quick personal tools, minimal setup            |
| **npm**                   | Add a `package.json` with a `bin` field pointing to your script(s); publish with `npm publish`. Users install via `npm install -g dev-cli-tools`. | JS/Node tools, or any script you want versioned and updatable via `npm update` |
| **Homebrew (macOS/Linux)** | Create a "tap" repo (`homebrew-dev-cli-tools`) with a Formula file describing how to build/install. Users run `brew tap my/dev-cli-tools && brew install myip`. | Mac-heavy audience, want auto-updates via `brew upgrade` |
| **Own domain**            | Point a domain (e.g. `get.yourdomain.com`) at a redirect or static file that serves `install.sh`. Lets you write `curl -fsSL https://get.yourdomain.com | bash` instead of a long GitHub URL. | Branding, shorter install command, decoupling from GitHub |
| **Cargo (crates.io)**      | If tools are written in Rust, publish as a crate with `cargo publish`. Users install via `cargo install dev-cli-tools`. | Rust-based CLI tools |
| **APT/YUM package**        | Build a `.deb` or `.rpm` and host it in a package repository (self-hosted or via PPA). Users install via `apt install` / `yum install`. | Linux distro-native install, enterprise environments |

**General pattern:** each platform wants (1) a manifest or spec file describing the package (e.g. `package.json` for npm, a Formula for Homebrew, `Cargo.toml` for Cargo), and (2) a place to host the built artifact (a registry, a tap repo, or your own server). The `curl | bash` approach you're using now works everywhere with zero setup, but the trade-off is no built-in versioning, update command, or uninstall — those come "for free" once you're on a package manager.