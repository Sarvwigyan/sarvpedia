# ==============================================================================
# Script: audit_all_elements.ps1
# Comprehensive audit of all 118 chemical elements in Sarvpedia.
# ==============================================================================

$elementsDir = "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia\Elements"
$files = Get-ChildItem -Path $elementsDir -Filter "*_sarvpedia.html" | Where-Object { $_.Name -ne "_template_sarvpedia.html" }

Write-Host "Total element files found: $($files.Count)"

$issues = @()
$totalPassed = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $name = $file.Name
    $fileIssues = @()

    # 1. Check for character corruption (????)
    if ($content -match '\?\?\?\?') {
        $fileIssues += "Corrupted characters (????) detected"
    }

    # 2. Check main.css
    if ($content -notmatch 'css/main\.css') {
        $fileIssues += "Missing main.css"
    }

    # 3. Ecosystem header
    if ($content -notmatch 'class="[^"]*site-header[^"]*"') {
        $fileIssues += "Missing site-header"
    }

    # 4. Breadcrumb
    if ($content -notmatch 'class="[^"]*breadcrumb[^"]*"') {
        $fileIssues += "Missing breadcrumb"
    }

    # 5. Table of contents
    if ($content -notmatch 'class="[^"]*toc[^"]*"') {
        $fileIssues += "Missing TOC"
    }

    # 6. Article header
    if ($content -notmatch '<h1 lang="hi">') {
        $fileIssues += "Missing <h1 lang='hi'>"
    }
    if ($content -notmatch 'class="title-en"') {
        $fileIssues += "Missing title-en"
    }
    if ($content -notmatch 'class="lead"') {
        $fileIssues += "Missing lead paragraph"
    }

    # 7. Infobox
    if ($content -notmatch 'class="[^"]*infobox[^"]*"') {
        $fileIssues += "Missing infobox"
    }
    if ($content -notmatch 'class="infobox-subtitle"') {
        $fileIssues += "Missing infobox-subtitle"
    }
    if ($content -notmatch 'परमाणु क्रमांक') {
        $fileIssues += "Missing Hindi property row: परमाणु क्रमांक"
    }

    # 8. Ecosystem footer
    if ($content -notmatch 'class="[^"]*site-footer[^"]*"') {
        $fileIssues += "Missing site-footer"
    }

    # 9. Lang switcher
    if ($content -notmatch 'lang-switcher\.js') {
        $fileIssues += "Missing lang-switcher.js"
    }

    # 10. Schema JSON-LD
    if ($content -notmatch 'application/ld\+json') {
        $fileIssues += "Missing schema JSON-LD"
    }

    # 11. Span tag balance in breadcrumb
    $bcMatch = [regex]::Match($content, '(?s)<nav class="breadcrumb"[^>]*>(.*?)</nav>')
    if ($bcMatch.Success) {
        $bcText = $bcMatch.Groups[1].Value
        $openSpans = ([regex]::Matches($bcText, '<span')).Count
        $closeSpans = ([regex]::Matches($bcText, '</span>')).Count
        if ($openSpans -ne $closeSpans) {
            $fileIssues += "Breadcrumb span imbalance (open: $openSpans, close: $closeSpans)"
        }
    }

    if ($fileIssues.Count -gt 0) {
        $issues += [PSCustomObject]@{
            File = $name
            Issues = ($fileIssues -join "; ")
        }
    } else {
        $totalPassed++
    }
}

Write-Host "=========================================="
Write-Host "AUDIT SUMMARY:"
Write-Host "Total elements evaluated: $($files.Count)"
Write-Host "Elements fully compliant: $totalPassed"
Write-Host "Elements with issues: $($issues.Count)"
Write-Host "=========================================="

if ($issues.Count -gt 0) {
    Write-Host "Issues details:"
    $issues | Format-Table -AutoSize
} else {
    Write-Host "SUCCESS: All 118 elements pass 100% of the ecosystem compliance standards!"
}
