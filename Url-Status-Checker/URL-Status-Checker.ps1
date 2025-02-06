# Ask user to input URLs
$urls = @()
while ($true) {
    $inputUrl = Read-Host "Enter a URL (or type 'done' to finish)"
    if ($inputUrl -eq 'done') { break }
    $urls += $inputUrl
}

# Loop through each URL and check the status code
foreach ($url in $urls) {
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing
        $statusCode = $response.StatusCode
    } catch {
        $statusCode = $_.Exception.Response.StatusCode.Value__
    }
    
    # Display result on screen
    Write-Host "Checked URL: $url - Status Code: $statusCode"
}