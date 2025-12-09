#RequireAdmin
#Region ;**** 编译参数配置 ****
#AutoIt3Wrapper_Icon=WIN11深度修复工具.ico
#AutoIt3Wrapper_Res_Description=Win11 Repair Tool
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_ProductName=Win11 Repair Tool
#AutoIt3Wrapper_Res_ProductVersion=0.3
#AutoIt3Wrapper_Res_CompanyName=yjggfun.com
#AutoIt3Wrapper_Res_LegalCopyright=JayMortal
#AutoIt3Wrapper_Res_Language=2052
#EndRegion

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>

; =========================================================
;    全局配置区
; =========================================================
Global Const $APP_NAME = "Win11 Repair Tool"
Global Const $APP_VERSION = "v0.3"
Global Const $APP_AUTHOR = "JayMortal"
Global Const $APP_WEBSITE = "yjggfun.com"
Global Const $WIN_WIDTH = 920
Global Const $WIN_HEIGHT = 480

; 注册表路径常量
Global Const $REG_DWM = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm"
Global Const $REG_GFX = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
Global Const $REG_RIGHTMENU = "HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
Global Const $REG_STARTUP = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
Global Const $REG_QOS = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched"
Global Const $REG_UPDATE = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"

; 日志颜色
Global Const $LOG_COLOR_SUCCESS = 0x00FF00
Global Const $LOG_COLOR_WARNING = 0xFFFF00
Global Const $LOG_COLOR_ERROR   = 0xFF5555
Global Const $LOG_COLOR_INFO    = 0x00FFFF

; 全局控件变量
Global $hGUI, $idLog, $btnLangSwitch, $btnWebsite

; 当前语言
Global $g_sCurrentLang = ""

; 语言包
Global $g_Lang[100]

; =========================================================
;    语言系统初始化
; =========================================================
_InitLanguage()

Func _InitLanguage()
    Local $sOSLang = @OSLang
    If StringInStr($sOSLang, "0804") Or StringInStr($sOSLang, "0C04") Or StringInStr($sOSLang, "0404") Then
        $g_sCurrentLang = "zh-CN"
    Else
        $g_sCurrentLang = "en-US"
    EndIf
    _LoadLanguage($g_sCurrentLang)
EndFunc

