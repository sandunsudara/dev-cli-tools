# dev-cli-tools

Portable personal CLI tools.

## What is included

- `myip` - shows your local IP address and public IP address.

## Install

You can install from the repository itself:

Run the installer from the repository root:

```bash
./install.sh
```

If you publish the repo on GitHub, you can also install it with `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/<owner>/dev-cli-tools/main/install.sh | bash
```

The installer copies the tools into `~/.dev-cli-tools/bin` and adds that folder to your shell PATH.

After installation, reload your shell:

```bash
source ~/.zshrc
```

If you use bash, reload `~/.bashrc` instead.

## How to use

After install, run the tool from any terminal:

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

Shows both the local IP address for your active network interface and the public IP address reported by the internet.

Use it whenever you need to quickly check how your machine is seen on the local network and the public internet.
