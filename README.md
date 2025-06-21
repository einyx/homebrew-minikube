# Homebrew Minikube

This tap provides a custom build of minikube with SSH tunnel support for remote Docker contexts.

## Features

- Full SSH tunnel support for remote Docker contexts
- Cross-architecture support (ARM64 Mac -> x86_64 Linux)
- Automatic API server tunneling
- IPv4/IPv6 dual-stack support
- Enhanced reliability and timeout handling

## Installation

```bash
brew tap einyx/minikube
brew install einyx/minikube/minikube
```

## Usage

The binary will be installed as `minikube`. If you have the official minikube installed, you may want to uninstall it first:

```bash
brew uninstall minikube
brew install einyx/minikube/minikube
```

Or use it alongside the official version by calling it with its full path:

```bash
/opt/homebrew/opt/minikube/bin/minikube
```

## Version

This is based on minikube v1.36.0 with additional SSH tunnel support patches.

## What's Different?

This build includes:
- Automatic SSH tunnel creation for remote Docker contexts
- Better timeout handling for remote connections
- IPv6/IPv4 dual-stack tunnel support
- Enhanced status detection for SSH tunneled connections
- Retry logic and reliability improvements

## Example Usage

```bash
# Create a remote Docker context
docker context create remote --docker "host=ssh://user@remote-host"
docker context use remote

# Start minikube (will automatically detect and use SSH tunnels)
minikube start --driver=docker

# Update context to use SSH tunnel
minikube update-context
```

## License

Apache License 2.0 (same as upstream minikube)