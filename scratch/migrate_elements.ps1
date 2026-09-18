# PowerShell Script: migrate_elements.ps1
# Batch migrate Sarvpedia element pages to the new ecosystem format.

$hindiNames = @{
    'Actinium' = 'एक्टिनियम'; 'Aluminium' = 'एल्युमिनियम'; 'Americium' = 'अमेरिकियम'; 'Antimony' = 'एंटीमनी';
    'Argon' = 'आर्गन'; 'Arsenic' = 'आर्सेनिक'; 'Astatine' = 'एस्टैटिन'; 'Barium' = 'बेरियम';
    'Berkelium' = 'बर्केलियम'; 'Beryllium' = 'बेरिलियम'; 'Bismuth' = 'बिस्मथ'; 'Bohrium' = 'बोरियम';
    'Boron' = 'बोरॉन'; 'Bromine' = 'ब्रोमीन'; 'Cadmium' = 'कैडमियम'; 'Caesium' = 'सीजियम';
    'Calcium' = 'कैल्शियम'; 'Californium' = 'कैलिफोर्नियम'; 'Carbon' = 'कार्बन'; 'Cerium' = 'सीरियम';
    'Chlorine' = 'क्लोरीन'; 'Chromium' = 'क्रोमियम'; 'Cobalt' = 'कोबाल्ट'; 'Copernicium' = 'कॉपरनिसियम';
    'Copper' = 'ताँबा (कॉपर)'; 'Curium' = 'क्यूरियम'; 'Darmstadtium' = 'डार्मस्टैडियम'; 'Dubnium' = 'डब्नियम';
    'Dysprosium' = 'डिस्प्रोसियम'; 'Einsteinium' = 'आइंस्टीनियम'; 'Erbium' = 'एर्बियम'; 'Europium' = 'यूरोपियम';
    'Fermium' = 'फर्मियम'; 'Flerovium' = 'फ्लेरोवियम'; 'Fluorine' = 'फ्लोरीन'; 'Francium' = 'फ्रैंशियम';
    'Gadolinium' = 'गैडोलीनियम'; 'Gallium' = 'गैलियम'; 'Germanium' = 'जर्मेनियम'; 'Gold' = 'सोना (स्वर्ण)';
    'Hafnium' = 'हाफ्नियम'; 'Hassium' = 'हैसियम'; 'Helium' = 'हीलियम'; 'Holmium' = 'होल्मियम';
    'Hydrogen' = 'हाइड्रोजन'; 'Indium' = 'इंडियम'; 'Iodine' = 'आयोडीन'; 'Iridium' = 'इरिडियम';
    'Iron' = 'लोहा (आयरन)'; 'Krypton' = 'क्रिप्टन'; 'Lanthanum' = 'लैंथेनम'; 'Lawrencium' = 'लॉरेंशियम';
    'Lead' = 'सीसा (लेड)'; 'Lithium' = 'लिथियम'; 'Livermorium' = 'लिवरमोरियम'; 'Lutetium' = 'लुटेशियम';
    'Magnesium' = 'मैग्नीशियम'; 'Manganese' = 'मैंगनीज'; 'Meitnerium' = 'माइटनेरियम'; 'Mendelevium' = 'मेंडेलीवियम';
    'Mercury' = 'पारा (मर्करी)'; 'Molybdenum' = 'मोलिब्डेनम'; 'Moscovium' = 'मॉस्कोवियम'; 'Neodymium' = 'नियोडिमियम';
    'Neon' = 'नियॉन'; 'Neptunium' = 'नेप्च्यूनियम'; 'Nickel' = 'निकल'; 'Nihonium' = 'निहोनियम';
    'Niobium' = 'नायोबियम'; 'Nitrogen' = 'नाइट्रोजन'; 'Nobelium' = 'नोबेलियम'; 'Oganesson' = 'ओगानेसन';
    'Osmium' = 'ऑस्मियम'; 'Oxygen' = 'ऑक्सीजन'; 'Palladium' = 'पैलेडियम'; 'Phosphorus' = 'फास्फोरस';
    'Platinum' = 'प्लैटिनम'; 'Plutonium' = 'प्लूटोनियम'; 'Polonium' = 'पोलोनियम'; 'Potassium' = 'पोटैशियम';
    'Praseodymium' = 'प्रेजोडायमियम'; 'Promethium' = 'प्रोमेथियम'; 'Protactinium' = 'प्रोटाक्टिनियम';
    'Radium' = 'रेडियम'; 'Radon' = 'रेडॉन'; 'Rhenium' = 'रीनियम'; 'Rhodium' = 'रोडियम';
    'Roentgenium' = 'रॉन्टगेनियम'; 'Rubidium' = 'रुबिडियम'; 'Ruthenium' = 'रुथेनियम'; 'Rutherfordium' = 'रदरफोर्डियम';
    'Samarium' = 'समेरियम'; 'Scandium' = 'स्कैंडियम'; 'Seaborgium' = 'सीबोर्गियम'; 'Selenium' = 'सेलेनियम';
    'Silicon' = 'सिलिकॉन'; 'Silver' = 'चाँदी (रजत)'; 'Sodium' = 'सोडियम'; 'Strontium' = 'स्ट्रोंटियम';
    'Sulfur' = 'गंधक (सल्फर)'; 'Tantalum' = 'टैंटलम'; 'Technetium' = 'टेक्नेशियम'; 'Tellurium' = 'टेल्यूरियम';
    'Tennessine' = 'टेनेसीन'; 'Terbium' = 'टर्बियम'; 'Thallium' = 'थैलियम'; 'Thorium' = 'थोरियम';
    'Thulium' = 'थ्यूलियम'; 'Tin' = 'टिन (रांगा)'; 'Titanium' = 'टाइटेनियम'; 'Tungsten' = 'टंगस्टन';
    'Uranium' = 'यूरेनियम'; 'Vanadium' = 'वैनेडियम'; 'Xenon' = 'जेनान'; 'Ytterbium' = 'इटर्बियम';
    'Yttrium' = 'इट्रियम'; 'Zinc' = 'जस्ता (जिंक)'; 'Zirconium' = 'जिरकोनियम'
}

