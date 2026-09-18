$jsPath = "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia\elements.js"
$content = [System.IO.File]::ReadAllText($jsPath, [System.Text.Encoding]::UTF8)

$matches = [regex]::Matches($content, '"link":\s*"([^"]+)"')
Write-Host "Total links found in elements.js: $($matches.Count)"

$missing = @()
foreach ($m in $matches) {
    $rel = $m.Groups[1].Value
    $full = Join-Path "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia" $rel
    if (-not (Test-Path $full)) {
        $missing += $rel
    }
}

if ($missing.Count -eq 0) {
    Write-Host "All $($matches.Count) element links in elements.js point to existing files!"
} else {
    Write-Host "Missing files: $($missing.Count)"
    $missing | ForEach-Object { Write-Host " - $_" }
}
