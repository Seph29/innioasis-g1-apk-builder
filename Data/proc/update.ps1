# Define the path to in.txt
$inFilePath = "./proc/in.txt"

# Check if in.txt exists
if (-not (Test-Path -Path $inFilePath)) {
    Write-Output "ERROR: in.txt not found in the current directory!"
    exit 1
}

# Read the package name from in.txt
$packageName = Get-Content -Path $inFilePath -Raw

# Trim any leading/trailing whitespace from the package name
$packageName = $packageName.Trim()

# Check if the package name is empty
if ([string]::IsNullOrEmpty($packageName)) {
    Write-Output "ERROR: Package name is empty or not found in ./proc/in.txt!"
    exit 1
}

# Define the path to the AndroidManifest.xml file
$manifestPath = "./temp/AndroidManifest.xml"

# Check if the AndroidManifest.xml file exists
if (-not (Test-Path -Path $manifestPath)) {
    Write-Output "ERROR: AndroidManifest.xml not found in ./temp directory!"
    exit 1
}

# Read the content of the AndroidManifest.xml file
$content = Get-Content -Path $manifestPath -Raw

# Replace the package name in the file
$newContent = $content -replace 'package="[^"]*"', "package=`"$packageName`""

# Write the modified content back to the file
Set-Content -Path $manifestPath -Value $newContent

Write-Output "Package name replaced successfully with '$packageName'."