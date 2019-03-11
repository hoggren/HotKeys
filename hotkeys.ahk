;#Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; KeyHistory  ; Shows key history and other nice things
#SingleInstance, force


;;;;; TEST CODE START ;;;;;
; Create quick menu
; Menu, QuickMenu, Add, PowerShell, PS
; Menu, QuickMenu, Icon, A_AhkPath
; Menu, QuickMenu, Add, Sublime Text, Subl

; ; Menu, QuickMenu, Add ; separator

; PS:
; MsgBox You pressed PS
; return

; Subl:
; MsgBox hello sir
; return
; AppsKey::
; {
; 	Menu, QuickMenu, Show
; 	Return
; }
;;;;; TEST CODE END ;;;;;

;; Generic shortcuts
	; Snipping tool (as MacOS) (ctrl+shift+4)
	^+4::
	{
		Run, C:\Windows\system32\SnippingTool.exe
		Return
	}

	; Print a UUID (WIN+u)
	#u::
	{
		Send % CreateUUID()
		Return
	}

	; Stack overflow searches your highlighted text (WIN+S)
	#s::
	{
		oldClipboard = %clipboard%
		Send, ^c
		Sleep 50
		Run, https://stackoverflow.com/search?q=%clipboard%
		sleep 50
		clipboard = oldClipboard
		Return
	}

	; Google searches your highlighted text (WIN+G)
	#g::
	{
		oldClipboard = %clipboard%
		Send, ^c
		Sleep 50
		Run, https://www.google.se/search?q=%clipboard%
		sleep 50
		clipboard = oldClipboard
		Return
	}

	; Print a datetime stamp (WIN+0)
	#0::
	{
		FormatTime, time, A_now, yyyyMMdd-HHmm
		send %time%
		return
	}
;; Generic shortcuts

;; CosmosDb macros
	; Prints " WHERE c.id = '' and focuses inside" (WIN+1)
	#1::
	{
		SendInput, WHERE c{.}id = ''
		Send, {Left}
		Return
	}
	; Prints " WHERE c.DocumentType = '' and focuses inside" (WIN+2)
	#2::
	{
		SendInput, WHERE c{.}DocumentType = "CosmosEntity"
		Loop, 13
			Send, {Left}
		Return
	}
;; CosmosDb macros

;; Fixes
	; disable right WIN
	RWin::
	{
		Return
	}
	; Disables the exit button in window bar for active window (WIN+esc)
	#Esc::
	{
		DisableCloseButton(WinExist("A"))
		
		return
	}
;; Fixes

;; Special cases
	;;; Launch sublime text (for work PC / Microsoft 900 keyboard)
	if (A_ComputerName = "XDEADBEEF")
	{
		; launch Sublime Text (calc)
		Launch_App2::
		Run, C:\Program Files\Sublime Text 3\sublime_text.exe
		Return
	}

	;;; For Lenovo home laptop
	if (A_ComputerName = "LENOVO-510S13IK")
	{
		; Map printscreen to Insert
		; Internal keyboard
		PrintScreen::Ins
	}

	;;; For home PC (SVIVE TRITON MECH KEYBOARD)
	if (A_ComputerName = "DESKTOP-W10")
	{
		#F1:: Run, C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -noexit -command "cd $HOME\dev"
		#F2:: RunOrActivate("C:\Program Files\Sublime Text 3\sublime_text.exe", "Sublime Text")

		#F11:: Run, "C:\Program Files (x86)\Telldus\Scheduler\DeviceSchedulerAgent.exe" 8
		#F12:: Run, "C:\Program Files (x86)\Telldus\Scheduler\DeviceSchedulerAgent.exe" 9
	}
;; Special cases

;; Functions
	DisableCloseButton(hWnd) {
		hSysMenu:=DllCall("GetSystemMenu","Int",hWnd,"Int",FALSE)
		nCnt:=DllCall("GetMenuItemCount","Int",hSysMenu)
		DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-1,"Uint","0x400")
		DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-2,"Uint","0x400")
		DllCall("DrawMenuBar","Int",hWnd)
		Return ""
	}

	CreateUUID()
	{
		VarSetCapacity(puuid, 16, 0)
		if !(DllCall("rpcrt4.dll\UuidCreate", "ptr", &puuid))
			if !(DllCall("rpcrt4.dll\UuidToString", "ptr", &puuid, "uint*", suuid))
				return StrGet(suuid), DllCall("rpcrt4.dll\RpcStringFree", "uint*", suuid)
		return ""
	}

	RunOrActivate(Target, WinTitle = "")
	{
		; Get the filename without a path
		SplitPath, Target, TargetNameOnly

		Process, Exist, %TargetNameOnly%
		If ErrorLevel > 0
			PID = %ErrorLevel%
		Else
			Run, %Target%, , , PID

		; At least one app (Seapine TestTrack wouldn't always become the active
		; window after using Run), so we always force a window activate.
		; Activate by title if given, otherwise use PID.
		If WinTitle <> 
		{
			SetTitleMatchMode, 2
			WinWait, %WinTitle%, , 3
			;TrayTip, , Activating Window Title "%WinTitle%" (%TargetNameOnly%)
			WinActivate, %WinTitle%
		}
		Else
		{
			WinWait, ahk_pid %PID%, , 3
			;TrayTip, , Activating PID %PID% (%TargetNameOnly%)
			WinActivate, ahk_pid %PID%
		}
	}
;; Functions
