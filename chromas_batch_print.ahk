chromasExe  := "C:\Program Files\Chromas\Chromas.exe"  ; ← 改成你的 Chromas 路径
inputDir    := "C:\ab1\ab1_inputs"
outputDir   := "C:\ab1\ab1_pdfs"

#NoEnv
#SingleInstance Force
SetTitleMatchMode, 2
FileCreateDir, %outputDir%

Loop, Files, %inputDir%\*.ab1
{
    ab1FullPath := A_LoopFileFullPath
    ab1Name     := A_LoopFileName
    ab1Base     := RegExReplace(ab1Name, "\.ab1$", "")

    ; 1. 打开 Chromas
    Run, "%chromasExe%" "%ab1FullPath%", , , chromasPID

    ; 2. 等主窗口
    WinWait, %ab1Name%
    WinActivate
    Sleep, 300

    ; 3. Ctrl+P 打开 Print
    Send, ^p

    ; 4. 等 Print 对话框
    WinWaitActive, Print,,5
    if ErrorLevel
    {
        MsgBox, 16, Error, Cannot find Print dialog for %ab1Name%
        WinClose, %ab1Name%
        continue
    }

    ; 5. 回车 = 确认打印
    Send, {Enter}

    ; 6. 等 Print 窗口关掉
    WinWaitClose, Print,,5

       ; 7. 等“将打印输出另存为”窗口（class #32770）
    WinWaitActive, ahk_class #32770,,10
    if ErrorLevel
    {
        MsgBox, 16, Error, Cannot find Save dialog for %ab1Name%
        WinClose, %ab1Name%
        continue
    }

    ; 记录当前这个保存窗口的句柄（只盯它）
    WinGet, saveHwnd, ID, A

    ; 8. 构造完整路径
    pdfFullPath := outputDir . "\" . ab1Base . ".pdf"

    ; 把焦点切到“文件名(N)”输入框：Alt+N
    Send, !n
    Sleep, 200

    ; ★ 这里是你刚才调好的“切到英文输入法”的那几行 ★
    ;（保持你现在的版本，不用改）
    ; 比如：
    Send, {Shift}
    Sleep, 300

    ; 全选原来的文件名
    Send, ^a
    Sleep, 100

    ; 输入完整路径
    SendInput, %pdfFullPath%
    Sleep, 300

    ; Alt+S = 点击“保存(S)”
    Send, !s

    ; 10. 等刚才那个保存窗口真正关闭（只看这一个句柄）
    WinWaitClose, ahk_id %saveHwnd%,,20
    if ErrorLevel
    {
        MsgBox, 16, Error, Save dialog did not close for %ab1Name%
        return
    }


    ; 11. 给打印机一点时间写文件
    Sleep, 2000

    ; 12. 关闭 Chromas 窗口
    WinClose, %ab1Name%
    Sleep, 500
}

MsgBox, 64, Done, All ab1 files processed.
