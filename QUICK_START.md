# 快速开始指南

## 📥 下载

### 方式一：从 GitHub Release 下载（推荐）

1. 访问项目的 Release 页面：
   ```
   https://github.com/bupoo123/AutoAb1toPDF/releases
   ```

2. 下载最新版本的 ZIP 文件：
   - 点击 `AutoAb1toPDF-v*.zip` 下载
   - 或使用直接下载链接（将 `bupoo123` 替换为实际用户名）：
     ```
     https://github.com/bupoo123/AutoAb1toPDF/releases/latest/download/AutoAb1toPDF-v*.zip
     ```

3. 解压 ZIP 文件到任意目录

### 方式二：从源码构建

```bash
# 克隆仓库
git clone https://github.com/bupoo123/AutoAb1toPDF.git
cd AutoAb1toPDF

# 运行打包脚本
./package-release.sh 1.0.0
```

## ⚡ 5 分钟快速配置

### 步骤 1: 安装依赖软件

1. **安装 AutoHotkey**
   - 如果发布包中包含 `AutoHotkey_1.1.37.02_setup.exe`，双击安装
   - 或从官网下载：https://www.autohotkey.com/

2. **安装 Chromas**
   - 确保 Chromas 已安装
   - 默认路径：`C:\Program Files\Chromas\Chromas.exe`

### 步骤 2: 系统设置

1. **设置默认打印机**
   - 打开"设置" → "设备" → "打印机和扫描仪"
   - 选中 "Microsoft Print to PDF"
   - 点击 "设为默认"

2. **显示文件扩展名**
   - 打开资源管理器
   - 查看 → 勾选"文件扩展名"

### 步骤 3: 创建目录结构

在 `C:\` 下创建以下目录：

```powershell
# 在 PowerShell 中执行
New-Item -ItemType Directory -Path "C:\ab1\ab1_inputs" -Force
New-Item -ItemType Directory -Path "C:\ab1\ab1_pdfs" -Force
```

或手动创建：
- `C:\ab1\ab1_inputs` - 存放待转换的 .ab1 文件
- `C:\ab1\ab1_pdfs` - 存放生成的 PDF 文件

### 步骤 4: 复制脚本

将 `chromas_batch_print.ahk` 复制到 `C:\ab1\` 目录

### 步骤 5: 修改脚本路径（如需要）

如果 Chromas 安装在其他位置，编辑 `C:\ab1\chromas_batch_print.ahk`，修改第一行：

```ahk
chromasExe  := "C:\你的Chromas路径\Chromas.exe"
```

## 🎯 使用

1. **放入文件**
   - 将所有 `.ab1` 文件复制到 `C:\ab1\ab1_inputs`

2. **运行脚本**
   - 双击 `C:\ab1\chromas_batch_print.ahk`
   - **不要操作键盘和鼠标**，让脚本自动运行

3. **查看结果**
   - 等待提示框显示 "Done, All ab1 files processed."
   - 在 `C:\ab1\ab1_pdfs` 查看生成的 PDF 文件

## ❓ 遇到问题？

查看 [README.md](README.md) 中的"常见问题"部分，或提交 Issue。

