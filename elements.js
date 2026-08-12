const elementsData = [
    {
        "title": "Actinium(Elements)",
        "link": "Elements/Actinium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive metal in the actinide series, used in research."
    },
    {
        "title": "Aluminium(Elements)",
        "link": "Elements/Aluminium_sarvpedia.html",
        "tags": ["metal", "light", "common", "aluminum"],
        "description": "A lightweight, durable metal, widely used in construction and packaging."
    },
    {
        "title": "Americium(Elements)",
        "link": "Elements/Americium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A synthetic radioactive metal, used in smoke detectors."
    },
    {
        "title": "Antimony(Elements)",
        "link": "Elements/Antimony_sarvpedia.html",
        "tags": ["metalloid", "brittle"],
        "description": "A brittle metalloid, used in alloys and flame retardants."
    },
    {
        "title": "Argon(Elements)",
        "link": "Elements/Argon_sarvpedia.html",
        "tags": ["gas", "noble", "inert"],
        "description": "An inert noble gas, used in lighting and welding."
    },
    {
        "title": "Arsenic(Elements)",
        "link": "Elements/Arsenic_sarvpedia.html",
        "tags": ["metalloid", "toxic", "poison"],
        "description": "A toxic metalloid, historically used as a poison."
    },
    {
        "title": "Astatine(Elements)",
        "link": "Elements/Astatine_sarvpedia.html",
        "tags": ["halogen", "radioactive", "rare"],
        "description": "A rare, radioactive halogen, with limited applications."
    },
    {
        "title": "Barium(Elements)",
        "link": "Elements/Barium_sarvpedia.html",
        "tags": ["metal", "alkaline", "reactive"],
        "description": "A reactive alkaline earth metal, used in medical imaging."
    },
    {
        "title": "Berkelium(Elements)",
        "link": "Elements/Berkelium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A synthetic radioactive actinide, used in scientific studies."
    },
    {
        "title": "Beryllium(Elements)",
        "link": "Elements/Beryllium_sarvpedia.html",
        "tags": ["metal", "light", "toxic"],
        "description": "A light, toxic metal, used in aerospace and nuclear industries."
    },
    {
        "title": "Bismuth(Elements)",
        "link": "Elements/Bismuth_sarvpedia.html",
        "tags": ["metal", "heavy", "brittle"],
        "description": "A heavy, brittle metal, used in cosmetics and medicine."
    },
    {
        "title": "Bohrium(Elements)",
        "link": "Elements/Bohrium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, studied in labs."
    },
    {
        "title": "Boron(Elements)",
        "link": "Elements/Boron_sarvpedia.html",
        "tags": ["metalloid", "hard"],
        "description": "A hard metalloid, essential for plant growth and used in glass."
    },
    {
        "title": "Bromine(Elements)",
        "link": "Elements/Bromine_sarvpedia.html",
        "tags": ["halogen", "liquid", "toxic"],
        "description": "A toxic liquid halogen, used in disinfectants and flame retardants."
    },
    {
        "title": "Cadmium(Elements)",
        "link": "Elements/Cadmium_sarvpedia.html",
        "tags": ["metal", "toxic", "soft"],
        "description": "A soft, toxic metal, used in batteries and pigments."
    },
    {
        "title": "Caesium(Elements)",
        "link": "Elements/Caesium_sarvpedia.html",
        "tags": ["metal", "alkali", "reactive", "cesium"],
        "description": "A highly reactive alkali metal, used in atomic clocks."
    },
    {
        "title": "Calcium(Elements)",
        "link": "Elements/Calcium_sarvpedia.html",
        "tags": ["metal", "alkaline", "essential", "bone"],
        "description": "An essential alkaline metal, vital for bones and teeth."
    },
    {
        "title": "Californium(Elements)",
        "link": "Elements/Californium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, used in neutron sources."
    },
    {
        "title": "Carbon(Elements)",
        "link": "Elements/Carbon_sarvpedia.html",
        "tags": ["nonmetal", "essential", "versatile", "life"],
        "description": "A versatile nonmetal, the basis of life and materials like graphite."
    },
    {
        "title": "Cerium(Elements)",
        "link": "Elements/Cerium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "reactive"],
        "description": "A reactive lanthanide, used in catalysts and polishing."
    },
    {
        "title": "Chlorine(Elements)",
        "link": "Elements/Chlorine_sarvpedia.html",
        "tags": ["halogen", "gas", "toxic", "disinfectant"],
        "description": "A toxic gas halogen, widely used as a disinfectant."
    },
    {
        "title": "Chromium(Elements)",
        "link": "Elements/Chromium_sarvpedia.html",
        "tags": ["metal", "transition", "hard", "shiny"],
        "description": "A hard, shiny transition metal, used in stainless steel."
    },
    {
        "title": "Cobalt(Elements)",
        "link": "Elements/Cobalt_sarvpedia.html",
        "tags": ["metal", "transition", "magnetic"],
        "description": "A magnetic transition metal, used in alloys and batteries."
    },
    {
        "title": "Copernicium(Elements)",
        "link": "Elements/Copernicium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, studied in research."
    },
    {
        "title": "Copper(Elements)",
        "link": "Elements/Copper_sarvpedia.html",
        "tags": ["metal", "transition", "conductive", "wire"],
        "description": "A conductive transition metal, used in wiring and electronics."
    },
    {
        "title": "Curium(Elements)",
        "link": "Elements/Curium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, used in space research."
    },
    {
        "title": "Darmstadtium(Elements)",
        "link": "Elements/Darmstadtium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, produced in labs."
    },
    {
        "title": "Dubnium(Elements)",
        "link": "Elements/Dubnium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, used in scientific studies."
    },
    {
        "title": "Dysprosium(Elements)",
        "link": "Elements/Dysprosium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "magnetic"],
        "description": "A magnetic lanthanide, used in magnets and lasers."
    },
    {
        "title": "Einsteinium(Elements)",
        "link": "Elements/Einsteinium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, studied in labs."
    },
    {
        "title": "Elements",
        "link": "Elements/Elements.html",
        "tags": ["general", "periodic", "chemistry"],
        "description": "Overview of the periodic table and chemical elements."
    },
    {
        "title": "Erbium(Elements)",
        "link": "Elements/Erbium_sarvpedia.html",
        "tags": ["metal", "lanthanide"],
        "description": "A lanthanide, used in fiber optics and lasers."
    },
    {
        "title": "Europium(Elements)",
        "link": "Elements/Europium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "reactive"],
        "description": "A reactive lanthanide, used in phosphors and lighting."
    },
    {
        "title": "Fermium(Elements)",
        "link": "Elements/Fermium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, synthesized for research."
    },
    {
        "title": "Flerovium(Elements)",
        "link": "Elements/Flerovium_sarvpedia.html",
        "tags": ["synthetic", "metal"],
        "description": "A synthetic metal, studied in laboratories."
    },
    {
        "title": "Fluorine(Elements)",
        "link": "Elements/Fluorine_sarvpedia.html",
        "tags": ["halogen", "gas", "reactive"],
        "description": "A highly reactive gas halogen, used in toothpaste."
    },
    {
        "title": "Francium(Elements)",
        "link": "Elements/Francium_sarvpedia.html",
        "tags": ["metal", "alkali", "radioactive"],
        "description": "A rare, radioactive alkali metal, highly unstable."
    },
    {
        "title": "Gadolinium(Elements)",
        "link": "Elements/Gadolinium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "magnetic"],
        "description": "A magnetic lanthanide, used in MRI contrast agents."
    },
    {
        "title": "Gallium(Elements)",
        "link": "Elements/Gallium_sarvpedia.html",
        "tags": ["metal", "soft", "liquid"],
        "description": "A soft metal, melts near room temperature, used in semiconductors."
    },
    {
        "title": "Germanium(Elements)",
        "link": "Elements/Germanium_sarvpedia.html",
        "tags": ["metalloid", "semiconductor"],
        "description": "A metalloid, used in semiconductors and optics."
    },
    {
        "title": "Gold(Elements)",
        "link": "Elements/Gold_sarvpedia.html",
        "tags": ["metal", "transition", "precious", "jewelry"],
        "description": "A precious transition metal, used in jewelry and electronics."
    },
    {
        "title": "Hafnium(Elements)",
        "link": "Elements/Hafnium_sarvpedia.html",
        "tags": ["metal", "transition", "resistant"],
        "description": "A resistant transition metal, used in nuclear reactors."
    },
    {
        "title": "Hassium(Elements)",
        "link": "Elements/Hassium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, studied in labs."
    },
    {
        "title": "Helium(Elements)",
        "link": "Elements/Helium_sarvpedia.html",
        "tags": ["gas", "noble", "light", "balloon"],
        "description": "A light noble gas, used in balloons and cooling."
    },
    {
        "title": "Holmium(Elements)",
        "link": "Elements/Holmium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "magnetic"],
        "description": "A magnetic lanthanide, used in magnets and lasers."
    },
    {
        "title": "Hydrogen(Elements)",
        "link": "Elements/Hydrogen_sarvpedia.html",
        "tags": ["gas", "nonmetal", "abundant", "fuel"],
        "description": "An abundant nonmetal gas, potential clean fuel."
    },
    {
        "title": "Indium(Elements)",
        "link": "Elements/Indium_sarvpedia.html",
        "tags": ["metal", "soft"],
        "description": "A soft metal, used in electronics and touchscreens."
    },
    {
        "title": "Iodine(Elements)",
        "link": "Elements/Iodine_sarvpedia.html",
        "tags": ["halogen", "solid", "essential", "thyroid"],
        "description": "An essential halogen, vital for thyroid function."
    },
    {
        "title": "Iridium(Elements)",
        "link": "Elements/Iridium_sarvpedia.html",
        "tags": ["metal", "transition", "dense"],
        "description": "A dense transition metal, used in spark plugs."
    },
    {
        "title": "Iron(Elements)",
        "link": "Elements/Iron_sarvpedia.html",
        "tags": ["metal", "transition", "magnetic", "steel"],
        "description": "A hard, magnetic transition metal, key in steel production."
    },
    {
        "title": "Krypton(Elements)",
        "link": "Elements/Krypton_sarvpedia.html",
        "tags": ["gas", "noble", "inert"],
        "description": "An inert noble gas, used in lighting and photography."
    },
    {
        "title": "Lanthanum(Elements)",
        "link": "Elements/Lanthanum_sarvpedia.html",
        "tags": ["metal", "lanthanide"],
        "description": "A lanthanide, used in catalysts and optics."
    },
    {
        "title": "Lawrencium(Elements)",
        "link": "Elements/Lawrencium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, studied in research."
    },
    {
        "title": "Lead(Elements)",
        "link": "Elements/Lead_sarvpedia.html",
        "tags": ["metal", "heavy", "toxic"],
        "description": "A heavy, toxic metal, used in batteries and shielding."
    },
    {
        "title": "Lithium(Elements)",
        "link": "Elements/Lithium_sarvpedia.html",
        "tags": ["metal", "alkali", "light", "battery"],
        "description": "A light alkali metal, used in batteries."
    },
    {
        "title": "Livermorium(Elements)",
        "link": "Elements/Livermorium_sarvpedia.html",
        "tags": ["synthetic", "metal"],
        "description": "A synthetic metal, studied in labs."
    },
    {
        "title": "Lutetium(Elements)",
        "link": "Elements/Lutetium_sarvpedia.html",
        "tags": ["metal", "lanthanide"],
        "description": "A lanthanide, used in catalysts and medical imaging."
    },
    {
        "title": "Magnesium(Elements)",
        "link": "Elements/Magnesium_sarvpedia.html",
        "tags": ["metal", "alkaline", "light"],
        "description": "A light alkaline metal, used in alloys and medicine."
    },
    {
        "title": "Manganese(Elements)",
        "link": "Elements/Manganese_sarvpedia.html",
        "tags": ["metal", "transition", "hard"],
        "description": "A hard transition metal, used in steel production."
    },
    {
        "title": "Meitnerium(Elements)",
        "link": "Elements/Meitnerium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, studied in labs."
    },
    {
        "title": "Mendelevium(Elements)",
        "link": "Elements/Mendelevium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, used in research."
    },
    {
        "title": "Mercury(Elements)",
        "link": "Elements/Mercury_sarvpedia.html",
        "tags": ["metal", "liquid", "toxic", "thermometer"],
        "description": "A toxic liquid metal, used in thermometers."
    },
    {
        "title": "Molybdenum(Elements)",
        "link": "Elements/Molybdenum_sarvpedia.html",
        "tags": ["metal", "transition", "hard"],
        "description": "A hard transition metal, used in alloys."
    },
    {
        "title": "Moscovium(Elements)",
        "link": "Elements/Moscovium_sarvpedia.html",
        "tags": ["synthetic", "metal"],
        "description": "A synthetic metal, studied in labs."
    },
    {
        "title": "Neodymium(Elements)",
        "link": "Elements/Neodymium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "magnetic"],
        "description": "A magnetic lanthanide, used in strong magnets."
    },
    {
        "title": "Neon(Elements)",
        "link": "Elements/Neon_sarvpedia.html",
        "tags": ["gas", "noble", "inert", "lights"],
        "description": "An inert noble gas, used in neon lights."
    },
    {
        "title": "Neptunium(Elements)",
        "link": "Elements/Neptunium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, used in research."
    },
    {
        "title": "Nickel(Elements)",
        "link": "Elements/Nickel_sarvpedia.html",
        "tags": ["metal", "transition", "magnetic"],
        "description": "A magnetic transition metal, used in coins and alloys."
    },
    {
        "title": "Nihonium(Elements)",
        "link": "Elements/Nihonium_sarvpedia.html",
        "tags": ["synthetic", "metal"],
        "description": "A synthetic metal, studied in labs."
    },
    {
        "title": "Niobium(Elements)",
        "link": "Elements/Niobium_sarvpedia.html",
        "tags": ["metal", "transition", "resistant"],
        "description": "A resistant transition metal, used in alloys."
    },
    {
        "title": "Nitrogen(Elements)",
        "link": "Elements/Nitrogen_sarvpedia.html",
        "tags": ["gas", "nonmetal", "abundant", "air"],
        "description": "An abundant nonmetal gas, major component of air."
    },
    {
        "title": "Nobelium(Elements)",
        "link": "Elements/Nobelium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, studied in labs."
    },
    {
        "title": "Oganesson(Elements)",
        "link": "Elements/Oganesson_sarvpedia.html",
        "tags": ["synthetic", "gas", "noble"],
        "description": "A synthetic noble gas, highly unstable."
    },
    {
        "title": "Osmium(Elements)",
        "link": "Elements/Osmium_sarvpedia.html",
        "tags": ["metal", "transition", "dense"],
        "description": "A dense transition metal, used in alloys."
    },
    {
        "title": "Oxygen(Elements)",
        "link": "Elements/Oxygen_sarvpedia.html",
        "tags": ["gas", "nonmetal", "essential", "breath"],
        "description": "An essential nonmetal gas, vital for breathing."
    },
    {
        "title": "Palladium(Elements)",
        "link": "Elements/Palladium_sarvpedia.html",
        "tags": ["metal", "transition", "precious"],
        "description": "A precious transition metal, used in catalytic converters."
    },
    {
        "title": "Phosphorus(Elements)",
        "link": "Elements/Phosphorus_sarvpedia.html",
        "tags": ["nonmetal", "reactive", "essential"],
        "description": "A reactive nonmetal, essential for DNA and bones."
    },
    {
        "title": "Platinum(Elements)",
        "link": "Elements/Platinum_sarvpedia.html",
        "tags": ["metal", "transition", "precious"],
        "description": "A precious transition metal, used in jewelry and catalysts."
    },
    {
        "title": "Plutonium(Elements)",
        "link": "Elements/Plutonium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide", "nuclear"],
        "description": "A radioactive actinide, used in nuclear reactors."
    },
    {
        "title": "Polonium(Elements)",
        "link": "Elements/Polonium_sarvpedia.html",
        "tags": ["metalloid", "radioactive"],
        "description": "A radioactive metalloid, highly toxic."
    },
    {
        "title": "Potassium(Elements)",
        "link": "Elements/Potassium_sarvpedia.html",
        "tags": ["metal", "alkali", "essential"],
        "description": "An essential alkali metal, vital for cell function."
    },
    {
        "title": "Praseodymium(Elements)",
        "link": "Elements/Praseodymium_sarvpedia.html",
        "tags": ["metal", "lanthanide"],
        "description": "A lanthanide, used in magnets and glass coloring."
    },
    {
        "title": "Promethium(Elements)",
        "link": "Elements/Promethium_sarvpedia.html",
        "tags": ["radioactive", "metal", "lanthanide"],
        "description": "A radioactive lanthanide, used in glow-in-the-dark materials."
    },
    {
        "title": "Protactinium(Elements)",
        "link": "Elements/Protactinium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, rare and unstable."
    },
    {
        "title": "Radium(Elements)",
        "link": "Elements/Radium_sarvpedia.html",
        "tags": ["metal", "alkaline", "radioactive"],
        "description": "A radioactive alkaline metal, used in early medicine."
    },
    {
        "title": "Radon(Elements)",
        "link": "Elements/Radon_sarvpedia.html",
        "tags": ["gas", "noble", "radioactive"],
        "description": "A radioactive noble gas, a health hazard indoors."
    },
    {
        "title": "Rhenium(Elements)",
        "link": "Elements/Rhenium_sarvpedia.html",
        "tags": ["metal", "transition", "rare"],
        "description": "A rare transition metal, used in high-temperature alloys."
    },
    {
        "title": "Rhodium(Elements)",
        "link": "Elements/Rhodium_sarvpedia.html",
        "tags": ["metal", "transition", "precious"],
        "description": "A precious transition metal, used in catalytic converters."
    },
    {
        "title": "Roentgenium(Elements)",
        "link": "Elements/Roentgenium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, studied in labs."
    },
    {
        "title": "Rubidium(Elements)",
        "link": "Elements/Rubidium_sarvpedia.html",
        "tags": ["metal", "alkali", "reactive"],
        "description": "A reactive alkali metal, used in research and clocks."
    },
    {
        "title": "Ruthenium(Elements)",
        "link": "Elements/Ruthenium_sarvpedia.html",
        "tags": ["metal", "transition", "hard"],
        "description": "A hard transition metal, used in electronics and alloys."
    },
    {
        "title": "Rutherfordium(Elements)",
        "link": "Elements/Rutherfordium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, studied in labs."
    },
    {
        "title": "Samarium(Elements)",
        "link": "Elements/Samarium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "magnetic"],
        "description": "A magnetic lanthanide, used in magnets and cancer treatment."
    },
    {
        "title": "Scandium(Elements)",
        "link": "Elements/Scandium_sarvpedia.html",
        "tags": ["metal", "transition", "rare"],
        "description": "A rare transition metal, used in aerospace alloys."
    },
    {
        "title": "Seaborgium(Elements)",
        "link": "Elements/Seaborgium_sarvpedia.html",
        "tags": ["synthetic", "metal", "transition"],
        "description": "A synthetic transition metal, studied in labs."
    },
    {
        "title": "Selenium(Elements)",
        "link": "Elements/Selenium_sarvpedia.html",
        "tags": ["nonmetal", "essential"],
        "description": "An essential nonmetal, used in electronics and health."
    },
    {
        "title": "Silicon(Elements)",
        "link": "Elements/Silicon_sarvpedia.html",
        "tags": ["metalloid", "semiconductor", "chip"],
        "description": "A metalloid, key for semiconductors and computer chips."
    },
    {
        "title": "Silver(Elements)",
        "link": "Elements/Silver_sarvpedia.html",
        "tags": ["metal", "transition", "precious", "jewelry"],
        "description": "A precious transition metal, used in jewelry and coins."
    },
    {
        "title": "Sodium(Elements)",
        "link": "Elements/Sodium_sarvpedia.html",
        "tags": ["metal", "alkali", "essential", "salt"],
        "description": "An essential alkali metal, found in table salt."
    },
    {
        "title": "Strontium(Elements)",
        "link": "Elements/Strontium_sarvpedia.html",
        "tags": ["metal", "alkaline"],
        "description": "An alkaline earth metal, used in fireworks and medicine."
    },
    {
        "title": "Sulfur(Elements)",
        "link": "Elements/Sulfur_sarvpedia.html",
        "tags": ["nonmetal", "reactive", "yellow"],
        "description": "A reactive, yellow nonmetal, used in fertilizers."
    },
    {
        "title": "Tantalum(Elements)",
        "link": "Elements/Tantalum_sarvpedia.html",
        "tags": ["metal", "transition", "resistant"],
        "description": "A resistant transition metal, used in electronics."
    },
    {
        "title": "Technetium(Elements)",
        "link": "Elements/Technetium_sarvpedia.html",
        "tags": ["radioactive", "metal", "transition"],
        "description": "A radioactive transition metal, used in medical imaging."
    },
    {
        "title": "Tellurium(Elements)",
        "link": "Elements/Tellurium_sarvpedia.html",
        "tags": ["metalloid", "brittle"],
        "description": "A brittle metalloid, used in solar cells and alloys."
    },
    {
        "title": "Tennessine(Elements)",
        "link": "Elements/Tennessine_sarvpedia.html",
        "tags": ["synthetic", "halogen"],
        "description": "A synthetic halogen, highly unstable."
    },
    {
        "title": "Terbium(Elements)",
        "link": "Elements/Terbium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "magnetic"],
        "description": "A magnetic lanthanide, used in phosphors and magnets."
    },
    {
        "title": "Thallium(Elements)",
        "link": "Elements/Thallium_sarvpedia.html",
        "tags": ["metal", "toxic"],
        "description": "A toxic metal, used in electronics and research."
    },
    {
        "title": "Thorium(Elements)",
        "link": "Elements/Thorium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide"],
        "description": "A radioactive actinide, potential nuclear fuel."
    },
    {
        "title": "Thulium(Elements)",
        "link": "Elements/Thulium_sarvpedia.html",
        "tags": ["metal", "lanthanide", "rare"],
        "description": "A rare lanthanide, used in lasers and imaging."
    },
    {
        "title": "Tin(Elements)",
        "link": "Elements/Tin_sarvpedia.html",
        "tags": ["metal", "soft"],
        "description": "A soft metal, used in solder and coatings."
    },
    {
        "title": "Titanium(Elements)",
        "link": "Elements/Titanium_sarvpedia.html",
        "tags": ["metal", "transition", "strong"],
        "description": "A strong transition metal, used in aerospace and implants."
    },
    {
        "title": "Tungsten(Elements)",
        "link": "Elements/Tungsten_sarvpedia.html",
        "tags": ["metal", "transition", "dense", "hard"],
        "description": "A dense, hard transition metal, used in bulbs and alloys."
    },
    {
        "title": "Uranium(Elements)",
        "link": "Elements/Uranium_sarvpedia.html",
        "tags": ["radioactive", "metal", "actinide", "nuclear"],
        "description": "A radioactive actinide, used in nuclear power."
    },
    {
        "title": "Vanadium(Elements)",
        "link": "Elements/Vanadium_sarvpedia.html",
        "tags": ["metal", "transition", "hard"],
        "description": "A hard transition metal, used in steel alloys."
    },
    {
        "title": "Xenon(Elements)",
        "link": "Elements/Xenon_sarvpedia.html",
        "tags": ["gas", "noble", "inert"],
        "description": "An inert noble gas, used in lighting and anesthesia."
    },
    {
        "title": "Ytterbium(Elements)",
        "link": "Elements/Ytterbium_sarvpedia.html",
        "tags": ["metal", "lanthanide"],
        "description": "A lanthanide, used in lasers and alloys."
    },
    {
        "title": "Yttrium(Elements)",
        "link": "Elements/Yttrium_sarvpedia.html",
        "tags": ["metal", "transition", "rare"],
        "description": "A rare transition metal, used in LEDs and phosphors."
    },
    {
        "title": "Zinc(Elements)",
        "link": "Elements/Zinc_sarvpedia.html",
        "tags": ["metal", "transition", "essential"],
        "description": "An essential transition metal, used in galvanizing."
    },
    {
        "title": "Zirconium(Elements)",
        "link": "Elements/Zirconium_sarvpedia.html",
        "tags": ["metal", "transition", "resistant"],
        "description": "A resistant transition metal, used in nuclear reactors."
    }
];