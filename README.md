# Meshbrow Homebrew Tap

Official Homebrew tap for [Meshbrow](https://meshbrow.dev) — the Managed Browser Fleet for AI Agents.

## Installation

```bash
brew tap meshbrow-dev/tap
brew install meshbrow
```

## Upgrade

```bash
brew upgrade meshbrow
```

## Usage

```bash
# Authenticate
meshbrow auth login --key mb_live_your_key_here

# Launch a session
meshbrow sessions create --stealth max --proxy-country US

# List sessions
meshbrow sessions list

# Full help
meshbrow --help
```

## Manual Installation

If you prefer not to use Homebrew:

### macOS / Linux

```bash
curl -sSL https://get.meshbrow.dev | sh
```

### From source

```bash
git clone https://github.com/meshbrow-dev/meshbrow-backend.git
cd meshbrow-backend
make install
```

## Formula Source

This tap is auto-updated by [GoReleaser](https://goreleaser.com) on each release of the `meshbrow-backend` repository.
