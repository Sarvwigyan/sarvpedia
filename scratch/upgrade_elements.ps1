# Upgrade elements 21 to 118
$ErrorActionPreference = "Stop"

$jsonPath = "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia\scratch\elements_data_21_to_118.json"
$elements = Get-Content $jsonPath -Raw -Encoding UTF8 | ConvertFrom-Json

$propMap = @{
    'Atomic Number' = 'परमाणु क्रमांक'
    'Atomic Weight' = 'मानक परमाणु भार'
    'Density' = 'घनत्व'
    'Melting Point' = 'गलनांक'
    'Boiling Point' = 'क्वथनांक'
    'Electronegativity' = 'विद्युत ऋणात्मकता'
    'Ionization Energy' = 'आयनन ऊर्जा'
    'Oxidation States' = 'ऑक्सीकरण अवस्थाएँ'
    'Phase' = 'अवस्था'
    'Category' = 'श्रेणी'
    'Discovery' = 'खोजकर्ता'
    'Discoverer' = 'खोजकर्ता'
    'Electron Configuration' = 'इलेक्ट्रॉन विन्यास'
    'Crystal Structure' = 'क्रिस्टल संरचना'
    'Specific Heat' = 'विशिष्ट ऊष्मा'
    'Thermal Conductivity' = 'ऊष्मा चालकता'
}

$skipProps = @(
    'परमाणु क्रमांक', 'रासायनिक प्रतीक', 'मानक परमाणु भार', 'आवर्त / वर्ग', 'श्रेणी', 'इलेक्ट्रॉन विन्यास',
    'Atomic Number', 'Atomic Weight', 'Electron Configuration', 'Period', 'Group', 'Category', 'Symbol'
)

