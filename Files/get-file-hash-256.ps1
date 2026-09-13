param([string]$FilePath)

$hash = (Get-FileHash -Path $FilePath -Algorithm SHA256).Hash

Set-Clipboard $hash

Add-Type -AssemblyName PresentationFramework

[System.Windows.MessageBox]::Show(
    "SHA256 hash panoya kopyalandı.`n`n$hash",
    "Dosya Hash"
)