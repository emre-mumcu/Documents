# Windows Power Configuration Settings

```
PS C:\> powercfg -h off
PS C:\> powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 10
PS C:\> powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 10
PS C:\> powercfg.exe /SETACTIVE SCHEME_CURRENT


powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -standby-timeout-ac 0
powercfg -change -standby-timeout-dc 0
```