#!/bin/bash
# convert.sh
set -euo pipefail

# 檢查輸入參數
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename>.vma.zst"
  exit 1
fi

INPUT_FILE="$1"
VMA_FILE="${INPUT_FILE%.zst}"
EXTRACT_DIR="$(basename "$VMA_FILE" .vma)"

# 解壓 .zst 文件
echo "正在解壓: ${INPUT_FILE}"
zstd -d "$INPUT_FILE"

# 提取 VMA 文件
echo "正在提取 VMA: ${VMA_FILE}"
vma extract "$VMA_FILE" "$EXTRACT_DIR"

# 進入提取後的目錄
cd "$EXTRACT_DIR"

# 轉換磁碟映像為 VMDK
echo "正在轉換為 VMDK..."
qemu-img convert -f raw disk-drive-*.raw -O vmdk "${EXTRACT_DIR}.vmdk"

# 將生成的 VMDK 搬移到 /data 目錄下
mv "${EXTRACT_DIR}.vmdk" /data/

# 清理中間檔案
echo "正在清理中間檔案..."
cd /data
rm -f "$VMA_FILE"
rm -rf "$EXTRACT_DIR"

echo "轉換完成: ${EXTRACT_DIR}.vmdk"
