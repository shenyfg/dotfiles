EN_LAYOUT := 0x4090409
CN_LAYOUT := 0x8040804
cur_layout := EN_LAYOUT

CapsLock::
{
    Send("{Esc}")
    global cur_layout
    try {
        PostMessage(0x50, 0, EN_LAYOUT, , "A")
    }
    cur_layout := EN_LAYOUT
}

^Space:: 
{
    saved_clip := ClipboardAll ; save the clipboard
    global cur_layout
    if (cur_layout = EN_LAYOUT) {
        cur_layout := CN_LAYOUT
    } else {
        cur_layout := EN_LAYOUT
    }
    PostMessage(0x50, 0, cur_layout, , "A")
    Clipboard := saved_clip ; Restore the clipboard
    saved_clip := "" ; Release the tmpSaved data
}

!w::!F4
#t::Run("C:\Program Files\Alacritty\alacritty.exe")

; Windows
#j::#^Left
#k::#^Right

RCtrl & Up::Send("{Volume_Up}")
RCtrl & Down::Send("{Volume_Down}")

; #HotIf WinActive("ahk_class MultitaskingViewFrame") ; win10
#HotIf WinActive("ahk_class XamlExplorerHostIslandWindow") ; win11
h::left
j::down
k::up
l::right

; Wechat
#HotIf WinActive("ahk_exe WeChat.exe")
^j::down
^k::up

; Excel
#HotIf WinActive("ahk_exe excel.exe")
^h::left
^j::down
^k::up
^l::right

; Chrome
#HotIf WinActive("ahk_exe chrome.exe")
!1::^1
!2::^2
!3::^3
!4::^4
!5::^5
!6::^6
!7::^7
!8::^8
!9::^9

