/**
 * सर्वविज्ञान · Sarvpedia Dual-Script Search Engine · v1.0
 * Supports seamless queries in Devanagari, English, and Romanized Hindi.
 */

(function () {
  'use strict';

  // Devanagari numeral to Latin digit map
  const DEVA_DIGITS = {'०':'0','१':'1','२':'2','३':'3','४':'4','५':'5','६':'6','७':'7','८':'8','९':'9'};

  // Dual-script synonym and translation dictionary
  const BILINGUAL_MAP = {
    // Basic Scientific & Domain Terms
    'tatva': ['तत्व', 'element'],
    'element': ['तत्व', 'element'],
    'तत्व': ['element', 'tatva'],
    'dhatu': ['धातु', 'metal'],
    'metal': ['धातु', 'dhatu'],
    'धातु': ['metal', 'dhatu'],
    'gas': ['गैस', 'वायु', 'vapor'],
    'गैस': ['gas', 'vayu'],
    'adhatu': ['अधातु', 'nonmetal'],
    'nonmetal': ['अधातु', 'adhatu'],
    'अधातु': ['nonmetal', 'adhatu'],
    'nuclear': ['नाभिकीय', 'परमाणु', 'radioactive'],
    'radioactive': ['रेडियोधर्मी', 'radioactive'],
    'रेडियोधर्मी': ['radioactive', 'nuclear'],
    'science': ['विज्ञान', 'science'],
    'विज्ञान': ['science', 'wigyan'],
    'cricket': ['क्रिकेट', 'क्रीड़ा', 'खेल', 'sport'],
    'क्रिकेट': ['cricket', 'sport'],
    'khel': ['खेल', 'क्रीड़ा', 'sport', 'cricket'],

    // Common Elements
    'hydrogen': ['हाइड्रोजन', 'जलजनक'],
    'हाइड्रोजन': ['hydrogen', 'h'],
    'helium': ['हीलियम'],
    'हीलियम': ['helium', 'he'],
    'carbon': ['कार्बन'],
    'कार्बन': ['carbon', 'c'],
    'nitrogen': ['नाइट्रोजन'],
    'नाइट्रोजन': ['nitrogen', 'n'],
    'oxygen': ['ऑक्सीजन', 'प्राणवायु'],
    'ऑक्सीजन': ['oxygen', 'o'],
    'iron': ['लोहा', 'आयरन', 'fe'],
    'loha': ['लोहा', 'iron', 'fe'],
    'लोहा': ['iron', 'fe'],
    'gold': ['सोना', 'स्वर्ण', 'au'],
    'sona': ['सोना', 'gold', 'au'],
    'सोना': ['gold', 'au'],
    'silver': ['चाँदी', 'रजत', 'ag'],
    'chandi': ['चाँदी', 'silver', 'ag'],
    'चाँदी': ['silver', 'ag'],
    'copper': ['ताँबा', 'ताम्र', 'cu'],
    'tamba': ['ताँबा', 'copper', 'cu'],
    'ताँबा': ['copper', 'cu']
  };

  function normalizeDigits(str) {
    return str.replace(/[०-९]/g, function (d) {
      return DEVA_DIGITS[d] || d;
    });
  }

  function normalizeQuery(q) {
    if (!q) return '';
    return normalizeDigits(q.trim().toLowerCase());
  }

  function tokenize(q) {
    const norm = normalizeQuery(q);
    if (!norm) return [];
    return norm.split(/\s+/).filter(Boolean);
  }

  function expandTokens(tokens) {
    const expanded = new Set(tokens);
    tokens.forEach(function (token) {
      if (BILINGUAL_MAP[token]) {
        BILINGUAL_MAP[token].forEach(function (term) {
          expanded.add(term.toLowerCase());
        });
      }
    });
    return Array.from(expanded);
  }

  function levenshtein(a, b) {
    if (Math.abs(a.length - b.length) > 4) return 99;
    const m = [];
    for (let i = 0; i <= b.length; i++) m[i] = [i];
    for (let j = 0; j <= a.length; j++) m[0][j] = j;
    for (let i = 1; i <= b.length; i++) {
      for (let j = 1; j <= a.length; j++) {
        const cost = a[j - 1] === b[i - 1] ? 0 : 1;
        m[i][j] = Math.min(m[i - 1][j] + 1, m[i][j - 1] + 1, m[i - 1][j - 1] + cost);
      }
    }
    return m[b.length][a.length];
  }

  function scoreItem(item, queryTokens, allTokens) {
    let score = 0;
    const itemTitle = (item.title || item._titleClean || '').toLowerCase();
    const itemDesc = (item.description || '').toLowerCase();
    const itemTags = (item.tags || []).map(function (t) { return String(t).toLowerCase(); });

    allTokens.forEach(function (token) {
      // Title match
      if (itemTitle === token) score += 120;
      else if (itemTitle.indexOf(token) !== -1) score += 70;
      else {
        const dist = levenshtein(itemTitle, token);
        if (dist <= 2) score += Math.max(0, 40 - dist * 15);
      }

      // Tags match
      itemTags.forEach(function (tag) {
        if (tag === token) score += 50;
        else if (tag.indexOf(token) !== -1) score += 30;
      });

      // Description match
      if (itemDesc.indexOf(token) !== -1) score += 35;
    });

    return score;
  }

  const SarvpediaSearch = {
    search: function (dataset, query, limit) {
      const rawTokens = tokenize(query);
      if (!rawTokens.length) return [];

      const allTokens = expandTokens(rawTokens);
      const maxResults = limit || 12;

      const results = dataset.map(function (item) {
        const copy = Object.assign({}, item);
        copy._score = scoreItem(item, rawTokens, allTokens);
        return copy;
      }).filter(function (item) {
        return item._score > 20;
      });

      results.sort(function (a, b) {
        return b._score - a._score;
      });

      return results.slice(0, maxResults);
    },

    tokenize: tokenize,
    expandTokens: expandTokens,
    normalizeQuery: normalizeQuery
  };

  window.SarvpediaSearch = SarvpediaSearch;
})();
