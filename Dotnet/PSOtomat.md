PowerShell'de de bir klasörün gerçekten .NET projesi olup olmadığını (*.csproj içerip içermediğini) kontrol ederek sadece o projelerin bin ve obj klasörlerini silmek:

Get-ChildItem -Path "D:\Projeler" -Filter *.csproj -Recurse |
ForEach-Object {
    $projectDir = $_.Directory.FullName

    Remove-Item "$projectDir\bin" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$projectDir\obj" -Recurse -Force -ErrorAction SilentlyContinue
}

Önce silmeden hangi klasörlerin etkileneceğini görmek istersen:

Get-ChildItem -Path "D:\Projeler" -Filter *.csproj -Recurse |
ForEach-Object {
    $projectDir = $_.Directory.FullName

    if (Test-Path "$projectDir\bin") {
        Write-Host "BIN: $projectDir\bin"
    }

    if (Test-Path "$projectDir\obj") {
        Write-Host "OBJ: $projectDir\obj"
    }
}

Get-ChildItem -Path "A:\AppStore" -Filter *.csproj -Recurse | ForEach-Object { $projectDir = $_.Directory.FullName; if (Test-Path "$projectDir\bin") { Write-Host "BIN: $projectDir\bin" }; if (Test-Path "$projectDir\obj") { Write-Host "OBJ: $projectDir\obj" } }

Tek satır halinde:

Get-ChildItem "D:\Projeler" -Filter *.csproj -Recurse | % { Remove-Item "$($_.Directory.FullName)\bin","$($_.Directory.FullName)\obj" -Recurse -Force -ErrorAction SilentlyContinue }


!!!!!

Get-ChildItem "A:\AppStore" -Filter *.csproj -Recurse | % { "$($_.Directory.FullName)\bin","$($_.Directory.FullName)\obj" | ? { Test-Path $_ } | % { "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $_" | Add-Content "A:\silinen-bin-obj.log"; Remove-Item $_ -Recurse -Force -ErrorAction SilentlyContinue } }

!!!!!


Get-ChildItem "A:\AppStore" -Filter *.csproj -Recurse | % { "$($_.Directory.FullName)\bin","$($_.Directory.FullName)\obj" | ? { Test-Path $_ } | Tee-Object -FilePath "D:\silinen-bin-obj.log" -Append | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue }


*.csproj kontrolü olmadan
-------------------------

Önce hangi klasörlerin silineceğini görmek için:


Get-ChildItem -Path "D:\Projeler" -Directory -Recurse |
Where-Object { $_.Name -in @("bin", "obj") } |
Select-Object FullName

Liste doğru görünüyorsa silmek için:

Get-ChildItem -Path "D:\Projeler" -Directory -Recurse |
Where-Object { $_.Name -in @("bin", "obj") } |
Remove-Item -Recurse -Force

Örneğin projelerin C:\Users\Emre\source\repos altında ise:

Get-ChildItem -Path "$env:USERPROFILE\source\repos" -Directory -Recurse |
Where-Object { $_.Name -in @("bin", "obj") } |
Remove-Item -Recurse -Force