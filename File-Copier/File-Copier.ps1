Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "File Copy Controller"
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = "CenterScreen"

# Create Label and TextBox for Source File
$sourceLabel = New-Object System.Windows.Forms.Label
$sourceLabel.Text = "Source File:"
$sourceLabel.Location = New-Object System.Drawing.Point(20, 20)
$sourceLabel.AutoSize = $true
$form.Controls.Add($sourceLabel)

$sourceTextBox = New-Object System.Windows.Forms.TextBox
$sourceTextBox.Location = New-Object System.Drawing.Point(100, 20)
$sourceTextBox.Size = New-Object System.Drawing.Size(200, 20)
$form.Controls.Add($sourceTextBox)

$sourceButton = New-Object System.Windows.Forms.Button
$sourceButton.Location = New-Object System.Drawing.Point(310, 18)
$sourceButton.Size = New-Object System.Drawing.Size(75, 23)
$sourceButton.Text = "Browse"
$form.Controls.Add($sourceButton)

# Create Label and TextBox for Destination Folder
$destinationLabel = New-Object System.Windows.Forms.Label
$destinationLabel.Text = "Destination:"
$destinationLabel.Location = New-Object System.Drawing.Point(20, 60)
$destinationLabel.AutoSize = $true
$form.Controls.Add($destinationLabel)

$destinationTextBox = New-Object System.Windows.Forms.TextBox
$destinationTextBox.Location = New-Object System.Drawing.Point(100, 60)
$destinationTextBox.Size = New-Object System.Drawing.Size(200, 20)
$form.Controls.Add($destinationTextBox)

$destinationButton = New-Object System.Windows.Forms.Button
$destinationButton.Location = New-Object System.Drawing.Point(310, 58)
$destinationButton.Size = New-Object System.Drawing.Size(75, 23)
$destinationButton.Text = "Browse"
$form.Controls.Add($destinationButton)

# Create Start Button
$startButton = New-Object System.Windows.Forms.Button
$startButton.Location = New-Object System.Drawing.Point(100, 100)
$startButton.Size = New-Object System.Drawing.Size(75, 30)
$startButton.Text = "Start"
$form.Controls.Add($startButton)

# Create Stop Button
$stopButton = New-Object System.Windows.Forms.Button
$stopButton.Location = New-Object System.Drawing.Point(200, 100)
$stopButton.Size = New-Object System.Drawing.Size(75, 30)
$stopButton.Text = "Stop"
$stopButton.Enabled = $false
$form.Controls.Add($stopButton)

# Global variables
$job = $null
$running = $false

# Browse for Source File
$sourceButton.Add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $sourceTextBox.Text = $openFileDialog.FileName
    }
})

# Browse for Destination Folder
$destinationButton.Add_Click({
    $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($folderDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $destinationTextBox.Text = $folderDialog.SelectedPath
    }
})

# Start Button Click Event
$startButton.Add_Click({
    $sourceFile = $sourceTextBox.Text
    $destination = $destinationTextBox.Text

    if (-not (Test-Path $sourceFile)) {
        [System.Windows.Forms.MessageBox]::Show("Invalid source file!", "Error", "OK", "Error")
        return
    }

    if (-not (Test-Path $destination)) {
        [System.Windows.Forms.MessageBox]::Show("Invalid destination folder!", "Error", "OK", "Error")
        return
    }

    $startButton.Enabled = $false
    $stopButton.Enabled = $true
    $script:running = $true
    
    # Run the job
    $script:job = Start-Job -ScriptBlock {
        param($source, $dest)
        while ($true) {
            $timestamp = Get-Date -Format "yyyyMMddHHmmss"
            $newFileName = "copied_file_$timestamp" + [System.IO.Path]::GetExtension($source)
            Copy-Item -Path $source -Destination (Join-Path $dest $newFileName) -Force
        }
    } -ArgumentList $sourceFile, $destination
})

# Stop Button Click Event
$stopButton.Add_Click({
    $script:running = $false
    if ($job -ne $null) {
        Stop-Job -Job $job
        Remove-Job -Job $job
    }
    $startButton.Enabled = $true
    $stopButton.Enabled = $false
})

# Cleanup on Form Close
$form.Add_FormClosing({
    if ($job -ne $null) {
        Stop-Job -Job $job
        Remove-Job -Job $job
    }
})

# Run the Form
[void]$form.ShowDialog()