Func _LoadLanguage($sLang)
    If $sLang = "zh-CN" Then
        ; === 中文语言包 ===
        $g_Lang[0] = "Win11 深度修复工具"
        $g_Lang[1] = "中/EN"
        $g_Lang[2] = "常用优化"
        $g_Lang[3] = "系统修复"
        $g_Lang[4] = "高级设置"
        $g_Lang[5] = "恢复经典右键菜单"
        $g_Lang[6] = "恢复Win11右键菜单"
        $g_Lang[7] = "修复应用商店"
        $g_Lang[8] = "清理临时文件"
        $g_Lang[9] = "清理更新缓存"
        $g_Lang[10] = "完全禁用 MPO"
        $g_Lang[11] = "恢复启用 MPO"
        $g_Lang[12] = "重建图标缓存"
        $g_Lang[13] = "重置网络设置"
        $g_Lang[14] = "禁用网络限流"
        $g_Lang[15] = "禁用开机启动延迟"
        $g_Lang[16] = "一键系统修复 ⚡"
        $g_Lang[17] = "禁用自动更新"
        $g_Lang[18] = "恢复自动更新"
        $g_Lang[19] = "实时操作日志:"
        $g_Lang[20] = "工具已就绪 (管理员模式: 是)"
        $g_Lang[21] = "当前版本:"
        $g_Lang[22] = "[▶ 开始]"
        $g_Lang[23] = "[■ 结束]"
        $g_Lang[24] = "提示"
        $g_Lang[25] = "警告"
        $g_Lang[26] = "完成"
        $g_Lang[27] = "错误"
        $g_Lang[28] = "请重启资源管理器或重启电脑生效。"
        $g_Lang[29] = "请重启电脑。"
        $g_Lang[30] = "请立即重启电脑！"
        $g_Lang[31] = "桌面将短暂消失，是否继续？"
        $g_Lang[32] = "完成后需重启电脑，是否继续？"
        $g_Lang[33] = "此操作需要 10-30 分钟，期间请勿关闭程序。" & @CRLF & "是否继续？"
        $g_Lang[34] = "经典右键菜单已启用。"
        $g_Lang[35] = "Win11右键菜单已恢复。"
        $g_Lang[36] = "MPO 已禁用，请重启电脑。"
        $g_Lang[37] = "MPO 已恢复，请重启电脑。"
        $g_Lang[38] = "开机启动延迟已禁用，下次开机生效。"
        $g_Lang[39] = "系统修复已完成！"
        $g_Lang[40] = "自动更新已禁用。"
        $g_Lang[41] = "自动更新已恢复。"
        $g_Lang[42] = "网络限流已禁用。"
        $g_Lang[43] = "访问网站"  ; 新增
    Else
        ; === 英文语言包 ===
        $g_Lang[0] = "Win11 Repair Tool"
        $g_Lang[1] = "EN/中"
        $g_Lang[2] = "Common Tweaks"
        $g_Lang[3] = "System Repair"
        $g_Lang[4] = "Advanced"
        $g_Lang[5] = "Classic Right Menu"
        $g_Lang[6] = "Win11 Right Menu"
        $g_Lang[7] = "Fix Store"
        $g_Lang[8] = "Clean Temp Files"
        $g_Lang[9] = "Clean Update Cache"
        $g_Lang[10] = "Disable MPO"
        $g_Lang[11] = "Enable MPO"
        $g_Lang[12] = "Rebuild Icon Cache"
        $g_Lang[13] = "Reset Network"
        $g_Lang[14] = "Disable QoS Limit"
        $g_Lang[15] = "Disable Startup Delay"
        $g_Lang[16] = "System Fix All ⚡"
        $g_Lang[17] = "Disable Auto Update"
        $g_Lang[18] = "Enable Auto Update"
        $g_Lang[19] = "Operation Log:"
        $g_Lang[20] = "Ready (Admin Mode: Yes)"
        $g_Lang[21] = "Version:"
        $g_Lang[22] = "[▶ Start]"
        $g_Lang[23] = "[■ End]"
        $g_Lang[24] = "Info"
        $g_Lang[25] = "Warning"
        $g_Lang[26] = "Done"
        $g_Lang[27] = "Error"
        $g_Lang[28] = "Restart Explorer or reboot to take effect."
        $g_Lang[29] = "Please reboot your PC."
        $g_Lang[30] = "Please reboot now!"
        $g_Lang[31] = "Desktop will disappear briefly. Continue?"
        $g_Lang[32] = "Reboot required after operation. Continue?"
        $g_Lang[33] = "This may take 10-30 minutes." & @CRLF & "Do not close the program. Continue?"
        $g_Lang[34] = "Classic right-click menu enabled."
        $g_Lang[35] = "Win11 right-click menu restored."
        $g_Lang[36] = "MPO disabled. Please reboot."
        $g_Lang[37] = "MPO enabled. Please reboot."
        $g_Lang[38] = "Startup delay disabled (next boot)."
        $g_Lang[39] = "System repair completed!"
        $g_Lang[40] = "Auto update disabled."
        $g_Lang[41] = "Auto update enabled."
        $g_Lang[42] = "Network QoS limit disabled."
        $g_Lang[43] = "Visit Website"  ; 新增
    EndIf
EndFunc

Func _SwitchLanguage()
    If $g_sCurrentLang = "zh-CN" Then
        $g_sCurrentLang = "en-US"
    Else
        $g_sCurrentLang = "zh-CN"
    EndIf
    _LoadLanguage($g_sCurrentLang)
    GUIDelete($hGUI)
    _CreateGUI()
