# zst2vmdk

This repository provides a Docker-based solution for converting VMA files compressed with Zstandard (`.zst`) into VMDK format.

## How It Works

Conversion pipeline: `.vma.zst` → `.vma` → `.raw` → `.vmdk`

1. Decompress the Zstandard archive (`zstd`)
2. Extract the VMA backup (`vma extract`)
3. Convert the raw disk image to VMDK (`qemu-img convert`)
4. Clean up intermediate files automatically

## Installation

Pull the latest Docker image:

```bash
docker pull astroicers/zst2vmdk:latest
```

Or build from source:

```bash
git clone https://github.com/astroicers/zst2vmdk.git
cd zst2vmdk
docker build -t astroicers/zst2vmdk:latest .
```

## Usage

To convert a VMA file to VMDK, run the following command in your terminal. Make sure to replace `your-file.vma.zst` with the name of your actual file.

```bash
docker run -v $(pwd):/data --rm astroicers/zst2vmdk ./your-file.vma.zst
```

This command will output the converted VMDK file in the current directory.

## Upgrading

To ensure you are using the latest version of the Docker image, pull the latest image from Docker Hub:

```bash
docker pull astroicers/zst2vmdk:latest
```

## References

For more information and source code, visit the [GitHub repository](https://github.com/akaihola/docker-vma).
