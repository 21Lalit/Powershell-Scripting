# Function to compute the hash of a file
function Get-FileHashValue {
    param ([string]$filePath)
    return (Get-FileHash -Path $filePath -Algorithm "SHA256").Hash
}

# Main function for comparing two files
function Compare-Files {
    $originalFile = Read-Host "Enter the file path of the original file"
    $receivedFile = Read-Host "Enter the file path of the received file"

    if ((Test-Path $originalFile) -and (Test-Path $receivedFile)) {
        $originalHash = Get-FileHashValue -filePath $originalFile
        $receivedHash = Get-FileHashValue -filePath $receivedFile

        if ($originalHash -eq $receivedHash) {
            Write-Host "The received file matches the original file. No changes detected."
        } else {
            Write-Host "The received file has been changed!"
        }
    } else {
        Write-Host "One or both file paths are invalid."
    }
}

# Start the comparison
Compare-Files