EndFunc

; =========================================================
;    启动检查
; =========================================================
If Not IsAdmin() Then
    ShellExecute(@ScriptFullPath, "", "", "runas")
    Exit
EndIf

; =========================================================
;    GUI 界面构建
; =========================================================
_CreateGUI()

Func _CreateGUI()
    $hGUI = GUICreate($g_Lang[0] & " " & $APP_VERSION, $WIN_WIDTH, $WIN_HEIGHT)

    ; 【新增】右上角按钮组："访问网站" + "中/EN"
    $btnWebsite = GUICtrlCreateButton($g_Lang[43], $WIN_WIDTH - 175, 5, 85, 25)
    $btnLangSwitch = GUICtrlCreateButton($g_Lang[1], $WIN_WIDTH - 80, 5, 60, 25)

    Local $iColWidth = 280
    Local $iColMargin = 20
    Local $iBtnHeight = 30
    Local $iBtnGap = 10
    Local $iStartY = 35

    ; === 左列 ===
    Local $iCol1X = $iColMargin
    GUICtrlCreateGroup(" " & $g_Lang[2] & " ", $iCol1X, $iStartY, $iColWidth, 210)
    Global $btnOldMenu = GUICtrlCreateButton($g_Lang[5], $iCol1X + 15, $iStartY + 25, $iColWidth - 30, $iBtnHeight)
    Global $btnNewMenu = GUICtrlCreateButton($g_Lang[6], $iCol1X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 1, $iColWidth - 30, $iBtnHeight)
    Global $btnFixStore = GUICtrlCreateButton($g_Lang[7], $iCol1X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 2, $iColWidth - 30, $iBtnHeight)
    Global $btnCleanTemp = GUICtrlCreateButton($g_Lang[8], $iCol1X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 3, $iColWidth - 30, $iBtnHeight)
    Global $btnCleanWU = GUICtrlCreateButton($g_Lang[9], $iCol1X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 4, $iColWidth - 30, $iBtnHeight)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

    ; === 中列 ===
    Local $iCol2X = $iCol1X + $iColWidth + $iColMargin
    GUICtrlCreateGroup(" " & $g_Lang[3] & " ", $iCol2X, $iStartY, $iColWidth, 210)
    Global $btnMPO_Disable = GUICtrlCreateButton($g_Lang[10], $iCol2X + 15, $iStartY + 25, $iColWidth - 30, $iBtnHeight)
    Global $btnMPO_Enable = GUICtrlCreateButton($g_Lang[11], $iCol2X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 1, $iColWidth - 30, $iBtnHeight)
    Global $btnIconCache = GUICtrlCreateButton($g_Lang[12], $iCol2X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 2, $iColWidth - 30, $iBtnHeight)
    Global $btnNetReset = GUICtrlCreateButton($g_Lang[13], $iCol2X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 3, $iColWidth - 30, $iBtnHeight)
    Global $btnDisableQoS = GUICtrlCreateButton($g_Lang[14], $iCol2X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 4, $iColWidth - 30, $iBtnHeight)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

    ; === 右列 ===
    Local $iCol3X = $iCol2X + $iColWidth + $iColMargin
    GUICtrlCreateGroup(" " & $g_Lang[4] & " ", $iCol3X, $iStartY, $iColWidth, 170)
    Global $btnNoDelay = GUICtrlCreateButton($g_Lang[15], $iCol3X + 15, $iStartY + 25, $iColWidth - 30, $iBtnHeight)
    Global $btnSystemFix = GUICtrlCreateButton($g_Lang[16], $iCol3X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 1, $iColWidth - 30, $iBtnHeight)
    Global $btnDisableUpdate = GUICtrlCreateButton($g_Lang[17], $iCol3X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 2, $iColWidth - 30, $iBtnHeight)
    Global $btnEnableUpdate = GUICtrlCreateButton($g_Lang[18], $iCol3X + 15, $iStartY + 25 + ($iBtnHeight + $iBtnGap) * 3, $iColWidth - 30, $iBtnHeight)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

    ; === 日志栏 ===
    Local $iLogY = $iStartY + 230
    GUICtrlCreateLabel($g_Lang[19], $iColMargin, $iLogY, 200, 15)
    $idLog = GUICtrlCreateEdit("", $iColMargin, $iLogY + 20, $WIN_WIDTH - 2 * $iColMargin, 150, _
             BitOR($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_READONLY, $ES_MULTILINE))
    GUICtrlSetBkColor($idLog, 0x000000)
    GUICtrlSetColor($idLog, $LOG_COLOR_INFO)
    GUICtrlSetFont($idLog, 9, 400, 0, "Consolas")

    ; === 【优化】底部版权信息（仅保留作者+版本，右对齐）===
    Local $iFooterY = $iLogY + 175
    Local $sFooterText = "Dev: " & $APP_AUTHOR & "  |  " & $APP_VERSION

    ; 0x2 = $SS_RIGHT 右对齐
    Local $lblFooter = GUICtrlCreateLabel($sFooterText, $iColMargin, $iFooterY, $WIN_WIDTH - 2 * $iColMargin, 15, 0x2)
    GUICtrlSetColor($lblFooter, 0x808080)

    GUISetState(@SW_SHOW)

    _LogInfo($g_Lang[20])
    _LogInfo($g_Lang[21] & " " & $APP_VERSION & " by " & $APP_AUTHOR)
