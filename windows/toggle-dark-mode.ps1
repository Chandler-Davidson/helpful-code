$key = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'
$theme = (Get-ItemProperty -Path $key -Name AppsUseLightTheme).AppsUseLightTheme
$theme = -not $theme
Set-ItemProperty -Path $key -Name AppsUseLightTheme -Value $theme