# GitHub Release 发布指南

本指南说明如何为 AutoAb1toPDF 项目创建 GitHub Release，方便用户下载完整打包文件。

## 🚀 方式一：使用 GitHub Actions 自动发布（推荐）

### 前提条件
- 项目已推送到 GitHub
- GitHub Actions 已启用（默认启用）

### 步骤

#### 方法 A：通过 Git Tag 触发（推荐）

1. **创建并推送 Git Tag**
   ```bash
   # 在项目根目录执行
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **自动触发 Release**
   - 推送 tag 后，GitHub Actions 会自动运行
   - 自动打包文件并创建 Release
   - 你可以在 Actions 标签页查看进度

#### 方法 B：手动触发 GitHub Actions

1. **在 GitHub 网页上操作**
   - 进入项目的 Actions 标签页
   - 选择 "Create Release" workflow
   - 点击 "Run workflow"
   - 输入版本号（例如：1.0.0）
   - 点击 "Run workflow" 按钮

2. **等待完成**
   - 在 Actions 页面查看运行状态
   - 完成后会自动创建 Release

### Release 链接格式

发布完成后，Release 链接格式为：
```
https://github.com/Bupoo123/AutoAb1toPDF/releases/tag/v1.0.0
```

所有 Release 列表：
```
https://github.com/Bupoo123/AutoAb1toPDF/releases
```

## 📦 方式二：手动创建 Release

如果不想使用 GitHub Actions，可以手动创建 Release：

### 步骤

1. **本地打包**
   ```bash
   # 在项目根目录执行打包脚本
   ./package-release.sh 1.0.0
   ```
   这会生成 `AutoAb1toPDF-v1.0.0.zip` 文件

2. **在 GitHub 上创建 Release**
   - 进入项目页面
   - 点击右侧 "Releases" → "Create a new release"
   - 或直接访问：`https://github.com/Bupoo123/AutoAb1toPDF/releases/new`

3. **填写 Release 信息**
   - **Tag version**: 输入 `v1.0.0`（或你的版本号）
   - **Release title**: `AutoAb1toPDF v1.0.0`
   - **Description**: 填写发布说明，例如：
     ```markdown
     ## AutoAb1toPDF v1.0.0
     
     ### 📦 下载
     点击下方下载按钮下载完整发布包。
     
     ### 🚀 快速开始
     1. 解压下载的 ZIP 文件
     2. 安装 AutoHotkey（如果未安装，发布包中包含安装程序）
     3. 安装 Chromas
     4. 设置 Microsoft Print to PDF 为默认打印机
     5. 将脚本复制到 `C:\ab1\` 目录
     6. 按照 README.md 中的说明使用
     
     ### 📝 详细说明
     请查看发布包中的 README.md 文件获取完整使用说明。
     ```

4. **上传文件**
   - 点击 "Attach binaries by dropping them here or selecting them"
   - 选择 `AutoAb1toPDF-v1.0.0.zip` 文件
   - 等待上传完成

5. **发布**
   - 确认信息无误后，点击 "Publish release" 按钮

## 🔗 获取 Release 下载链接

发布完成后，你可以获取以下链接：

### 最新版本下载链接
```
https://github.com/Bupoo123/AutoAb1toPDF/releases/latest/download/AutoAb1toPDF-v1.0.0.zip
```

### 特定版本下载链接
```
https://github.com/Bupoo123/AutoAb1toPDF/releases/download/v1.0.0/AutoAb1toPDF-v1.0.0.zip
```

### Release 页面链接
```
https://github.com/Bupoo123/AutoAb1toPDF/releases
```

## 📋 发布检查清单

在创建 Release 前，请确认：

- [ ] 已测试脚本功能正常
- [ ] README.md 文档完整且准确
- [ ] 版本号已更新
- [ ] 所有必要文件已包含在打包中：
  - [ ] `chromas_batch_print.ahk`
  - [ ] `README.md`
  - [ ] `AutoHotkey_1.1.37.02_setup.exe`（可选）
- [ ] 已测试打包文件可以正常解压和使用

## 🎯 版本号规范建议

建议使用语义化版本号（Semantic Versioning）：
- **主版本号**：不兼容的 API 修改
- **次版本号**：向下兼容的功能性新增
- **修订号**：向下兼容的问题修正

示例：
- `v1.0.0` - 初始版本
- `v1.1.0` - 新增功能
- `v1.1.1` - 修复 bug
- `v2.0.0` - 重大更新

## 💡 使用示例

### 在 README 中添加下载链接

你可以在 README.md 中添加下载链接：

```markdown
## 📥 下载

### 最新版本
[下载最新版本](https://github.com/Bupoo123/AutoAb1toPDF/releases/latest)

### 所有版本
[查看所有版本](https://github.com/Bupoo123/AutoAb1toPDF/releases)
```

### 在文档中引用

```markdown
请从 [GitHub Releases](https://github.com/Bupoo123/AutoAb1toPDF/releases) 下载最新版本。
```

## 🔧 故障排除

### GitHub Actions 未触发

- 检查 `.github/workflows/release.yml` 文件是否存在
- 确认 GitHub Actions 在项目设置中已启用
- 检查 tag 格式是否正确（必须以 `v` 开头）

### 打包文件过大

- GitHub Release 单个文件限制为 2GB
- 如果超过限制，考虑：
  - 移除不必要的文件（如测试数据）
  - 使用 Git LFS
  - 分多个文件上传

### 权限问题

- 确保你有仓库的写入权限
- 如果是组织仓库，可能需要管理员权限来创建 Release

---

**提示**：首次发布建议使用手动方式，熟悉流程后再使用自动化方式。

