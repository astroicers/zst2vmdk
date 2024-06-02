#!/bin/bash
# convert.sh

# 檢查輸入參數
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename>.vma.zst"
  exit 1
fi

# 解壓 .zst 文件
zstd -d $1
vma_filename=$(echo $1 | sed 's/.zst//')

# 提取 VMA 文件
vma extract $vma_filename $(basename $vma_filename .vma)

# 進入提取後的目錄
cd $(basename $vma_filename .vma)

# 轉換磁碟映像為 VMDK
qemu-img convert -f raw disk-drive-*.raw -O vmdk $(basename $vma_filename .vma).vmdk

# 將生成的 VMDK 搬移到 /data 目錄下
mv $(basename $vma_filename .vma).vmdk /data/
