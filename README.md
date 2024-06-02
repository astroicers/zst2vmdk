# zst2vmdk

This repository provides a Docker-based solution for converting VMA files compressed with Zstandard (`.zst`) into VMDK format.

## Installation

Pull the latest Docker image:

```bash
docker pull astroicers/zst2vmdk:latest
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
