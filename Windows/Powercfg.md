# Windows Power Configuration Settings

You need to run these commands on an elevated terminal.

```powershell
Start-Process powershell -Verb runAs
```

Disable hibernation completely: 
	* Turn off the hibernation feature
	* Delete the hiberfil.sys file (often several GB in size)
	* Remove:
		- Hibernate option in Start menu
		- Fast Startup (because it depends on hibernation)

```powershell
powercfg -h off
```

The following commands sets the PC to automatically turn off 10 seconds after the display is locked (on both battery and power), and applies the current power plan.

```powershell
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 10;
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 10;
powercfg.exe /SETACTIVE SCHEME_CURRENT;
```

These settings below will prevent screen, never turn off automatically; when plugged into power (AC) or on battery (DC).

```powershell
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
```

These settings below will prevent PC, never go to sleep automatically; when plugged into power (AC) or on battery (DC).

```powershell
powercfg -change -standby-timeout-ac 0
powercfg -change -standby-timeout-dc 0
```