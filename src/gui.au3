#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=jaz.ico
#AutoIt3Wrapper_Outfile=Buchstabiene_v1.1.exe
#AutoIt3Wrapper_Outfile_x64=Buchstabiene_v1.1(x64).exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Keyboard Text Emulator
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=(c) Jannus - 2022
#AutoIt3Wrapper_Res_Language=1031
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****


;#AutoIt3Wrapper_Res_File_Add=C:\Users\Jannus\Desktop\typer\jaz.jpg
;#AutoIt3Wrapper_Res_Icon_Add=C:\Users\Jannus\Desktop\typer\jaz.jpg


#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <Misc.au3>

FileInstall("jaz2.jpg",@TempDir & "\jazz.jpg")

#Region ### START Koda GUI section ### Form=

	$Form = GUICreate("Buchstabiene v1.1", 601, 401, 192, 124)
	$Text = GUICtrlCreateEdit("", 8, 8, 585, 273)

	GUICtrlSetData(-1, StringFormat("According to all known laws\r\nof aviation,\r\n\r\n  \r\nthere is no way a bee\r\nshould be able to fly.\r\n\r\n  \r\nIts wings are too small to get\r\nits fat little body off the ground.\r\n\r\n  \r\nThe bee, of course, flies anyway\r\n\r\n  \r\nbecause bees don"&Chr(39)&"t care\r\nwhat humans think is impossible.\r\n\r\n  \r\nYellow, black. Yellow, black.\r\nYellow, black. Yellow, black.\r\n\r\n  \r\nOoh, black and yellow!\r\nLet"&Chr(39)&"s shake it up a little."))

	$Speed = GUICtrlCreateGroup("Geschwindigkeit", 8, 288, 105, 105)
		$Radio_SP0 = GUICtrlCreateRadio("Langsam", 16, 312, 65, 17)
		$Radio_SP1 = GUICtrlCreateRadio("Normal", 16, 336, 65, 17)
		GUICtrlSetState(-1, $GUI_CHECKED)
		$Radio_SP2 = GUICtrlCreateRadio("Schnell", 16, 360, 73, 17)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$Mode = GUICtrlCreateGroup("Modus", 128, 288, 105, 106)
		$Radio_MT = GUICtrlCreateRadio("Text Modus", 136, 312, 81, 17)
		GUICtrlSetState(-1, $GUI_CHECKED)
		$Radio_MH = GUICtrlCreateRadio("Hotkey Modus", 136, 336, 89, 17)
		GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlSetTip(-1, "WIP")

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$ButtonGO = GUICtrlCreateButton("LOS", 480, 296, 108, 97)

	GUICtrlSetCursor (-1, 0)

	$Delay = GUICtrlCreateGroup("Verzögerung", 248, 289, 105, 105)
		$D_1 = GUICtrlCreateRadio("1 sek", 256, 312, 65, 17)
		$D_2 = GUICtrlCreateRadio("3 sek", 256, 336, 65, 17)
		$D_5 = GUICtrlCreateRadio("5 sek", 256, 360, 81, 17)

	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$Pic1 = GUICtrlCreatePic(@TempDir & "\jazz.jpg", 368, 296, 100, 100)

	$Checkbox1 = GUICtrlCreateCheckbox("JAZZ", 136, 360, 57, 17)
		GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetState(-1, $GUI_DISABLE)

	GUISetState(@SW_SHOW)

#EndRegion ### END Koda GUI section ###

Func Type()

	If		GUICtrlRead($D_1) = 1 Then
		Sleep(1000)
	ElseIf 	GUICtrlRead($D_2) = 1 Then
		Sleep(3000)
	ElseIf	GUICtrlRead($D_5) = 1 Then
		Sleep(5000)
	EndIf

	$txtf = GUICtrlRead($Text)
	$txt  = StringSplit($txtf, "")

	$f = 0

	For $c = 1 To $txt[0]

		If _IsPressed("1B") Then
			$f = 1
			ExitLoop ; ESC Key
		EndIf

		If		GUICtrlRead($Radio_MT) = 1 Then

			Switch $txt[$c]
				Case "\r"
					Send("")
				Case "\n"
					Send("{ENTER}{SPACE}")
				Case "\t"
					Send("{TAB}")
				Case " "
					Send("{SPACE}")

				Case "!"
					Send("{!}")
				Case "#"
					Send("{#}")
				Case "^"
					Send("{^}")
				Case "+"
					Send("{+}")
				Case "{"
					Send("{{}")
				Case "}"
					Send("{}}")

				Case Else
					Send($txt[$c])
			EndSwitch

		Else

			Switch $txt[$c]
				Case "\r"
					Send("")
				Case "\n"
					Send("")
				Case Else
					Send($txt[$c])
			EndSwitch

		EndIf

		If		GUICtrlRead($Radio_SP0) = 1 Then
			Sleep(Random(0,500))
		ElseIf	GUICtrlRead($Radio_SP1) = 1 Then
			Sleep(Random(0,250))
		ElseIf  GUICtrlRead($Radio_SP2) = 1 Then
			Sleep(Random(0,100))
		EndIf

	Next

	If $f = 1 Then
		MsgBox(0x30,"Vorgang abgebrochen","Vorgang abgebrochen")
	Else
		MsgBox(0x40,"Vorgang abgeschlossen","Vorgang abgeschlossen")
	EndIf

EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $ButtonGO
			Type()
	EndSwitch
WEnd