$propMap = @{
    'Atomic Number' = 'परमाणु क्रमांक';
    'Atomic Weight' = 'मानक परमाणु भार';
    'Density' = 'घनत्व';
    'Melting Point' = 'गलनांक';
    'Boiling Point' = 'क्वथनांक';
    'Electron Configuration' = 'इलेक्ट्रॉन विन्यास'
}

function Convert-ElementFile {
    param([string]$FilePath)

    $raw = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::UTF8)

    # Extract element English name
    if ($raw -match '<h1>\s*([A-Za-z]+)\s*</h1>') {
        $elemEn = $matches[1]
    } else {
        return
    }

    $elemHi = if ($hindiNames.ContainsKey($elemEn)) { $hindiNames[$elemEn] } else { $elemEn }

    # Extract table properties
    $props = @()
    $tableMatches = [regex]::Matches($raw, '<tr>\s*<td>([^<]+)</td>\s*<td>([^<]+)</td>\s*</tr>')
    foreach ($m in $tableMatches) {
        $pName = $m.Groups[1].Value.Trim()
        $pVal = $m.Groups[2].Value.Trim()
        $pNameHi = if ($propMap.ContainsKey($pName)) { $propMap[$pName] } else { $pName }
        $props += [PSCustomObject]@{ NameHi = $pNameHi; NameEn = $pName; Value = $pVal }
    }

    # Extract sections
    $sections = @()
    $secMatches = [regex]::Matches($raw, '<div class="section">\s*<h2>([^<]+)</h2>([\s\S]*?)</div>\s*(?=(<div class="section">|<button))')
    foreach ($sm in $secMatches) {
        $title = $sm.Groups[1].Value.Trim()
        $body = $sm.Groups[2].Value.Trim()
        # Remove table from body if present
        $bodyClean = [regex]::Replace($body, '<table>[\s\S]*?</table>', '').Trim()
        $sections += [PSCustomObject]@{ Title = $title; Body = $bodyClean }
    }

    # Map section titles to anchor IDs and Hindi titles
    $secData = @()
    foreach ($s in $sections) {
        $t = $s.Title
        $id = "sec-" + ($t.ToLower() -replace '[^a-z0-9]+', '-')
        $hiTitle = $t

        if ($t -match 'Introduction') { $id = 'intro'; $hiTitle = 'परिचय' }
        elseif ($t -match 'Isotopes') { $id = 'isotopes'; $hiTitle = 'समस्थानिक (Isotopes)' }
        elseif ($t -match 'Properties') { $id = 'properties'; $hiTitle = 'भौतिक व रासायनिक गुण' }
        elseif ($t -match 'History') { $id = 'history'; $hiTitle = 'इतिहास व खोज' }
        elseif ($t -match 'Applications') { $id = 'applications'; $hiTitle = 'अनुप्रयोग एवं उपयोगिता' }
        elseif ($t -match 'Universe') { $id = 'universe'; $hiTitle = 'ब्रह्मांड में उपस्थिति' }
        elseif ($t -match 'Production') { $id = 'production'; $hiTitle = 'उत्पादन व निष्कर्षण' }
        elseif ($t -match 'Safety') { $id = 'safety'; $hiTitle = 'सुरक्षा व सावधानियाँ' }
        elseif ($t -match 'Conclusion') { $id = 'conclusion'; $hiTitle = 'निष्कर्ष' }

        $secData += [PSCustomObject]@{ Id = $id; Title = $hiTitle; Body = $s.Body }
    }

    # Build TOC HTML
    $tocItems = ""
    foreach ($sd in $secData) {
        $tocItems += "                                <li class=`"toc-item`"><a href=`"#$($sd.Id)`" class=`"toc-link`" lang=`"hi`">$($sd.Title)</a></li>`n"
    }
    $tocItems += "                                <li class=`"toc-item`"><a href=`"#references`" class=`"toc-link`" lang=`"hi`">संदर्भ सूची</a></li>"

    # Build Infobox Table HTML
    $infoboxRows = ""
    foreach ($p in $props) {
        $infoboxRows += @"
                        <tr>
                            <th scope="row" lang="hi">$($p.NameHi)</th>
                            <td lang="en" class="term mono">$($p.Value)</td>
                        </tr>

"@
    }

    # Extract lead from intro
    $leadText = ""
    $introSec = $secData | Where-Object { $_.Id -eq 'intro' } | Select-Object -First 1
    if ($introSec -and $introSec.Body -match '<p>([\s\S]*?)</p>') {
        $leadText = $matches[1].Trim()
    } else {
        $leadText = "$elemHi ($elemEn) आवर्त सारणी का एक महत्वपूर्ण तत्व है।"
    }

    # Format Body Sections
    $bodyHtml = ""
    foreach ($sd in $secData) {
        # Wrap inner text in proper lang tags
        $secBody = $sd.Body
        # ensure <p> tags have lang="hi"
        $secBody = [regex]::Replace($secBody, '<p>', '<p lang="hi">')
        $secBody = [regex]::Replace($secBody, '<h3>([^<]+)</h3>', '<h3 lang="hi">$1</h3>')
        $secBody = [regex]::Replace($secBody, '<h4>([^<]+)</h4>', '<h4 lang="hi">$1</h4>')

        $bodyHtml += @"
                    <section id="$($sd.Id)">
                        <h2 lang="hi">
                            $($sd.Title)
                            <a href="#$($sd.Id)" class="section-anchor" aria-label="अनुभाग लिंक"><i class="fas fa-link" aria-hidden="true"></i></a>
                        </h2>
                        $secBody
                    </section>

"@
    }

    $fileName = [System.IO.Path]::GetFileName($FilePath)

    # Full new document HTML
    $newHtml = @"
<!DOCTYPE html>
<html lang="hi" data-theme="light" data-locale="hi-IN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>document.documentElement.classList.add('js-ready');</script>

    <title>$elemHi ($elemEn) — Sarvpedia | सर्वविज्ञान</title>
    <!-- ── Language & i18n ── -->
    <link rel="alternate" hreflang="hi" href="https://sarvwigyan.github.io/sarvpedia/Elements/$fileName">
    <link rel="alternate" hreflang="en" href="https://sarvwigyan.github.io/sarvpedia/en/Elements/$fileName">
    <link rel="alternate" hreflang="x-default" href="https://sarvwigyan.github.io/sarvpedia/Elements/$fileName">

    <!-- ── Sarvwigyan ecosystem link ── -->
    <link rel="me" href="https://sarvwigyan.github.io/">
    <link rel="sibling" href="https://sarvwigyan.github.io/sarvstore/" title="Kosh">

    <meta name="description" content="$elemHi ($elemEn) — सर्वपीडिया का प्रामाणिक ज्ञानकोश लेख।">
    <meta name="author" content="सर्वविज्ञान">
    <meta name="robots" content="index, follow">
    <meta name="theme-color" content="#FFF9F0">

    <link rel="icon" type="image/svg+xml" href="../Resources/ganesh.svg">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700;9..144,800&family=Inter:wght@400;500;600;700;800&family=Mukta:wght@400;500;600;700;800&family=Tiro+Devanagari+Sanskrit:ital@0;1&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer">

    <link rel="stylesheet" href="../css/main.css">

    <!-- 1.3 Structured data — Article -->
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
      "headline": "$elemHi",
      "alternativeHeadline": "$elemEn",
      "description": "$elemHi ($elemEn) — आवर्त सारणी का रासायनिक तत्व।",
      "author": { "@type": "Person", "name": "सर्वविज्ञान" },
      "datePublished": "2026-09-18",
      "dateModified": "2026-09-18"
    }
    </script>
</head>
<body>

    <!-- ═══════════════════ HEADER ═══════════════════ -->
    <header class="site-header">
        <div class="header-inner">
            <div style="display: inline-flex; align-items: center; gap: var(--space-2);">
                <a href="https://sarvwigyan.github.io/" class="header-brand" aria-label="सर्वविज्ञान मुख्य पृष्ठ">
                    <img src="../Resources/ganesh.svg" alt="गणपति प्रतीक" class="logo-img">
                    <span class="brand-title" lang="hi">सर्वविज्ञान</span>
                </a>
                <span class="breadcrumb-separator" aria-hidden="true">›</span>
                <a href="../index.html" class="site-tag" lang="hi">सर्वपीडिया</a>
            </div>

            <div class="header-actions">
                <a href="../index.html" class="btn btn-ghost btn-sm" aria-label="खोज" lang="hi">
                    <i class="fas fa-magnifying-glass" aria-hidden="true"></i>
                    <span class="search-trigger-text" lang="hi">खोजें...</span>
                </a>

                <div class="lang-switcher" role="group" aria-label="भाषा">
                    <button type="button" class="lang-btn is-active" data-lang="hi" aria-pressed="true" lang="hi">हि</button>
                    <button type="button" class="lang-btn" data-lang="en" aria-pressed="false" lang="en">EN</button>
                </div>

                <button class="theme-toggle" id="themeToggle" type="button" aria-label="रूप बदलें" title="रूप बदलें">
                    <i class="fas fa-moon theme-icon-moon" aria-hidden="true"></i>
                    <i class="fas fa-sun theme-icon-sun" aria-hidden="true"></i>
                </button>
            </div>
        </div>
    </header>

    <!-- ═══════════════════ MAIN ARTICLE ═══════════════════ -->
    <main class="article-container">
        <!-- Breadcrumb -->
        <nav class="breadcrumb" aria-label="पथ" lang="hi">
            <a href="../index.html" lang="hi">सर्वपीडिया</a>
            <span class="breadcrumb-separator" aria-hidden="true">›</span>
            <a href="Elements.html" lang="hi">तत्व विज्ञान</a>
            <span class="breadcrumb-separator" aria-hidden="true">›</span>
            <span class="breadcrumb-current" lang="hi">$elemHi <span lang="en" class="term">($elemEn)</span></span>
        </nav>

        <div class="article-layout">
            <!-- Sidebar: Table of Contents -->
            <aside class="article-sidebar">
                <details class="toc-mobile" open>
                    <summary lang="hi">विषय-सूची (अनुक्रम)</summary>
                    <div class="toc-inner">
                        <nav class="toc toc-sticky" aria-label="विषय-सूची">
                            <h3 class="toc-title" lang="hi">
                                <i class="fas fa-list-ul" aria-hidden="true"></i>
                                सामग्री
                            </h3>
                            <ul class="toc-list">
$tocItems
                            </ul>
                        </nav>
                    </div>
                </details>
            </aside>

            <!-- Article Main Body -->
            <article class="article-main">
                <header class="article-header">
                    <h1 lang="hi">
                        $elemHi
                        <span lang="en" class="term">($elemEn)</span>
                    </h1>
                    <p class="lead" lang="hi">
                        $leadText
                    </p>
                </header>

                <div class="article-content">
$bodyHtml
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
                                    सर्वविज्ञान रसायन विज्ञान प्रभाग, <span lang="en" class="term">"तत्व ज्ञानकोश — $elemHi"</span>, २०२६।
                                    <a href="#properties" class="footnote-back" aria-label="वापस ऊपर जाएँ"><i class="fas fa-arrow-up" aria-hidden="true"></i></a>
                                </span>
                            </li>
                        </ol>
                    </section>
                </div>
            </article>

            <!-- Infobox Side Panel -->
            <aside class="infobox infobox-aside" role="complementary" aria-label="$elemHi सार-संक्षेप">
                <div class="infobox-header">
                    <h3 class="infobox-title" lang="hi">$elemHi</h3>
                    <div class="infobox-subtitle" lang="en">$elemEn</div>
                </div>
                <table class="infobox-table">
                    <tbody>
$infoboxRows
                    </tbody>
                </table>
            </aside>
        </div>
    </main>

    <!-- ═══════════════════ ECOSYSTEM FOOTER ═══════════════════ -->
    <footer class="site-footer">
        <div class="footer-inner">
            <div class="footer-status" lang="hi">
                <span class="footer-status-indicator" aria-hidden="true"></span>
                सभी प्रणालियाँ सक्रिय · <span lang="en" class="term mono">build v3.4</span>
            </div>

            <p class="footer-copyright" lang="hi">© २०२६ सर्वविज्ञान</p>

            <nav class="footer-links" aria-label="पादलेख नेविगेशन">
                <a href="https://sarvwigyan.github.io/" lang="hi">मुख्य पृष्ठ</a>
                <span class="breadcrumb-separator" aria-hidden="true">·</span>
                <a href="../index.html" lang="hi">सर्वपीडिया</a>
                <span class="breadcrumb-separator" aria-hidden="true">·</span>
                <a href="https://sarvwigyan.github.io/sarvstore/" lang="hi">कोष</a>
                <span class="breadcrumb-separator" aria-hidden="true">·</span>
                <a href="https://sarvwigyan.github.io/feedback.html" lang="hi">प्रतिक्रिया</a>
                <span class="breadcrumb-separator" aria-hidden="true">·</span>
                <a href="https://sarvwigyan.github.io/privacy-policy.html" lang="hi">गोपनीयता</a>
                <span class="breadcrumb-separator" aria-hidden="true">·</span>
                <a href="https://sarvwigyan.github.io/Community/community.html" lang="hi">संघ</a>
            </nav>
        </div>
    </footer>

    <script src="../js/i18n.js"></script>
    <script src="../js/lang-switcher.js"></script>
</body>
</html>
"@

    [System.IO.File]::WriteAllText($FilePath, $newHtml, [System.Text.Encoding]::UTF8)
    Write-Host "Migrated: $fileName"
}

# Run across all element files in Elements directory (skipping Hydrogen)
$files = Get-ChildItem -Path "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia\Elements\*_sarvpedia.html" | Where-Object { $_.Name -ne 'Hydrogen_sarvpedia.html' }
$count = 0

foreach ($f in $files) {
    try {
        Convert-ElementFile -FilePath $f.FullName
        $count++
    } catch {
        Write-Error "Failed to convert $($f.Name): $_"
    }
}

Write-Host "Total elements successfully migrated: $count"
