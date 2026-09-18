# ==============================================================================
# Script: upgrade_2_to_20.ps1
# Brings Elements 2 to 20 to the same standard.
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$meta2to20 = @{
    2  = @{ en="Helium"; hi="हीलियम"; sym="He"; w="4.0026"; g="18"; p="1"; cat="अक्रिय गैस"; cfg="1s²" }
    3  = @{ en="Lithium"; hi="लिथियम"; sym="Li"; w="6.94"; g="1"; p="2"; cat="क्षार धातु"; cfg="[He] 2s¹" }
    4  = @{ en="Beryllium"; hi="बेरिलियम"; sym="Be"; w="9.0122"; g="2"; p="2"; cat="क्षारीय मृदा धातु"; cfg="[He] 2s²" }
    5  = @{ en="Boron"; hi="बोरॉन"; sym="B"; w="10.81"; g="13"; p="2"; cat="उपधातु"; cfg="[He] 2s² 2p¹" }
    7  = @{ en="Nitrogen"; hi="नाइट्रोजन"; sym="N"; w="14.007"; g="15"; p="2"; cat="अधातु"; cfg="[He] 2s² 2p³" }
    8  = @{ en="Oxygen"; hi="ऑक्सीजन"; sym="O"; w="15.999"; g="16"; p="2"; cat="अधातु"; cfg="[He] 2s² 2p⁴" }
    9  = @{ en="Fluorine"; hi="फ्लोरीन"; sym="F"; w="18.998"; g="17"; p="2"; cat="हैलोजन"; cfg="[He] 2s² 2p⁵" }
    10 = @{ en="Neon"; hi="नियॉन"; sym="Ne"; w="20.180"; g="18"; p="2"; cat="अक्रिय गैस"; cfg="[He] 2s² 2p⁶" }
    11 = @{ en="Sodium"; hi="सोडियम"; sym="Na"; w="22.990"; g="1"; p="3"; cat="क्षार धातु"; cfg="[Ne] 3s¹" }
    12 = @{ en="Magnesium"; hi="मैग्नीशियम"; sym="Mg"; w="24.305"; g="2"; p="3"; cat="क्षारीय मृदा धातु"; cfg="[Ne] 3s²" }
    13 = @{ en="Aluminium"; hi="एल्युमिनियम"; sym="Al"; w="26.982"; g="13"; p="3"; cat="संक्रमणोत्तर धातु"; cfg="[Ne] 3s² 3p¹" }
    14 = @{ en="Silicon"; hi="सिलिकॉन"; sym="Si"; w="28.085"; g="14"; p="3"; cat="उपधातु"; cfg="[Ne] 3s² 3p²" }
    15 = @{ en="Phosphorus"; hi="फास्फोरस"; sym="P"; w="30.974"; g="15"; p="3"; cat="अधातु"; cfg="[Ne] 3s² 3p³" }
    16 = @{ en="Sulfur"; hi="गंधक (सल्फर)"; sym="S"; w="32.06"; g="16"; p="3"; cat="अधातु"; cfg="[Ne] 3s² 3p⁴" }
    17 = @{ en="Chlorine"; hi="क्लोरीन"; sym="Cl"; w="35.45"; g="17"; p="3"; cat="हैलोजन"; cfg="[Ne] 3s² 3p⁵" }
    18 = @{ en="Argon"; hi="आर्गन"; sym="Ar"; w="39.95"; g="18"; p="3"; cat="अक्रिय गैस"; cfg="[Ne] 3s² 3p⁶" }
    19 = @{ en="Potassium"; hi="पोटैशियम"; sym="K"; w="39.098"; g="1"; p="4"; cat="क्षार धातु"; cfg="[Ar] 4s¹" }
    20 = @{ en="Calcium"; hi="कैल्शियम"; sym="Ca"; w="40.078"; g="2"; p="4"; cat="क्षारीय मृदा धातु"; cfg="[Ar] 4s²" }
}

$propMap = @{
    'Atomic Number' = 'परमाणु क्रमांक'
    'Atomic Weight' = 'मानक परमाणु भार'
    'Density' = 'घनत्व'
    'Melting Point' = 'गलनांक'
    'Boiling Point' = 'क्वथनांक'
    'Electronegativity' = 'विद्युत ऋणात्मकता'
    'Ionization Energy' = 'आयनन ऊर्जा'
    'Oxidation States' = 'ऑक्सीकरण अवस्थाएँ'
    'Electron Configuration' = 'इलेक्ट्रॉन विन्यास'
    'Phase' = 'अवस्था'
    'Category' = 'श्रेणी'
    'Discovery' = 'खोजकर्ता'
    'Discoverer' = 'खोजकर्ता'
    'Crystal Structure' = 'क्रिस्टल संरचना'
    'Specific Heat' = 'विशिष्ट ऊष्मा'
    'Thermal Conductivity' = 'ऊष्मा चालकता'
}

$skipProps = @(
    'परमाणु क्रमांक', 'रासायनिक प्रतीक', 'मानक परमाणु भार', 'आवर्त / वर्ग', 'श्रेणी', 'इलेक्ट्रॉन विन्यास',
    'Atomic Number', 'Atomic Weight', 'Electron Configuration', 'Period', 'Group', 'Category', 'Symbol'
)

$upgraded = 0

