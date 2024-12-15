# File Integrity Checker

## 🔍 Overview

The **File Integrity Checker** is a PowerShell-based utility designed to verify the integrity of files by comparing their cryptographic hash values. It ensures that files have not been altered during transfer or storage, providing a simple and effective way to detect tampering or corruption.

---

## 🚀 Features

- **Hash Comparison**: Computes the SHA-256 hash values of the original and received files to check for any changes.
- **User Input**: Accepts file paths for both the original and received files from the user.
- **Validation**: Ensures file paths are valid before proceeding with the comparison.
- **Quick Results**: Provides immediate feedback on whether the files match or have been modified.

---

## 📂 How It Works

1. **Input File Paths**: 
   - Enter the file path of the original file.
   - Enter the file path of the received file.

2. **Hash Calculation**: 
   - The script calculates the SHA-256 hash for each file using PowerShell's `Get-FileHash` cmdlet.

3. **Comparison**: 
   - Compares the two hash values.
   - Displays a message indicating if the files match or if changes were detected.

---

## 🛠️ Script Usage

### Prerequisites
- PowerShell installed on your system (default on Windows).
- Files to compare should be accessible via valid paths.

### Running the Script
1. Copy the script into a `.ps1` file, such as `FileIntegrityChecker.ps1`.
2. Open PowerShell and navigate to the directory containing the script.
3. Run the script by entering:
   ```powershell
   .\FileIntegrityChecker.ps1
Follow the prompts to input the file paths for comparison.
📌 Example
Scenario:
You have an original file located at C:\Files\original.txt and a received file at C:\Files\received.txt.

Steps:

1. Run the script.
2. When prompted, enter the file paths:
3. Enter the file path of the original file: C:\Files\original.txt
4. Enter the file path of the received file: C:\Files\received.txt
5. The script computes and compares the hash values, then displays the result:
6. If files match: The received file matches the original file. No changes detected.
7. If files differ: The received file has been changed!

### 🖥️ Expected Results
You can view an example of the expected results 

![Expected Results](https://github.com/21Lalit/Powershell-Scripting/blob/main/File%20Integrity%20Checker/Expected-Results.png)
---

## 🖥️ Code Breakdown
Function: Get-FileHashValue

Computes the SHA-256 hash value of a given file.

---

function Get-FileHashValue {
    param ([string]$filePath)
    return (Get-FileHash -Path $filePath -Algorithm "SHA256").Hash
}

Function: Compare-Files
Prompts the user for file paths, validates them, computes hashes, and compares the results.

---

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
🤝 Contribution
Suggestions and improvements are welcome! Feel free to fork this repository, open issues, or submit pull requests.

💡 Acknowledgments
Special thanks to the PowerShell team for their powerful and versatile scripting tools.

>  _"In a digital world, integrity is everything."_
