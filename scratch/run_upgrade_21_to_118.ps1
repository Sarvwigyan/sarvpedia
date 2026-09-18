# ==============================================================================
# Script: run_upgrade_21_to_118.ps1
# Overhauls Elements 21 (Scandium) through 118 (Oganesson) to the full
# Sarvpedia / Sarvwigyan standard matching Hydrogen and Carbon.
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$meta = @{
    21 = @{ en="Scandium"; hi="स्कैंडियम"; sym="Sc"; w="44.956"; g="3"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d¹ 4s²" }
    22 = @{ en="Titanium"; hi="टाइटेनियम"; sym="Ti"; w="47.867"; g="4"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d² 4s²" }
    23 = @{ en="Vanadium"; hi="वैनेडियम"; sym="V"; w="50.942"; g="5"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d³ 4s²" }
    24 = @{ en="Chromium"; hi="क्रोमियम"; sym="Cr"; w="51.996"; g="6"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d⁵ 4s¹" }
    25 = @{ en="Manganese"; hi="मैंगनीज"; sym="Mn"; w="54.938"; g="7"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d⁵ 4s²" }
    26 = @{ en="Iron"; hi="लोहा (आयरन)"; sym="Fe"; w="55.845"; g="8"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d⁶ 4s²" }
    27 = @{ en="Cobalt"; hi="कोबाल्ट"; sym="Co"; w="58.933"; g="9"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d⁷ 4s²" }
    28 = @{ en="Nickel"; hi="निकल"; sym="Ni"; w="58.693"; g="10"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d⁸ 4s²" }
    29 = @{ en="Copper"; hi="ताँबा (कॉपर)"; sym="Cu"; w="63.546"; g="11"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d¹⁰ 4s¹" }
    30 = @{ en="Zinc"; hi="जस्ता (जिंक)"; sym="Zn"; w="65.38"; g="12"; p="4"; cat="संक्रमण धातु"; cfg="[Ar] 3d¹⁰ 4s²" }
    31 = @{ en="Gallium"; hi="गैलियम"; sym="Ga"; w="69.723"; g="13"; p="4"; cat="संक्रमणोत्तर धातु"; cfg="[Ar] 3d¹⁰ 4s² 4p¹" }
    32 = @{ en="Germanium"; hi="जर्मेनियम"; sym="Ge"; w="72.630"; g="14"; p="4"; cat="उपधातु"; cfg="[Ar] 3d¹⁰ 4s² 4p²" }
    33 = @{ en="Arsenic"; hi="आर्सेनिक"; sym="As"; w="74.922"; g="15"; p="4"; cat="उपधातु"; cfg="[Ar] 3d¹⁰ 4s² 4p³" }
    34 = @{ en="Selenium"; hi="सेलेनियम"; sym="Se"; w="78.971"; g="16"; p="4"; cat="अधातु"; cfg="[Ar] 3d¹⁰ 4s² 4p⁴" }
    35 = @{ en="Bromine"; hi="ब्रोमीन"; sym="Br"; w="79.904"; g="17"; p="4"; cat="हैलोजन"; cfg="[Ar] 3d¹⁰ 4s² 4p⁵" }
    36 = @{ en="Krypton"; hi="क्रिप्टन"; sym="Kr"; w="83.798"; g="18"; p="4"; cat="अक्रिय गैस"; cfg="[Ar] 3d¹⁰ 4s² 4p⁶" }
    37 = @{ en="Rubidium"; hi="रुबिडियम"; sym="Rb"; w="85.468"; g="1"; p="5"; cat="क्षार धातु"; cfg="[Kr] 5s¹" }
    38 = @{ en="Strontium"; hi="स्ट्रोंटियम"; sym="Sr"; w="87.62"; g="2"; p="5"; cat="क्षारीय मृदा धातु"; cfg="[Kr] 5s²" }
    39 = @{ en="Yttrium"; hi="इट्रियम"; sym="Y"; w="88.906"; g="3"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d¹ 5s²" }
    40 = @{ en="Zirconium"; hi="जिरकोनियम"; sym="Zr"; w="91.224"; g="4"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d² 5s²" }
    41 = @{ en="Niobium"; hi="नायोबियम"; sym="Nb"; w="92.906"; g="5"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d⁴ 5s¹" }
    42 = @{ en="Molybdenum"; hi="मोलिब्डेनम"; sym="Mo"; w="95.95"; g="6"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d⁵ 5s¹" }
    43 = @{ en="Technetium"; hi="टेक्नेशियम"; sym="Tc"; w="98"; g="7"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d⁵ 5s²" }
    44 = @{ en="Ruthenium"; hi="रुथेनियम"; sym="Ru"; w="101.07"; g="8"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d⁷ 5s¹" }
    45 = @{ en="Rhodium"; hi="रोडियम"; sym="Rh"; w="102.91"; g="9"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d⁸ 5s¹" }
    46 = @{ en="Palladium"; hi="पैलेडियम"; sym="Pd"; w="106.42"; g="10"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d¹⁰" }
    47 = @{ en="Silver"; hi="चाँदी (रजत)"; sym="Ag"; w="107.87"; g="11"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d¹⁰ 5s¹" }
    48 = @{ en="Cadmium"; hi="कैडमियम"; sym="Cd"; w="112.41"; g="12"; p="5"; cat="संक्रमण धातु"; cfg="[Kr] 4d¹⁰ 5s²" }
    49 = @{ en="Indium"; hi="इंडियम"; sym="In"; w="114.82"; g="13"; p="5"; cat="संक्रमणोत्तर धातु"; cfg="[Kr] 4d¹⁰ 5s² 5p¹" }
    50 = @{ en="Tin"; hi="टिन (रांगा)"; sym="Sn"; w="118.71"; g="14"; p="5"; cat="संक्रमणोत्तर धातु"; cfg="[Kr] 4d¹⁰ 5s² 5p²" }
    51 = @{ en="Antimony"; hi="एंटीमनी"; sym="Sb"; w="121.76"; g="15"; p="5"; cat="उपधातु"; cfg="[Kr] 4d¹⁰ 5s² 5p³" }
    52 = @{ en="Tellurium"; hi="टेल्यूरियम"; sym="Te"; w="127.60"; g="16"; p="5"; cat="उपधातु"; cfg="[Kr] 4d¹⁰ 5s² 5p⁴" }
    53 = @{ en="Iodine"; hi="आयोडीन"; sym="I"; w="126.90"; g="17"; p="5"; cat="हैलोजन"; cfg="[Kr] 4d¹⁰ 5s² 5p⁵" }
    54 = @{ en="Xenon"; hi="जेनान"; sym="Xe"; w="131.29"; g="18"; p="5"; cat="अक्रिय गैस"; cfg="[Kr] 4d¹⁰ 5s² 5p⁶" }
    55 = @{ en="Caesium"; hi="सीजियम"; sym="Cs"; w="132.91"; g="1"; p="6"; cat="क्षार धातु"; cfg="[Xe] 6s¹" }
    56 = @{ en="Barium"; hi="बेरियम"; sym="Ba"; w="137.33"; g="2"; p="6"; cat="क्षारीय मृदा धातु"; cfg="[Xe] 6s²" }
    57 = @{ en="Lanthanum"; hi="लैंथेनम"; sym="La"; w="138.91"; g="3"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 5d¹ 6s²" }
    58 = @{ en="Cerium"; hi="सीरियम"; sym="Ce"; w="140.12"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f¹ 5d¹ 6s²" }
    59 = @{ en="Praseodymium"; hi="प्रेजोडायमियम"; sym="Pr"; w="140.91"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f³ 6s²" }
    60 = @{ en="Neodymium"; hi="नियोडिमियम"; sym="Nd"; w="144.24"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f⁴ 6s²" }
    61 = @{ en="Promethium"; hi="प्रोमेथियम"; sym="Pm"; w="145"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f⁵ 6s²" }
    62 = @{ en="Samarium"; hi="समेरियम"; sym="Sm"; w="150.36"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f⁶ 6s²" }
    63 = @{ en="Europium"; hi="यूरोपियम"; sym="Eu"; w="151.96"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f⁷ 6s²" }
    64 = @{ en="Gadolinium"; hi="गैडोलीनियम"; sym="Gd"; w="157.25"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f⁷ 5d¹ 6s²" }
    65 = @{ en="Terbium"; hi="टर्बियम"; sym="Tb"; w="158.93"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f⁹ 6s²" }
    66 = @{ en="Dysprosium"; hi="डिस्प्रोसियम"; sym="Dy"; w="162.50"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f¹⁰ 6s²" }
    67 = @{ en="Holmium"; hi="होल्मियम"; sym="Ho"; w="164.93"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f¹¹ 6s²" }
    68 = @{ en="Erbium"; hi="एर्बियम"; sym="Er"; w="167.26"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f¹² 6s²" }
    69 = @{ en="Thulium"; hi="थ्यूलियम"; sym="Tm"; w="168.93"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f¹³ 6s²" }
    70 = @{ en="Ytterbium"; hi="इटर्बियम"; sym="Yb"; w="173.05"; g="—"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f¹⁴ 6s²" }
    71 = @{ en="Lutetium"; hi="लुटेशियम"; sym="Lu"; w="174.97"; g="3"; p="6"; cat="लैंथेनाइड"; cfg="[Xe] 4f¹⁴ 5d¹ 6s²" }
    72 = @{ en="Hafnium"; hi="हाफ्नियम"; sym="Hf"; w="178.49"; g="4"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d² 6s²" }
    73 = @{ en="Tantalum"; hi="टैंटलम"; sym="Ta"; w="180.95"; g="5"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d³ 6s²" }
    74 = @{ en="Tungsten"; hi="टंगस्टन"; sym="W"; w="183.84"; g="6"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d⁴ 6s²" }
    75 = @{ en="Rhenium"; hi="रीनियम"; sym="Re"; w="186.21"; g="7"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d⁵ 6s²" }
    76 = @{ en="Osmium"; hi="ऑस्मियम"; sym="Os"; w="190.23"; g="8"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d⁶ 6s²" }
    77 = @{ en="Iridium"; hi="इरिडियम"; sym="Ir"; w="192.22"; g="9"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d⁷ 6s²" }
    78 = @{ en="Platinum"; hi="प्लैटिनम"; sym="Pt"; w="195.08"; g="10"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d⁹ 6s¹" }
    79 = @{ en="Gold"; hi="सोना (स्वर्ण)"; sym="Au"; w="196.97"; g="11"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d¹⁰ 6s¹" }
    80 = @{ en="Mercury"; hi="पारा (मर्करी)"; sym="Hg"; w="200.59"; g="12"; p="6"; cat="संक्रमण धातु"; cfg="[Xe] 4f¹⁴ 5d¹⁰ 6s²" }
    81 = @{ en="Thallium"; hi="थैलियम"; sym="Tl"; w="204.38"; g="13"; p="6"; cat="संक्रमणोत्तर धातु"; cfg="[Xe] 4f¹⁴ 5d¹⁰ 6s² 6p¹" }
    82 = @{ en="Lead"; hi="सीसा (लेड)"; sym="Pb"; w="207.2"; g="14"; p="6"; cat="संक्रमणोत्तर धातु"; cfg="[Xe] 4f¹⁴ 5d¹⁰ 6s² 6p²" }
    83 = @{ en="Bismuth"; hi="बिस्मथ"; sym="Bi"; w="208.98"; g="15"; p="6"; cat="संक्रमणोत्तर धातु"; cfg="[Xe] 4f¹⁴ 5d¹⁰ 6s² 6p³" }
    84 = @{ en="Polonium"; hi="पोलोनियम"; sym="Po"; w="209"; g="16"; p="6"; cat="संक्रमणोत्तर धातु"; cfg="[Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁴" }
    85 = @{ en="Astatine"; hi="एस्टैटिन"; sym="At"; w="210"; g="17"; p="6"; cat="हैलोजन"; cfg="[Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁵" }
    86 = @{ en="Radon"; hi="रेडॉन"; sym="Rn"; w="222"; g="18"; p="6"; cat="अक्रिय गैस"; cfg="[Xe] 4f¹⁴ 5d¹⁰ 6s² 6p⁶" }
    87 = @{ en="Francium"; hi="फ्रैंशियम"; sym="Fr"; w="223"; g="1"; p="7"; cat="क्षार धातु"; cfg="[Rn] 7s¹" }
    88 = @{ en="Radium"; hi="रेडियम"; sym="Ra"; w="226"; g="2"; p="7"; cat="क्षारीय मृदा धातु"; cfg="[Rn] 7s²" }
    89 = @{ en="Actinium"; hi="एक्टिनियम"; sym="Ac"; w="227"; g="3"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 6d¹ 7s²" }
    90 = @{ en="Thorium"; hi="थोरियम"; sym="Th"; w="232.04"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 6d² 7s²" }
    91 = @{ en="Protactinium"; hi="प्रोटाक्टिनियम"; sym="Pa"; w="231.04"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f² 6d¹ 7s²" }
    92 = @{ en="Uranium"; hi="यूरेनियम"; sym="U"; w="238.03"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f³ 6d¹ 7s²" }
    93 = @{ en="Neptunium"; hi="नेप्च्यूनियम"; sym="Np"; w="237"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f⁴ 6d¹ 7s²" }
    94 = @{ en="Plutonium"; hi="प्लूटोनियम"; sym="Pu"; w="244"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f⁶ 7s²" }
    95 = @{ en="Americium"; hi="अमेरिकियम"; sym="Am"; w="243"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f⁷ 7s²" }
    96 = @{ en="Curium"; hi="क्यूरियम"; sym="Cm"; w="247"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f⁷ 6d¹ 7s²" }
    97 = @{ en="Berkelium"; hi="बर्केलियम"; sym="Bk"; w="247"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f⁹ 7s²" }
    98 = @{ en="Californium"; hi="कैलिफोर्नियम"; sym="Cf"; w="251"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f¹⁰ 7s²" }
    99 = @{ en="Einsteinium"; hi="आइंस्टीनियम"; sym="Es"; w="252"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f¹¹ 7s²" }
    100 = @{ en="Fermium"; hi="फर्मियम"; sym="Fm"; w="257"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f¹² 7s²" }
    101 = @{ en="Mendelevium"; hi="मेंडेलीवियम"; sym="Md"; w="258"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f¹³ 7s²" }
    102 = @{ en="Nobelium"; hi="नोबेलियम"; sym="No"; w="259"; g="—"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f¹⁴ 7s²" }
    103 = @{ en="Lawrencium"; hi="लॉरेंशियम"; sym="Lr"; w="266"; g="3"; p="7"; cat="ऐक्टिनाइड"; cfg="[Rn] 5f¹⁴ 7s² 7p¹" }
    104 = @{ en="Rutherfordium"; hi="रदरफोर्डियम"; sym="Rf"; w="267"; g="4"; p="7"; cat="संक्रमण धातु"; cfg="[Rn] 5f¹⁴ 6d² 7s²" }
    105 = @{ en="Dubnium"; hi="डब्नियम"; sym="Db"; w="268"; g="5"; p="7"; cat="संक्रमण धातु"; cfg="[Rn] 5f¹⁴ 6d³ 7s²" }
    106 = @{ en="Seaborgium"; hi="सीबोर्गियम"; sym="Sg"; w="269"; g="6"; p="7"; cat="संक्रमण धातु"; cfg="[Rn] 5f¹⁴ 6d⁴ 7s²" }
    107 = @{ en="Bohrium"; hi="बोरियम"; sym="Bh"; w="270"; g="7"; p="7"; cat="संक्रमण धातु"; cfg="[Rn] 5f¹⁴ 6d⁵ 7s²" }
    108 = @{ en="Hassium"; hi="हैसियम"; sym="Hs"; w="269"; g="8"; p="7"; cat="संक्रमण धातु"; cfg="[Rn] 5f¹⁴ 6d⁶ 7s²" }
    109 = @{ en="Meitnerium"; hi="माइटनेरियम"; sym="Mt"; w="278"; g="9"; p="7"; cat="अज्ञात तत्व"; cfg="[Rn] 5f¹⁴ 6d⁷ 7s²" }
    110 = @{ en="Darmstadtium"; hi="डार्मस्टैडियम"; sym="Ds"; w="281"; g="10"; p="7"; cat="अज्ञात तत्व"; cfg="[Rn] 5f¹⁴ 6d⁸ 7s²" }
    111 = @{ en="Roentgenium"; hi="रॉन्टगेनियम"; sym="Rg"; w="282"; g="11"; p="7"; cat="अज्ञात तत्व"; cfg="[Rn] 5f¹⁴ 6d⁹ 7s²" }
    112 = @{ en="Copernicium"; hi="कॉपरनिसियम"; sym="Cn"; w="285"; g="12"; p="7"; cat="संक्रमण धातु"; cfg="[Rn] 5f¹⁴ 6d¹⁰ 7s²" }
    113 = @{ en="Nihonium"; hi="निहोनियम"; sym="Nh"; w="286"; g="13"; p="7"; cat="संक्रमणोत्तर धातु"; cfg="[Rn] 5f¹⁴ 6d¹⁰ 7s² 7p¹" }
    114 = @{ en="Flerovium"; hi="फ्लेरोवियम"; sym="Fl"; w="289"; g="14"; p="7"; cat="संक्रमणोत्तर धातु"; cfg="[Rn] 5f¹⁴ 6d¹⁰ 7s² 7p²" }
    115 = @{ en="Moscovium"; hi="मॉस्कोवियम"; sym="Mc"; w="290"; g="15"; p="7"; cat="संक्रमणोत्तर धातु"; cfg="[Rn] 5f¹⁴ 6d¹⁰ 7s² 7p³" }
    116 = @{ en="Livermorium"; hi="लिवरमोरियम"; sym="Lv"; w="293"; g="16"; p="7"; cat="संक्रमणोत्तर धातु"; cfg="[Rn] 5f¹⁴ 6d¹⁰ 7s² 7p⁴" }
    117 = @{ en="Tennessine"; hi="टेनेसीन"; sym="Ts"; w="294"; g="17"; p="7"; cat="हैलोजन"; cfg="[Rn] 5f¹⁴ 6d¹⁰ 7s² 7p⁵" }
    118 = @{ en="Oganesson"; hi="ओगानेसन"; sym="Og"; w="294"; g="18"; p="7"; cat="अक्रिय गैस"; cfg="[Rn] 5f¹⁴ 6d¹⁰ 7s² 7p⁶" }
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

$upgradedCount = 0

for ($z = 21; $z -le 118; $z++) {
    $info = $meta[$z]
    if (-not $info) { continue }

    $en = $info.en
    $hi = $info.hi
    $sym = $info.sym
    $w = $info.w
    $group = $info.g
    $period = $info.p
    $cat = $info.cat
    $cfg = $info.cfg

    $filePath = "c:\Users\dviwe\OneDrive\Documents\Dviwedi\COMPUTATION\sarvpedia\Elements\${en}_sarvpedia.html"
    if (-not (Test-Path $filePath)) {
        Write-Warning "File not found: $filePath"
        continue
    }

    $raw = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

    # 1. Update Title
    $raw = [regex]::Replace($raw, '<title>.*?</title>', "<title>$hi ($en) — Sarvpedia | सर्वविज्ञान</title>")

    # 2. Update Meta Description
    $desc = "$hi ($en, $sym, परमाणु क्रमांक $z) — सर्वपीडिया का प्रामाणिक ज्ञानकोश लेख।"
    $raw = [regex]::Replace($raw, '<meta name="description" content=".*?">', "<meta name=`"description`" content=`"$desc`">")

    # 3. Update Schema.org JSON-LD Article
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

    # 4. Update Breadcrumb
    $bcReplace = "<span class=`"breadcrumb-current`" lang=`"hi`">$hi <span lang=`"en`" class=`"term`">($en)</span></span>"
    $raw = [regex]::Replace($raw, '<span class="breadcrumb-current"[^>]*>[\s\S]*?</span>', $bcReplace)

    # 5. Update Article Header
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

    # 6. Update Infobox Header
    $raw = [regex]::Replace($raw, '<h3 class="infobox-title"[^>]*>.*?</h3>', "<h3 class=`"infobox-title`" lang=`"hi`">$hi</h3>")
    $raw = [regex]::Replace($raw, '<div class="infobox-subtitle"[^>]*>.*?</div>', "<div class=`"infobox-subtitle`" lang=`"en`">$en · $sym · $z</div>")

    # 7. Extract and Map Infobox Properties
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

    # 8. Update References Section
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
    $upgradedCount++
}

Write-Output "Successfully upgraded $upgradedCount elements from Z=21 to Z=118."
