$ErrorActionPreference = "Stop"
echo Get-PSRepository
Get-PSRepository
$ErrorActionPreference
echo 'Find-Module AppVeyorTestPsGallery'
Find-Module AppVeyorTestPsGallery
$ErrorActionPreference
(Get-Content .\AppVeyorTestPsGallery\AppVeyorTestPsGallery.psd1).replace('<BUILD_VERSION>', $env:APPVEYOR_BUILD_VERSION) | Set-Content .\AppVeyorTestPsGallery\AppVeyorTestPsGallery.psd1
echo mkdir
mkdir $env:userprofile\Documents\WindowsPowerShell\Modules\AppVeyorTestPsGallery
echo Copy-Item
Copy-Item .\AppVeyorTestPsGallery\* $env:userprofile\Documents\WindowsPowerShell\Modules\AppVeyorTestPsGallery\ -Recurse -Force
echo Publish-Module
Publish-Module -Name AppVeyorTestPsGallery -NuGetApiKey $env:psg_api_key
echo Remove-Item
Remove-Item $env:userprofile\Documents\WindowsPowerShell\Modules\AppVeyorTestPsGallery -Recurse -Force
Write-Host "Wait for 30 seconds until the module is published"; Start-Sleep -s 30
echo 'Find-Module AppVeyorTestPsGallery'
Find-Module AppVeyorTestPsGallery
$ErrorActionPreference
echo Install-Module
Install-Module AppVeyorTestPsGallery -Scope AllUsers
Get-PackageProvider
echo Get-Module
Get-Module
$ErrorActionPreference
dir $env:ProgramFiles\WindowsPowerShell\Modules\AppVeyorTestPsGallery\$env:APPVEYOR_BUILD_VERSION