EndFunc

; =========================================================
;    主消息循环
; =========================================================
While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $btnLangSwitch
            _SwitchLanguage()
        Case $btnWebsite
            ShellExecute("https://" & $APP_WEBSITE)
        Case $btnOldMenu
            _RestoreOldRightMenu()
        Case $btnNewMenu
            _RestoreNewRightMenu()
        Case $btnFixStore
            _FixWindowsStore()
        Case $btnCleanTemp
            _CleanTempFiles()
        Case $btnCleanWU
            _CleanWindowsUpdate()
        Case $btnMPO_Disable
            _DisableMPO_Dual()
        Case $btnMPO_Enable
            _EnableMPO_Dual()
        Case $btnIconCache
            _FixIconCache()
        Case $btnNetReset
            _ResetNetwork()
        Case $btnDisableQoS
            _DisableQoS()
        Case $btnNoDelay
            _DisableStartupDelay()
        Case $btnSystemFix
            _SystemFixAll()
        Case $btnDisableUpdate
            _DisableWindowsUpdate()
        Case $btnEnableUpdate
            _EnableWindowsUpdate()
    EndSwitch
WEnd

; =========================================================
;    日志函数
; =========================================================
Func _Log($sMsg, $iColor = $LOG_COLOR_INFO)
    Local $sTime = @HOUR & ":" & @MIN & ":" & @SEC
    GUICtrlSetColor($idLog, $iColor)
    GUICtrlSetData($idLog, "[" & $sTime & "] " & $sMsg & @CRLF, 1)
    GUICtrlSetColor($idLog, $LOG_COLOR_INFO)
EndFunc

Func _LogInfo($sMsg)
    _Log($sMsg, $LOG_COLOR_INFO)
EndFunc

Func _LogSuccess($sMsg)
    _Log($sMsg, $LOG_COLOR_SUCCESS)
EndFunc

Func _LogWarning($sMsg)
    _Log($sMsg, $LOG_COLOR_WARNING)
EndFunc

Func _LogError($sMsg)
    _Log($sMsg, $LOG_COLOR_ERROR)
EndFunc

Func _LogStart($sFunc)
    _LogInfo($g_Lang[22] & " " & $sFunc)
EndFunc

Func _LogStep($sStep)
    _LogInfo("  ├─ " & $sStep)
EndFunc

Func _LogEnd($sFunc)
    _LogInfo($g_Lang[23] & " " & $sFunc)
