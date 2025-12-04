# AutoAb1toPDF - Chromas 批量导出 PDF 工具

## 📋 功能简介

本工具通过 AutoHotkey 自动操作 Chromas，将指定目录下的所有 `.ab1` 文件批量：

- 用 Chromas 打开
- 调用 Microsoft Print to PDF 打印
- 自动在指定目录下保存为同名 `.pdf` 文件

导出的图像内容与你手动在 Chromas 里 "Print → Microsoft Print to PDF" 完全一致，只是把所有手工操作自动化了。

## 🔧 环境要求

### 操作系统
- Windows 10 / Windows 11

### 软件依赖

#### 1. Chromas
- 已安装 Chromas
- 默认路径：`C:\Program Files\Chromas\Chromas.exe`
- 如果安装位置不同，需要在脚本中修改 `chromasExe` 这一行

#### 2. AutoHotkey（建议 v1.x 版本）
- 从官网安装完成后，双击 `.ahk` 文件即可运行
- 本发布包已包含 AutoHotkey 安装程序（可选）

#### 3. 打印机设置
- 系统中存在 **Microsoft Print to PDF** 虚拟打印机（Win10/11 默认自带）
- 将其设为**默认打印机**：
  1. 打开"设置" → "设备" → "打印机和扫描仪"
  2. 选中 "Microsoft Print to PDF"
  3. 点击 "设为默认"

#### 4. 资源管理器设置
- 需开启"显示文件扩展名"
- 脚本在内部是按完整文件名（含扩展名 `.ab1`）来匹配 Chromas 窗口的

**开启方法：**
- Windows 10: 打开任意资源管理器窗口 → 顶部点击「查看」→ 勾选「文件扩展名」
- Windows 11: 打开任意资源管理器窗口 → 顶部点击「查看」→ 显示 → 勾选「文件扩展名」

## 📁 目录结构

默认使用以下目录（可根据需要调整）：

```
C:\ab1
 ├─ ab1_inputs   ← 放需要转换的 .ab1 文件
 ├─ ab1_pdfs     ← 脚本会把生成的 .pdf 文件放到这里
 └─ chromas_batch_print.ahk   ← AutoHotkey 脚本文件
```

### 首次使用设置

1. 在 `C:\` 下新建一个文件夹 `ab1`
2. 在其中新建两个子目录：`ab1_inputs` 和 `ab1_pdfs`
3. 将脚本文件 `chromas_batch_print.ahk` 复制到 `C:\ab1\` 目录下

### 修改路径

如需修改路径，可在脚本里调整这三行：

```ahk
chromasExe  := "C:\Program Files\Chromas\Chromas.exe"
inputDir    := "C:\ab1\ab1_inputs"
outputDir   := "C:\ab1\ab1_pdfs"
```

## 🚀 使用步骤

### 1. 准备工作

确认已安装：
- ✅ Chromas
- ✅ AutoHotkey
- ✅ 系统默认打印机为 "Microsoft Print to PDF"

### 2. 放入待转换文件

将所有需要导出的 `.ab1` 文件拷贝到：
```
C:\ab1\ab1_inputs
```

### 3. 关闭所有已有的 Chromas 窗口

脚本会自己打开/关闭 Chromas，为避免干扰，请先把你手动开的 Chromas 全部关掉。

### 4. 运行脚本

1. 在资源管理器中找到 `C:\ab1\chromas_batch_print.ahk`
2. 双击运行
3. **这时请不要用键盘和鼠标乱点**，让脚本自动操作即可：
   - 你会看到 Chromas 反复打开/关闭
   - 中间会弹出 Print 和 "将打印输出另存为" 窗口一闪而过

### 5. 查看结果

脚本结束后会弹出一个提示框：
```
Done, All ab1 files processed.
```

前往 `C:\ab1\ab1_pdfs`，可以看到与 `.ab1` 同名的 `.pdf` 文件。

## ⚙️ 脚本逻辑说明（技术细节）

脚本的工作流程：

1. 遍历 `inputDir` 目录下的所有 `*.ab1` 文件
2. 对每个文件：
   - `Run` 启动 Chromas 并打开该文件
   - `WinWait` 等待 Chromas 主窗口出现
   - 发送 `Ctrl+P` 打开 Print 对话框
   - 在 Print 对话框中发送 `{Enter}`，使用默认打印机（Microsoft Print to PDF）
   - 等待 Print 窗口关闭
   - `WinWaitActive ahk_class #32770` 等待"将打印输出另存为"窗口
   - 记录该窗口句柄 `saveHwnd`，后续只等待这个窗口关闭
   - `Alt+N` 切换焦点到"文件名"输入框
   - 发送 `{Shift}` 把输入法切回英文（根据实际输入法可改成其他热键）
   - `Ctrl+A` 全选原来的文件名，`SendInput` 写入完整路径 `C:\ab1\ab1_pdfs\xxx.pdf`
   - `Alt+S` 相当于点击"保存"
   - `WinWaitClose ahk_id %saveHwnd%` 等待保存窗口关闭
   - 等 2 秒，关闭 Chromas 主窗口
