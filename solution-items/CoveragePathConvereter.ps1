param(
    [Parameter(Mandatory = $true)]
    $sourceDir,
    [Parameter(Mandatory = $true)]
    $targetDir,
    $newSource = "/home/vsts/work/1/s/",
    $countainerFolder = "source/"
)

Write-Host "Processing $($targetDir)"
    
$elements = Get-Childitem -Path "$($sourceDir)" -Include *coverage.cobertura.xml* -Recurse -ErrorAction SilentlyContinue
$elements | ForEach-Object -Process {      
    $newDirectory = (Split-Path -Path $_.FullName).Replace($sourceDir,$targetDir)
    $newFilePath = $_.FullName.Replace($sourceDir,$targetDir)
    New-Item "$($newDirectory)" -itemtype directory
    $fileContent = Get-Content -path $_ -Raw
    $fileUpdated = $fileContent.Replace("<source>/</source>","<source>$($newSource)</source>").Replace("filename=`"$($countainerFolder)",'filename="')
    Write-Host "Updated file $($_) to $($newFilePath)"
    $fileUpdated | Set-Content -Path $newFilePath -Force    
}
