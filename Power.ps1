#variables
#$regionalsettingsURL = "https://github.com/Ramya-Addla/PostBuilds.git/local.xml"
$RegionalSettings = "C:\RegionSetFiles\India.xml"


#downdload regional settings file
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($RegionalSettings)

function writeName($str){
   Write-Output "$str"
}
$name = Read-Host "Enter RegionName:"
writeName($name)

$SEL = get-content $RegionalSettings
if( $SEL -imatch "Region" )
{
   Write-Host 'yes!!!!Contains String'
   $SEL.replace('Region','$name')
}
else
{
   Write-Host 'Does not contain String'
}

# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

# Set languages/culture. Not needed perse.
Set-WinSystemLocale Region
Set-WinUserLanguageList -LanguageList Region -Force
Set-Culture -CultureInfo Region
Set-TimeZone -Name "India Standard Time"

# restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
Start-sleep -Seconds 20
Restart-Computer