$count = 0
foreach ($item in $elements) {
    $filePath = "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia\Elements\$($item.en)_sarvpedia.html"
    if (-not (Test-Path $filePath)) {
        Write-Warning "File not found: $filePath"
        continue
    }

    $raw = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

    # 1. Title
    $raw = [regex]::Replace($raw, '<title>.*?</title>', "<title>$($item.hi) ($($item.en)) — Sarvpedia | सर्वविज्ञान</title>")

    # 2. Meta description
    $desc = "$($item.hi) ($($item.en), $($item.sym), परमाणु क्रमांक $($item.z)) — सर्वपीडिया का प्रामाणिक ज्ञानकोश लेख।"
    $raw = [regex]::Replace($raw, '<meta name="description" content=".*?">', "<meta name=`"description`" content=`"$desc`">")

    # 3. Schema.org JSON-LD
    $schemaJson = @"
<script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Article",
      "inLanguage": "hi-IN",
      "isPartOf": {
        "@type": "WebSite",
        "name": "सर्वपीडिया",
        "url": "https://sarvwigyan.github.io/sarvpedia/"
      },
      "publisher": {
        "@type": "Organization",
        "name": "सर्वविज्ञान",
        "url": "https://sarvwigyan.github.io/"
      },
      "headline": "$($item.hi)",
      "alternativeHeadline": "$($item.en) ($($item.sym))",
      "description": "$($item.hi) ($($item.en), प्रतीक: $($item.sym), परमाणु संख्या: $($item.z)) — आवर्त सारणी का रासायनिक तत्व।",
      "author": { "@type": "Person", "name": "सर्वविज्ञान" },
      "datePublished": "2026-09-18",
      "dateModified": "2026-09-18"
    }
    </script>
"@
    $raw = [regex]::Replace($raw, '<script type="application/ld\+json">[\s\S]*?</script>', $schemaJson)

    # 4. Breadcrumb
    $bcPattern = '<span class="breadcrumb-current"[^>]*>[\s\S]*?</span>'
    $bcReplace = "<span class=`"breadcrumb-current`" lang=`"hi`">$($item.hi) <span lang=`"en`" class=`"term`">($($item.en))</span></span>"
    $raw = [regex]::Replace($raw, $bcPattern, $bcReplace)

    # 5. Article Header
    $leadText = "$($item.hi) आवर्त सारणी का एक रासायनिक तत्व है जिसका प्रतीक <span lang=`"en`" class=`"term mono`">$($item.sym)</span> तथा परमाणु क्रमांक <span lang=`"en`" class=`"term`">$($item.z)</span> है। यह आवर्त सारणी के समूह <span lang=`"en`" class=`"term`">$($item.group)</span> तथा आवर्त <span lang=`"en`" class=`"term`">$($item.period)</span> का तत्व है और <span lang=`"hi`">$($item.cat)</span> श्रेणी में आता है।"
    $artHeader = @"
<header class="article-header">
                    <h1 lang="hi">
                        $($item.hi)
                        <span lang="en" class="term">($($item.en))</span>
                    </h1>
                    <p class="title-en" lang="en">Atomic Number: $($item.z) · Symbol: $($item.sym)</p>
                    <p class="lead" lang="hi">
                        $leadText
                    </p>
                </header>
"@
    $raw = [regex]::Replace($raw, '<header class="article-header">[\s\S]*?</header>', $artHeader)

    # 6. Infobox Header
    $raw = [regex]::Replace($raw, '<h3 class="infobox-title"[^>]*>.*?</h3>', "<h3 class=`"infobox-title`" lang=`"hi`">$($item.hi)</h3>")
    $raw = [regex]::Replace($raw, '<div class="infobox-subtitle"[^>]*>.*?</div>', "<div class=`"infobox-subtitle`" lang=`"en`">$($item.en) · $($item.sym) · $($item.z)</div>")

    # 7. Infobox Table: Extract existing extra properties
    $extractedProps = [ordered]@{}
    $propMatches = [regex]::Matches($raw, '<tr[^>]*>\s*<th[^>]*>([^<]+)</th>\s*<td[^>]*>([^<]+)</td>\s*</tr>')
    foreach ($m in $propMatches) {
        $k = $m.Groups[1].Value.Trim()
        $v = $m.Groups[2].Value.Trim()
        $kHi = if ($propMap.ContainsKey($k)) { $propMap[$k] } else { $k }
        $extractedProps[$kHi] = $v
    }

    $rows = @()
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">परमाणु क्रमांक</th>`n                            <td lang=`"en`" class=`"term mono`">$($item.z)</td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">रासायनिक प्रतीक</th>`n                            <td lang=`"en`" class=`"term mono`">$($item.sym)</td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">मानक परमाणु भार</th>`n                            <td lang=`"en`" class=`"term mono`">$($item.w) u</td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">आवर्त / वर्ग</th>`n                            <td lang=`"hi`"><span lang=`"en`" class=`"term`">$($item.period) / $($item.group)</span></td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">श्रेणी</th>`n                            <td lang=`"hi`">$($item.cat)</td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">इलेक्ट्रॉन विन्यास</th>`n                            <td lang=`"en`" class=`"term mono`">$($item.config)</td>`n                        </tr>"

    foreach ($k in $extractedProps.Keys) {
        if ($k -notin $skipProps) {
            $val = $extractedProps[$k]
            $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">$k</th>`n                            <td lang=`"en`" class=`"term mono`">$val</td>`n                        </tr>"
        }
    }

    $tableInner = "<tbody>`n                        " + ($rows -join "`n                        ") + "`n                    </tbody>"
    $raw = [regex]::Replace($raw, '<tbody>[\s\S]*?</tbody>', $tableInner)

    # 8. References / Footnotes
    $refSection = @"
<section id="references" class="footnotes">
                        <h2 class="footnotes-title" lang="hi">
                            संदर्भ सूची
                            <a href="#references" class="section-anchor" aria-label="अनुभाग लिंक"><i class="fas fa-link" aria-hidden="true"></i></a>
                        </h2>
                        <ol class="footnotes-list">
                            <li id="ref-1" lang="hi">
                                <span class="citation">
                                    <span lang="en" class="term">IUPAC Periodic Table of the Elements</span>, २०२६ संस्करण।
                                    <a href="#intro" class="footnote-back" aria-label="वापस ऊपर जाएँ"><i class="fas fa-arrow-up" aria-hidden="true"></i></a>
                                </span>
                            </li>
                            <li id="ref-2" lang="hi">
                                <span class="citation">
                                    सर्वविज्ञान रसायन विज्ञान प्रभाग, <span lang="en" class="term">"तत्व ज्ञानकोश — $($item.hi)"</span>, २०२६।
                                    <a href="#properties" class="footnote-back" aria-label="वापस ऊपर जाएँ"><i class="fas fa-arrow-up" aria-hidden="true"></i></a>
                                </span>
                            </li>
                        </ol>
                    </section>
"@
    if ($raw -match '<section id="references"[\s\S]*?</section>') {
        $raw = [regex]::Replace($raw, '<section id="references"[\s\S]*?</section>', $refSection)
    }

    [System.IO.File]::WriteAllText($filePath, $raw, [System.Text.Encoding]::UTF8)
    $count++
}

Write-Output "Successfully upgraded $count element files (21 to 118)."