EndFunc

; =========================================================
;    通用工具函数
; =========================================================
Func _RegWriteSafe($sKeyPath, $sValueName, $sType, $vData, $sDesc = "")
    Local $iResult = RegWrite($sKeyPath, $sValueName, $sType, $vData)
    If $iResult = 1 Then
        _LogSuccess("  └─ [✓] " & $sDesc)
        Return True
    Else
        _LogError("  └─ [✗] " & $sDesc)
        Return False
    EndIf
EndFunc

Func _RegDeleteSafe($sKeyPath, $sValueName, $sDesc = "")
    Local $iResult = RegDelete($sKeyPath, $sValueName)
    If $iResult = 1 Then
        _LogSuccess("  └─ [✓] " & $sDesc)
        Return True
    Else
        _LogWarning("  └─ [!] " & $sDesc)
        Return False
    EndIf
EndFunc

Func _RunCmdSmart($sCmd, $sDesc)
    _LogStep($sDesc)
    Local $iExitCode = RunWait(@ComSpec & " /c " & $sCmd, "", @SW_HIDE)
    If $iExitCode = 0 Then
        _LogSuccess("  └─ [✓] " & $sDesc)
        Return True
    Else
        _LogWarning("  └─ [!] " & $sDesc & " (Exit:" & $iExitCode & ")")
        Return False
    EndIf
EndFunc

; =========================================================
;    业务逻辑函数
; =========================================================
Func _RestoreOldRightMenu()
    _LogStart($g_Lang[5])
    _RegWriteSafe($REG_RIGHTMENU, "", "REG_SZ", "", $g_Lang[5])
    _LogEnd($g_Lang[5])
    MsgBox(64, $g_Lang[24], $g_Lang[34] & @CRLF & $g_Lang[28])
EndFunc

Func _RestoreNewRightMenu()
    _LogStart($g_Lang[6])
    _RegDeleteSafe($REG_RIGHTMENU, "", $g_Lang[6])
    _LogEnd($g_Lang[6])
    MsgBox(64, $g_Lang[24], $g_Lang[35] & @CRLF & $g_Lang[28])
EndFunc

Func _FixWindowsStore()
    _LogStart($g_Lang[7])
    _LogStep("wsreset.exe")
    RunWait("wsreset.exe", "", @SW_HIDE)
    _LogSuccess("  └─ [✓] " & $g_Lang[7])
    _LogEnd($g_Lang[7])
EndFunc

Func _CleanTempFiles()
    _LogStart($g_Lang[8])
    _RunCmdSmart('del /f /s /q "%temp%\*"', "User Temp")
    _RunCmdSmart('del /f /s /q "C:\Windows\Temp\*"', "System Temp")
    _LogEnd($g_Lang[8])
EndFunc

Func _CleanWindowsUpdate()
    _LogStart($g_Lang[9])
    _RunCmdSmart("net stop wuauserv", "Stop WU Service")
    _RunCmdSmart('rd /s /q "C:\Windows\SoftwareDistribution"', "Clean Cache")
    _RunCmdSmart("net start wuauserv", "Start WU Service")
    _LogEnd($g_Lang[9])
EndFunc

Func _DisableMPO_Dual()
    _LogStart($g_Lang[10])
    _RegWriteSafe($REG_DWM, "OverlayTestMode", "REG_DWORD", 5, "DWM")
    _RegWriteSafe($REG_GFX, "DisableMPO", "REG_DWORD", 1, "Driver")
    _LogEnd($g_Lang[10])
    MsgBox(64, $g_Lang[26], $g_Lang[36])
EndFunc

Func _EnableMPO_Dual()
    _LogStart($g_Lang[11])
    _RegDeleteSafe($REG_DWM, "OverlayTestMode", "DWM")
    _RegDeleteSafe($REG_GFX, "DisableMPO", "Driver")
    _LogEnd($g_Lang[11])
    MsgBox(64, $g_Lang[26], $g_Lang[37])
