:dude first go to:https://www.autohotkey.com/ 
:download and install 
:THEN OPEN NOTEPAD PASTE THE CODE, AND SAVE AS ALL FILES AND KEEP THIS AS THE NAME "alt-jk-scroll.ahk"
:THEN RUN THE SCRIPT 
: IF YOU WANT WANT IT TO REMAIN ALWAYS OPEN RUN AND ENTER "shell:startup" AND PASTE THAT AHK FILE IN THERE.

#Requires AutoHotkey v2.0
#UseHook true

; Global variables to track state
global scrollDir := ""
global startTime := 0

!j::startScroll("down")
!k::startScroll("up")

!j up::stopScroll("down")
!k up::stopScroll("up")

startScroll(dir) {
    global scrollDir, startTime
    if (scrollDir == dir) ; Prevent key repeat from restarting timer
        return
    
    scrollDir := dir
    startTime := A_TickCount
    SetTimer(doScroll, 70) ; Initial delay
    doScroll() ; Execute immediately
}

stopScroll(dir) {
    global scrollDir
    if (scrollDir == dir) {
        scrollDir := ""
        SetTimer(doScroll, 0) ; Turn off timer
    }
}

doScroll() {
    global scrollDir, startTime
    if (scrollDir == "")
        return

    elapsed := A_TickCount - startTime
    
    ; Logic for dynamic speed/delay
    speed := 1
    currentDelay := 70

    if (elapsed > 5000) {
        speed := 4      ; Rounded 3.75 to 4 (Wheel commands prefer integers)
        currentDelay := 28
    } else if (elapsed > 300) {
        speed := 3
        currentDelay := 35
    }

    ; Apply the scroll
    Send("{Wheel" (scrollDir = "down" ? "Down" : "Up") " " speed "}")
    
    ; Dynamically adjust timer frequency
    SetTimer(doScroll, currentDelay)
}
