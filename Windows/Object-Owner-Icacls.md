
takeown /f E:\.Trash-1000 /r /d y
icacls E:\.Trash-1000 /grant %username%:F /t

rd /s /q E:\.Trash-1000

