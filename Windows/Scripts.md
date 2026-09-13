C:\Scripts\FileHash.ps1

```
param([string]$FilePath)

$hash = (Get-FileHash -Path $FilePath -Algorithm SHA256).Hash

Set-Clipboard $hash

Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show(
    "SHA256 hash panoya kopyalandı.`n`n$hash",
    "Dosya Hash"
)
```


Oluşturmak İçin

```

# Menü öğesi oluştur
New-Item -Path "HKCU:\Software\Classes\*\shell\ShowSHA256" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Classes\*\shell\ShowSHA256" -Name "(Default)" -Value "SHA256 Hash Hesapla"

# İsteğe bağlı ikon
Set-ItemProperty -Path "HKCU:\Software\Classes\*\shell\ShowSHA256" -Name "Icon" -Value "powershell.exe"

# Komut
New-Item -Path "HKCU:\Software\Classes\*\shell\ShowSHA256\command" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Classes\*\shell\ShowSHA256\command" -Name "(Default)" -Value 'powershell.exe -ExecutionPolicy Bypass -File "C:\Scripts\FileHash.ps1" "%1"'

```


Kaldırmak için:

```
Remove-Item "HKCU:\Software\Classes\*\shell\ShowSHA256" -Recurse -Force

```


sha256_context_menu.reg

```
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\*\shell\ShowSHA256]
@="SHA256 Hash Hesapla"
"Icon"="powershell.exe"

[HKEY_CURRENT_USER\Software\Classes\*\shell\ShowSHA256\command]
@="powershell.exe -ExecutionPolicy Bypass -File \"C:\\Scripts\\FileHash.ps1\" \"%1\""
```

Kaldırmak için .reg dosyası:

```
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\Software\Classes\*\shell\ShowSHA256]

```
