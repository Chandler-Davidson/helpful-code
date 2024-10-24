# Powershell Tomfoolery

function touch {
  param (
    [string]$path
  )

  New-Item -Path $path -ItemType file 
}

function theme {
  $key = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'
  $theme = (Get-ItemProperty -Path $key -Name AppsUseLightTheme).AppsUseLightTheme
  $theme = -not $theme
  Set-ItemProperty -Path $key -Name AppsUseLightTheme -Value $theme 
}

Function admin {
  Start-Process -verb RunAs wt
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

Function search {
  param (
    [string]$searchString,
    [string[]]$fileExtensions = @(".cs", ".cshtml", ".js,", ".jsx", ".ts", ".tsx")
  )

  Get-ChildItem -Path ./ -Recurse -File |
  Where-Object { $_.Extension -in $fileExtensions } |
  ForEach-Object {
    $filePath = $_.FullName
    $result = Select-String -Path $filePath -Pattern $searchString -SimpleMatch
    if ($result) {
      Write-Host "$filePath | Line: $($result.LineNumber)"
    }
  }
}

# Git
Import-Module posh-git

# Git also has an alias on 'c':
# c:\> g c "Add new file" -> git add . && git commit -m "Add new file"
Set-Alias -Name g -Value git

# Rider
Set-Alias -Name rider -Value ~\AppData\Local\JetBrains\Toolbox\scripts\Rider.cmd

# Fat Fingers
Set-Alias -Name cleawr -Value clear

# Nvim
Set-Alias -Name v -value nvim

# ODE Add User
Function add-admin {
  param (
    [string]$env,
    [string]$firstName,
    [string]$lastName
  )

  if ($env -eq "-h") {
    Write-Host "Description:`n`tAdds a user to an ODE as a God Admin.`nUsage:`n`tadd-admin ot2 chandler davidson"
  }

  olo db add-admin-god -e $env -f $firstName -l $lastName -u "$firstName.$lastName"
}

# PDE Local Dev
Import-Module 'C:\code\pos-data-extract\powershell\PDE-LocalDev'

# Predictive History
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

oh-my-posh init pwsh | Invoke-Expression