EndFunc

Func _FixIconCache()
    If MsgBox(49, $g_Lang[25], $g_Lang[31]) = 2 Then Return
    _LogStart($g_Lang[12])
    _RunCmdSmart("taskkill /f /im explorer.exe", "Kill Explorer")
    _RunCmdSmart('del /a /f /q "%localappdata%\IconCache.db"', "IconCache.db")
    _RunCmdSmart('del /a /f /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*"', "Icon Files")
    _LogStep("Restart Explorer")
    Run("explorer.exe")
    _LogSuccess("  └─ [✓] Desktop")
    _LogEnd($g_Lang[12])
EndFunc

Func _ResetNetwork()
    If MsgBox(49, $g_Lang[25], $g_Lang[32]) = 2 Then Return
    GUICtrlSetState($btnNetReset, $GUI_DISABLE)
    _LogStart($g_Lang[13])
    _RunCmdSmart("netsh winsock reset", "Winsock")
    _RunCmdSmart("netsh int ip reset", "TCP/IP")
    _RunCmdSmart("ipconfig /release", "Release IP")
    _RunCmdSmart("ipconfig /flushdns", "Flush DNS")
    _LogStep("Renew IP")
    RunWait(@ComSpec & " /c ipconfig /renew", "", @SW_HIDE)
    _LogSuccess("  └─ [✓] IP Renewed")
    GUICtrlSetState($btnNetReset, $GUI_ENABLE)
    _LogEnd($g_Lang[13])
    MsgBox(64, $g_Lang[24], $g_Lang[30])
EndFunc

Func _DisableQoS()
    _LogStart($g_Lang[14])
    _RegWriteSafe($REG_QOS, "NonBestEffortLimit", "REG_DWORD", 0, "QoS")
    _LogEnd($g_Lang[14])
    MsgBox(64, $g_Lang[26], $g_Lang[42])
EndFunc

Func _DisableStartupDelay()
    _LogStart($g_Lang[15])
    _RegWriteSafe($REG_STARTUP, "StartupDelayInMSec", "REG_DWORD", 0, "Startup Delay")
    _LogEnd($g_Lang[15])
    MsgBox(64, $g_Lang[26], $g_Lang[38])
EndFunc

Func _SystemFixAll()
    If MsgBox(49, $g_Lang[25], $g_Lang[33]) = 2 Then Return
    GUICtrlSetState($btnSystemFix, $GUI_DISABLE)
    _LogStart($g_Lang[16])
    _LogStep("DISM (5-10 min)")
    RunWait(@ComSpec & " /c DISM /Online /Cleanup-Image /RestoreHealth", "", @SW_HIDE)
    _LogSuccess("  └─ [✓] DISM")
    _LogStep("SFC (10-15 min)")
    RunWait(@ComSpec & " /c sfc /scannow", "", @SW_HIDE)
    _LogSuccess("  └─ [✓] SFC")
    GUICtrlSetState($btnSystemFix, $GUI_ENABLE)
    _LogEnd($g_Lang[16])
    MsgBox(64, $g_Lang[26], $g_Lang[39])
EndFunc

Func _DisableWindowsUpdate()
    _LogStart($g_Lang[17])
    _RegWriteSafe($REG_UPDATE, "NoAutoUpdate", "REG_DWORD", 1, "Update Policy")
    _RunCmdSmart("net stop wuauserv", "Stop Service")
    _LogEnd($g_Lang[17])
    MsgBox(64, $g_Lang[26], $g_Lang[40])
EndFunc

Func _EnableWindowsUpdate()
    _LogStart($g_Lang[18])
    _RegDeleteSafe($REG_UPDATE, "NoAutoUpdate", "Update Policy")
    _RunCmdSmart("net start wuauserv", "Start Service")
    _LogEnd($g_Lang[18])
    MsgBox(64, $g_Lang[26], $g_Lang[41])
EndFunc