foreach ($z in $meta2to20.Keys) {
    $info = $meta2to20[$z]
    $en = $info.en
    $hi = $info.hi
    $sym = $info.sym
    $w = $info.w
    $group = $info.g
    $period = $info.p
    $cat = $info.cat
    $cfg = $info.cfg

    $filePath = "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia\Elements\${en}_sarvpedia.html"
    if (-not (Test-Path $filePath)) { continue }

    $raw = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

    # Title
    $raw = [regex]::Replace($raw, '<title>.*?</title>', "<title>$hi ($en) — Sarvpedia | सर्वविज्ञान</title>")

    # Meta Description
    $desc = "$hi ($en, $sym, परमाणु क्रमांक $z) — सर्वपीडिया का प्रामाणिक ज्ञानकोश लेख।"
    $raw = [regex]::Replace($raw, '<meta name="description" content=".*?">', "<meta name=`"description`" content=`"$desc`">")

    # Schema
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
      "headline": "$hi",
      "alternativeHeadline": "$en ($sym)",
      "description": "$hi ($en, प्रतीक: $sym, परमाणु संख्या: $z) — आवर्त सारणी का रासायनिक तत्व।",
      "author": { "@type": "Person", "name": "सर्वविज्ञान" },
      "datePublished": "2026-09-18",
      "dateModified": "2026-09-18"
    }
    </script>
"@
    $raw = [regex]::Replace($raw, '<script type="application/ld\+json">[\s\S]*?</script>', $schemaJson)

    # Breadcrumb
    $bcReplace = "<span class=`"breadcrumb-current`" lang=`"hi`">$hi <span lang=`"en`" class=`"term`">($en)</span></span>"
    $raw = [regex]::Replace($raw, '<span class="breadcrumb-current"[^>]*>[\s\S]*?</span>', $bcReplace)

    # Header
    $leadText = "$hi आवर्त सारणी का एक रासायनिक तत्व है जिसका प्रतीक <span lang=`"en`" class=`"term mono`">$sym</span> तथा परमाणु क्रमांक <span lang=`"en`" class=`"term`">$z</span> है। यह आवर्त सारणी के समूह <span lang=`"en`" class=`"term`">$group</span> तथा आवर्त <span lang=`"en`" class=`"term`">$period</span> का तत्व है और <span lang=`"hi`">$cat</span> श्रेणी में आता है।"
    $artHeader = @"
<header class="article-header">
                    <h1 lang="hi">
                        $hi
                        <span lang="en" class="term">($en)</span>
                    </h1>
                    <p class="title-en" lang="en">Atomic Number: $z · Symbol: $sym</p>
                    <p class="lead" lang="hi">
                        $leadText
                    </p>
                </header>
"@
    $raw = [regex]::Replace($raw, '<header class="article-header">[\s\S]*?</header>', $artHeader)

    # Infobox Header
    $raw = [regex]::Replace($raw, '<h3 class="infobox-title"[^>]*>.*?</h3>', "<h3 class=`"infobox-title`" lang=`"hi`">$hi</h3>")
    $raw = [regex]::Replace($raw, '<div class="infobox-subtitle"[^>]*>.*?</div>', "<div class=`"infobox-subtitle`" lang=`"en`">$en · $sym · $z</div>")

    # Table Properties
    $extractedProps = [ordered]@{}
    $propMatches = [regex]::Matches($raw, '<tr[^>]*>\s*<th[^>]*>([^<]+)</th>\s*<td[^>]*>([^<]+)</td>\s*</tr>')
    foreach ($m in $propMatches) {
        $k = $m.Groups[1].Value.Trim()
        $v = $m.Groups[2].Value.Trim()
        $kHi = if ($propMap.ContainsKey($k)) { $propMap[$k] } else { $k }
        $extractedProps[$kHi] = $v
    }

    $rows = @()
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">परमाणु क्रमांक</th>`n                            <td lang=`"en`" class=`"term mono`">$z</td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">रासायनिक प्रतीक</th>`n                            <td lang=`"en`" class=`"term mono`">$sym</td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">मानक परमाणु भार</th>`n                            <td lang=`"en`" class=`"term mono`">$w u</td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">आवर्त / वर्ग</th>`n                            <td lang=`"hi`"><span lang=`"en`" class=`"term`">$period / $group</span></td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">श्रेणी</th>`n                            <td lang=`"hi`">$cat</td>`n                        </tr>"
    $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">इलेक्ट्रॉन विन्यास</th>`n                            <td lang=`"en`" class=`"term mono`">$cfg</td>`n                        </tr>"

    foreach ($k in $extractedProps.Keys) {
        if ($k -notin $skipProps) {
            $val = $extractedProps[$k]
            $rows += "<tr>`n                            <th scope=`"row`" lang=`"hi`">$k</th>`n                            <td lang=`"en`" class=`"term mono`">$val</td>`n                        </tr>"
        }
    }

    $tableInner = "<tbody>`n                        " + ($rows -join "`n                        ") + "`n                    </tbody>"
    $raw = [regex]::Replace($raw, '<tbody>[\s\S]*?</tbody>', $tableInner)

    # Footnotes
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
                                    सर्वविज्ञान रसायन विज्ञान प्रभाग, <span lang="en" class="term">"तत्व ज्ञानकोश — $hi"</span>, २०२६।
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
    $upgraded++
}

Write-Output "Successfully updated $upgraded elements (2 to 20)."
