# CLAUDE.md

## Project Overview

**zst2vmdk** is a Docker-based CLI tool that converts Proxmox VE backup files (`.vma.zst`) into VMDK format for use with other virtualization platforms (VMware, VirtualBox, etc.).

**Conversion pipeline:** `.vma.zst` → `zstd -d` → `.vma` → `vma extract` → `.raw` → `qemu-img convert` → `.vmdk`

## Tech Stack

- **Shell:** Bash (convert.sh - core conversion logic)
- **Container:** Docker (Debian Bookworm slim base)
- **Key tools inside container:** `zstd`, `vma` (from `pve-qemu-kvm`), `qemu-img`
- **APT repo:** Proxmox VE no-subscription repository

## File Structure

```
├── README.md        # User-facing documentation (English)
├── Dockerfile       # Container build definition
├── convert.sh       # Main conversion script (entry point)
└── proxmox.list     # Proxmox APT repository config
```

## Build & Run

```bash
# Build the Docker image
docker build -t astroicers/zst2vmdk:latest .

# Run a conversion
docker run -v $(pwd):/data --rm astroicers/zst2vmdk ./your-file.vma.zst
```

## Code Conventions

- Source code comments are written in **Traditional Chinese (繁體中文)**
- README and user-facing docs are in **English**
- Keep the codebase minimal — this is a single-purpose utility
- Dockerfile uses `--no-install-recommends` to minimize image size

## Important Notes

- The container mounts the current directory as `/data` for file I/O
- `convert.sh` expects exactly one argument: the `.vma.zst` filename
- Output VMDK is placed in `/data` (the mounted host directory)
- The `pve-qemu-kvm` package provides both `vma` and `qemu-img` commands
- Docker image is published to Docker Hub as `astroicers/zst2vmdk:latest`

## Known Limitations

- No error handling after `zstd`, `vma extract`, or `qemu-img` commands
- Variables are unquoted — filenames with spaces will break
- No cleanup of intermediate files (`.vma`, `.raw`) after conversion
- Only supports single-disk VMs (glob `disk-drive-*.raw` passed to single output)
- No CI/CD pipeline configured
- No automated tests