3. 所有文件处理完毕后弹出 "Done" 提示框

## ⌨️ 输入法注意事项

脚本中有一行：

```ahk
Send, {Shift}
```

这是用来把输入法切回英文状态的（很多人是按一下 Shift 切中/英）。

如果你或你同事的输入法不是用 Shift 切换，可以改成：

### 使用 Ctrl+Space 切换：
```ahk
;Send, {Shift}
Send, ^{Space}
```

### 使用 Win+Space 切换：
```ahk
;Send, {Shift}
Send, #{Space}
```

**注意：**
- 把不用的那几行前面加上 `;`（注释），只保留实际有效的那一行
- 修改后保存脚本文件

## ❓ 常见问题 & 排查

### 问题 1: 脚本一运行就报错 "Cannot find program Chromas.exe"

**解决方案：**
- 检查 Chromas 安装路径是否与脚本中的 `chromasExe` 一致
- 如果 Chromas 安装在其他目录，比如 `C:\Program Files (x86)\Chromas\Chromas.exe`，就修改脚本相应路径

### 问题 2: 提示 "Cannot find Print dialog"

**解决方案：**
- 检查是否弹出的打印窗口标题不是 Print（极少见）
- 可在手动 `Ctrl+P` 后看看标题栏文字，如果不是 Print，需要在 `WinWaitActive, Print` 那里换成实际标题

### 问题 3: 提示 "Cannot find Save dialog" 或 "Save dialog did not close"

**解决方案：**
- 检查默认打印机是否为 "Microsoft Print to PDF"
- 看是否有其他对话框抢了焦点（比如某些安全提示弹窗）
- 确认保存窗口没有被你手动移动到别的屏幕/最小化

### 问题 4: 生成的 PDF 不在 ab1_pdfs

**解决方案：**
- 检查脚本中的 `outputDir` 路径是否与你期望一致
- 全盘搜索某个 ab1 对应的 pdf 文件名，看是否保存到了其他目录（例如"文档"）

### 问题 5: 脚本只打开 Chromas，不继续自动打印

**可能原因：**
- Windows 资源管理器未勾选「显示文件扩展名」，导致文件名不包含 `.ab1`
- Chromas 窗口标题不匹配

**解决方案：**
- 确认已开启「显示文件扩展名」（见环境要求第4条）
- 确认 `C:\ab1\ab1_inputs` 里的文件名都是以 `.ab1` 结尾，例如 `XXX.ab1`

## 📦 下载与安装

### 方式一：从 GitHub Release 下载（推荐）

1. **访问 Release 页面**
   ```
   https://github.com/Bupoo123/AutoAb1toPDF/releases
   ```

2. **下载最新版本**
   - 点击 `AutoAb1toPDF-v*.zip` 下载按钮
   - 或使用直接下载链接（将 `Bupoo123` 和版本号替换为实际值）：
     ```
     https://github.com/Bupoo123/AutoAb1toPDF/releases/latest/download/AutoAb1toPDF-v*.zip
     ```

3. **解压文件**
   - 解压 ZIP 文件到任意目录
   - 按照上述使用步骤配置

4. **快速开始**
   - 查看 [QUICK_START.md](QUICK_START.md) 获取 5 分钟快速配置指南

### 方式二：从源码构建

1. **克隆仓库**
   ```bash
   git clone https://github.com/Bupoo123/AutoAb1toPDF.git
   cd AutoAb1toPDF
   ```

2. **运行打包脚本**
   ```bash
   # 给脚本添加执行权限（macOS/Linux）
   chmod +x package-release.sh
   
   # 运行打包（可指定版本号）
   ./package-release.sh 1.0.0
   ```

3. **获取打包文件**
   - 打包完成后，在项目根目录会生成 `AutoAb1toPDF-v*.zip` 文件
   - 文件大小约 3-5MB（取决于是否包含 AutoHotkey 安装程序）

### 创建 GitHub Release

如需创建 GitHub Release，请查看 [RELEASE_GUIDE.md](RELEASE_GUIDE.md) 获取详细说明。

## 📝 版本历史

- **v1.0.0** - 初始版本
  - 支持批量转换 .ab1 文件为 PDF
  - 自动处理 Chromas 窗口和打印对话框

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

[根据实际情况填写许可证信息]

## 👤 作者

[根据实际情况填写作者信息]

---

**提示：** 如果遇到问题，请先查看"常见问题"部分，或提交 Issue 描述详细情况。

