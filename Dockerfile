# 使用 Debian Bookworm 作為基底鏡像
FROM debian:bookworm-slim

# 設置環境變量以避免在安裝過程中出現交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 添加 Proxmox VE 官方的 APT 儲存庫
ADD proxmox.list /etc/apt/sources.list.d/proxmox.list
ADD --chown=_apt:root http://download.proxmox.com/debian/proxmox-release-bookworm.gpg /etc/apt/trusted.gpg.d

# 更新 APT 儲存庫並安裝必要軟件，然後清理快取以縮小映像大小
RUN apt update && \
    apt install --no-install-recommends -y zstd lzop gzip pve-qemu-kvm && \
    apt clean -m && \
    rm -rf /var/lib/apt/lists/*

# 工作目錄設定為 /data，所有操作都在此目錄進行
WORKDIR /data

# 複製轉換腳本並確保可執行
COPY --chmod=755 convert.sh /usr/local/bin/convert.sh

# 當容器運行時，執行腳本
ENTRYPOINT ["/usr/local/bin/convert.sh"]
