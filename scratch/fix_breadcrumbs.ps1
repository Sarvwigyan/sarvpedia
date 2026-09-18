# ==============================================================================
# Script: fix_breadcrumbs.ps1
# Fixes extra closing </span> tags on the breadcrumb line across all element files.
# ==============================================================================

$elementsDir = "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia\Elements"
$files = Get-ChildItem -Path $elementsDir -Filter "*_sarvpedia.html"

$fixedCount = 0

foreach ($file in $files) {
    if ($file.Name -eq "_template_sarvpedia.html") { continue }
    
    $path = $file.FullName
    $lines = [System.IO.File]::ReadAllLines($path, [System.Text.Encoding]::UTF8)
    $modified = $false
    
    for ($i = 0; $i -lt $lines.Length; $i++) {
        $line = $lines[$i]
        if ($line -match '<span class="breadcrumb-current"') {
            # Normalize to clean format:
            # e.g. <span class="breadcrumb-current" lang="hi">एक्टिनियम <span lang="en" class="term">(Actinium)</span></span>
            if ($line -match '(<span class="breadcrumb-current"[^>]*>.*?<span lang="en" class="term">.*?</span></span>)(?:</span>)+') {
                $lines[$i] = [regex]::Replace($line, '(<span class="breadcrumb-current"[^>]*>.*?<span lang="en" class="term">.*?</span></span>)(?:</span>)+', '$1')
                $modified = $true
            }
        }
    }
    
    if ($modified) {
        [System.IO.File]::WriteAllLines($path, $lines, [System.Text.Encoding]::UTF8)
        $fixedCount++
    }
}

Write-Output "Fixed breadcrumbs in $fixedCount files."
