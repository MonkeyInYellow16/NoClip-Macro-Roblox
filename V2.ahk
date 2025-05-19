#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Global variables for keys and running state
laughKey := ""
tiltKey := ""
flexWalkKey := ""
saluteKey := ""
running := false

; GUI Setup - wider, grid layout 2x2 for buttons and keybinds
Gui, Font, s10, Segoe UI

; Row 1, Column 1: Laugh (R6)
Gui, Add, Text, x20 y20 w190 Center, Laugh (R6) Keybind:
Gui, Add, Text, vLaughKeyText x20 y40 w190 Center, None
Gui, Add, Button, x20 y70 w190 h30 gAssignLaugh, Assign Laugh (R6)

; Row 1, Column 2: Tilt (R15)
Gui, Add, Text, x240 y20 w190 Center, Tilt (R15) Keybind:
Gui, Add, Text, vTiltKeyText x240 y40 w190 Center, None
Gui, Add, Button, x240 y70 w190 h30 gAssignTilt, Assign Tilt (R15)

; Row 2, Column 1: Flex Walk (R6)
Gui, Add, Text, x20 y120 w190 Center, Flex Walk (R6) Keybind:
Gui, Add, Text, vFlexWalkKeyText x20 y140 w190 Center, None
Gui, Add, Button, x20 y170 w190 h30 gAssignFlexWalk, Assign Flex Walk (R6)

; Row 2, Column 2: Salute (R15)
Gui, Add, Text, x240 y120 w190 Center, Salute (R15) Keybind:
Gui, Add, Text, vSaluteKeyText x240 y140 w190 Center, None
Gui, Add, Button, x240 y170 w190 h30 gAssignSalute, Assign Salute (R15)

; Start/Stop radio buttons centered below
Gui, Add, Radio, vStartButton x110 y220 w100 gStartScript, Start
Gui, Add, Radio, vStopButton x220 y220 w100 gStopScript, Stop

Gui, Show, w450 h270, Roblox Macro Control V2
return

; === Assign Hotkeys for each macro ===
AssignLaugh:
    InputBox, key, Assign Laugh (R6) Key, Press a key to assign for Laugh (R6):
    if ErrorLevel = 0
    {
        laughKey := key
        GuiControl,, LaughKeyText, %laughKey%
        if (running)
            Hotkey, %laughKey%, RunLaugh, On
        MsgBox, 64, Assigned, Laugh (R6) Key assigned to: %laughKey%
    }
return

AssignTilt:
    InputBox, key, Assign Tilt (R15) Key, Press a key to assign for Tilt (R15):
    if ErrorLevel = 0
    {
        tiltKey := key
        GuiControl,, TiltKeyText, %tiltKey%
        if (running)
            Hotkey, %tiltKey%, RunTilt, On
        MsgBox, 64, Assigned, Tilt (R15) Key assigned to: %tiltKey%
    }
return

AssignFlexWalk:
    InputBox, key, Assign Flex Walk (R6) Key, Press a key to assign for Flex Walk (R6):
    if ErrorLevel = 0
    {
        flexWalkKey := key
        GuiControl,, FlexWalkKeyText, %flexWalkKey%
        if (running)
            Hotkey, %flexWalkKey%, RunFlexWalk, On
        MsgBox, 64, Assigned, Flex Walk (R6) Key assigned to: %flexWalkKey%
    }
return

AssignSalute:
    InputBox, key, Assign Salute (R15) Key, Press a key to assign for Salute (R15):
    if ErrorLevel = 0
    {
        saluteKey := key
        GuiControl,, SaluteKeyText, %saluteKey%
        if (running)
            Hotkey, %saluteKey%, RunSalute, On
        MsgBox, 64, Assigned, Salute (R15) Key assigned to: %saluteKey%
    }
return

; === Start Script ===
StartScript:
if (!running)
{
    running := true
    GuiControl,, StartButton, 1
    GuiControl,, StopButton, 0

    if (laughKey != "")
        Hotkey, %laughKey%, RunLaugh, On
    if (tiltKey != "")
        Hotkey, %tiltKey%, RunTilt, On
    if (flexWalkKey != "")
        Hotkey, %flexWalkKey%, RunFlexWalk, On
    if (saluteKey != "")
        Hotkey, %saluteKey%, RunSalute, On
}
return

; === Stop Script ===
StopScript:
if (running)
{
    running := false
    GuiControl,, StartButton, 0
    GuiControl,, StopButton, 1

    if (laughKey != "")
        Hotkey, %laughKey%, Off
    if (tiltKey != "")
        Hotkey, %tiltKey%, Off
    if (flexWalkKey != "")
        Hotkey, %flexWalkKey%, Off
    if (saluteKey != "")
        Hotkey, %saluteKey%, Off
}
return

; === Laugh Macro Sequence (updated) ===
RunLaugh:
    ToolTip, Laugh Triggered!
    SetTimer, RemoveToolTip, -1000

    Send, /
    Sleep, 50
    Send, /e laugh
    Sleep, 50
    Send, {Enter}
    Sleep, 350
    Send, {Shift down}{s down}
    Sleep, 100
    Send, {Space}
    Sleep, 900  ; 100 + 900 = 1 second total holding S
    Send, {Shift up}{s up}
return

; === Tilt Macro Sequence (unchanged) ===
RunTilt:
    ToolTip, Tilt Triggered!
    SetTimer, RemoveToolTip, -1000

    SetTimer, TiltStep1, -310
return

TiltStep1:
    Send, .
    SetTimer, TiltStep2, -800
return

TiltStep2:
    Send, 2
    SetTimer, TiltStep3, -1300
return

TiltStep3:
    Send, {a down}{Shift down}
    SetTimer, TiltStep4, -1300
return

TiltStep4:
    Send, {a up}{Shift up}
return

; === Flex Walk Macro Sequence (fixed) ===
RunFlexWalk:
    ToolTip, Flex Walk Triggered!
    SetTimer, RemoveToolTip, -1000

    Send, /
    Sleep, 100
    Send, /e dance2
    Send, {Enter}
    Sleep, 780
    Send, {Shift down}
return

; === Salute Macro Sequence (unchanged) ===
RunSalute:
    ToolTip, Salute Triggered!
    SetTimer, RemoveToolTip, -1000

    Send, .
    SetTimer, SaluteStep2, -700
return

SaluteStep2:
    Send, 1
    SetTimer, SaluteStep3, -190
return

SaluteStep3:
    Send, {w down}{Shift down}
    SetTimer, SaluteStep4, -1000
return

SaluteStep4:
    Send, {w up}{Shift up}
return

RemoveToolTip:
    ToolTip
return

GuiClose:
ExitApp
