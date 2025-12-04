#!/bin/bash

# AutoAb1toPDF 打包脚本
# 用于创建 GitHub Release 的发布包

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 获取版本号（从 git tag 或手动指定）
VERSION="${1:-$(date +%Y%m%d)}"
RELEASE_NAME="AutoAb1toPDF-v${VERSION}"
PACKAGE_DIR="release-package"
ZIP_FILE="${RELEASE_NAME}.zip"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}AutoAb1toPDF 打包脚本${NC}"
echo -e "${GREEN}========================================${NC}"
echo "版本: ${VERSION}"
echo "发布包名称: ${RELEASE_NAME}"
echo ""

# 清理旧的打包目录
if [ -d "$PACKAGE_DIR" ]; then
    echo -e "${YELLOW}清理旧的打包目录...${NC}"
    rm -rf "$PACKAGE_DIR"
fi

# 创建打包目录
echo -e "${BLUE}[1/4] 创建打包目录...${NC}"
mkdir -p "$PACKAGE_DIR"

# 复制必要文件
echo -e "${BLUE}[2/4] 复制必要文件...${NC}"

# 复制主脚本
if [ -f "chromas_batch_print.ahk" ]; then
    cp "chromas_batch_print.ahk" "$PACKAGE_DIR/"
    echo -e "${GREEN}✓ 已复制 chromas_batch_print.ahk${NC}"
else
    echo -e "${RED}✗ 错误: 找不到 chromas_batch_print.ahk${NC}"
    exit 1
fi

# 复制 README
if [ -f "README.md" ]; then
    cp "README.md" "$PACKAGE_DIR/"
    echo -e "${GREEN}✓ 已复制 README.md${NC}"
fi

# 复制 AutoHotkey 安装程序（如果存在）
if [ -f "AutoHotkey_1.1.37.02_setup.exe" ]; then
    cp "AutoHotkey_1.1.37.02_setup.exe" "$PACKAGE_DIR/"
    echo -e "${GREEN}✓ 已复制 AutoHotkey 安装程序${NC}"
fi

# 创建使用说明文件（如果 README 不存在，创建一个简化版）
if [ ! -f "README.md" ]; then
    echo -e "${YELLOW}创建简化版使用说明...${NC}"
    cat > "$PACKAGE_DIR/使用说明.txt" << 'EOF'
AutoAb1toPDF - Chromas 批量导出 PDF 工具

快速开始：
1. 安装 AutoHotkey（如果未安装）
2. 安装 Chromas
3. 设置 Microsoft Print to PDF 为默认打印机
4. 将 .ab1 文件放入 C:\ab1\ab1_inputs
5. 双击运行 chromas_batch_print.ahk

详细说明请查看 README.md
EOF
    echo -e "${GREEN}✓ 已创建使用说明.txt${NC}"
fi

# 创建版本信息文件
echo -e "${BLUE}[3/4] 创建版本信息...${NC}"
cat > "$PACKAGE_DIR/VERSION.txt" << EOF
AutoAb1toPDF
版本: ${VERSION}
打包日期: $(date '+%Y-%m-%d %H:%M:%S')
EOF
echo -e "${GREEN}✓ 已创建版本信息${NC}"

# 打包成 zip
echo -e "${BLUE}[4/4] 打包成 ZIP 文件...${NC}"
cd "$PACKAGE_DIR"
zip -r "../${ZIP_FILE}" . -q
cd ..
echo -e "${GREEN}✓ 已创建 ${ZIP_FILE}${NC}"

# 显示文件大小
FILE_SIZE=$(du -h "${ZIP_FILE}" | cut -f1)
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}打包完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo "发布包文件: ${ZIP_FILE}"
echo "文件大小: ${FILE_SIZE}"
echo "打包目录: ${PACKAGE_DIR}/"
echo ""
echo -e "${YELLOW}下一步：${NC}"
echo "1. 检查 ${ZIP_FILE} 文件"
echo "2. 在 GitHub 上创建 Release 并上传此文件"
echo "3. 或使用 GitHub Actions 自动发布"
echo ""

