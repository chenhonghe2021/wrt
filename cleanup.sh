#!/bin/sh

# iStoreOS/OpenWrt 精简空间清理脚本
# 仅执行安全、常用的清理操作，不涉及防火墙或系统核心配置。

# --- 颜色定义 ---
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
NC='\033[0m' # No Color

echo -e "${CYAN}===========================================${NC}"
echo -e "${CYAN}🚀 iStoreOS/OpenWrt 空间清理程序启动${NC}"
echo -e "${CYAN}===========================================${NC}"

# 1. 清理 opkg 软件包缓存
echo -e "\n${YELLOW}--- 1. 清理 opkg 软件包缓存 ---${NC}"
OPKG_CACHE="/var/opkg-lists"
if [ -d "$OPKG_CACHE" ]; then
    echo "正在移除 opkg 软件包列表缓存..."
    find "$OPKG_CACHE" -type f -delete
    echo -e "${GREEN}✅ opkg 缓存清理完成。${NC}"
else
    echo "opkg 缓存目录不存在，跳过。"
fi

# 2. 清理临时目录
echo -e "\n${YELLOW}--- 2. 清理 /tmp 临时文件 ---${NC}"
TMP_DIR="/tmp"
if [ -d "$TMP_DIR" ]; then
    echo "正在移除 /tmp 下的所有临时文件 (通常在内存中)..."
    rm -rf ${TMP_DIR}/* 2>/dev/null
    echo -e "${GREEN}✅ /tmp 临时文件清理完成。${NC}"
else
    echo "/tmp 目录不存在，跳过。"
fi

# 3. 清空系统日志 (日志通常在内存中)
echo -e "\n${YELLOW}--- 3. 清空系统日志 (Log) ---${NC}"
if command -v logread >/dev/null 2>&1; then
    logread -l 0 > /dev/null 2>&1
    echo -e "${GREEN}✅ 系统日志已清空。${NC}"
else
    echo "logread 命令不可用，跳过日志清理。"
fi

# 4. 释放系统缓存 (提高可用内存，不清理磁盘空间)
echo -e "\n${YELLOW}--- 4. 释放系统内存缓存 ---${NC}"
if [ -w /proc/sys/vm/drop_caches ]; then
    sync
    echo 3 > /proc/sys/vm/drop_caches
    echo -e "${GREEN}✅ 内存缓存 (PageCache, Dentries, Inodes) 已释放。${NC}"
else
    echo "不支持释放内存缓存，跳过。"
fi


# 5. Docker 系统清理 (如果 Docker 已安装)
echo -e "\n${YELLOW}--- 5. Docker 系统清理 (清理镜像/容器垃圾) ---${NC}"
if command -v docker >/dev/null 2>&1; then
    echo "检测到 Docker 已安装。正在执行系统深度清理..."
    # 清理所有未使用的容器、网络、镜像（包括悬空镜像）和构建缓存
    docker system prune -a -f
    
    # 清理所有未使用的 Volumes (数据卷)
    echo "正在清理所有未使用的 Docker 数据卷..."
    docker volume prune -f
    
    echo -e "${GREEN}✅ Docker 深度清理完成。${NC}"
else
    echo "Docker 未安装，跳过 Docker 清理。"
fi

echo -e "\n${CYAN}===========================================${NC}"
echo -e "${GREEN}🎉 所有清理任务已完成！${NC}"
echo -e "${CYAN}===========================================${NC}"

# 显示清理后的可用空间
echo -e "\n${YELLOW}--- 当前磁盘可用空间 ---${NC}"
df -h
echo -e "${NC}"
