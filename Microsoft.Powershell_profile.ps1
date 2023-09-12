Set-Alias -Name g -Value git

Set-Alias -Name rider -Value ~\AppData\Local\JetBrains\Toolbox\scripts\Rider.cmd

function theme {
  $key = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'
  $theme = (Get-ItemProperty -Path $key -Name AppsUseLightTheme).AppsUseLightTheme
  $theme = -not $theme
  Set-ItemProperty -Path $key -Name AppsUseLightTheme -Value $theme 
}

Function playground {
  param (
    [string]$image = 'ubuntu'
  )

  docker run --rm -it --entrypoint bash $image
}

Function trim {
  param (
    [string]$inputFile,
    [string]$startTime = "00:00:00",
    [string]$duration = "00:01:00"
  )

  $fileName = $inputFile.SubString(0, $inputFile.LastIndexOf('.'))
  $fileExtension = $inputFile.SubString($inputFile.LastIndexOf('.'))
  $outFile = -join ($fileName, "-trimmed", $fileExtension)

  ffmpeg -ss $startTime -i $inputFile -t $duration -acodec copy -vcodec copy $outFile
}

oh-my-posh init pwsh | Invoke-Expression
