$ErrorActionPreference = "Stop"
Get-PSRepository
Find-Module AppVeyorTestPsGallery
(Get-Content .\AppVeyorTestPsGallery\AppVeyorTestPsGallery.psd1).replace('<BUILD_VERSION>', $env:APPVEYOR_BUILD_VERSION) | Set-Content .\AppVeyorTestPsGallery\AppVeyorTestPsGallery.psd1
mkdir $env:userprofile\Documents\WindowsPowerShell\Modules\AppVeyorTestPsGallery
Copy-Item .\AppVeyorTestPsGallery\* $env:userprofile\Documents\WindowsPowerShell\Modules\AppVeyorTestPsGallery\ -Recurse -Force
Publish-Module -Name AppVeyorTestPsGallery -NuGetApiKey $env:psg_api_key
Remove-Item $env:userprofile\Documents\WindowsPowerShell\Modules\AppVeyorTestPsGallery -Recurse -Force
Write-Host "Wait for 30 seconds until the module is published"; Start-Sleep -s 30
Find-Module AppVeyorTestPsGallery
Install-Module AppVeyorTestPsGallery -Scope AllUsers
Get-PackageProvider
Get-Module
dir $env:ProgramFiles\WindowsPowerShell\Modules\AppVeyorTestPsGallery\$env:APPVEYOR_BUILD_VERSION
