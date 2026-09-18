/* =================================================================
   सर्वपीडिया — v4.0
   गणपति की कृपा से — bulletproof search · carousel · theme
   ================================================================= */
(function () {
    'use strict';

    const $  = (s, c) => (c || document).querySelector(s);
    const $$ = (s, c) => Array.prototype.slice.call((c || document).querySelectorAll(s));

    /* ============= सहायक ============= */
    function escapeHtml(str) {
        return String(str == null ? '' : str).replace(/[&<>"']/g, function (c) {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
        });
    }

    function highlightMatch(text, query) {
        if (!query) return escapeHtml(text);
        const safeText = escapeHtml(text);
        const safeQuery = escapeHtml(query).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        try {
            return safeText.replace(new RegExp('(' + safeQuery + ')', 'gi'), '<mark>$1</mark>');
        } catch (_) {
            return safeText;
        }
    }

    /* ============= 1. रूप (Theme) ============= */
    const THEME_KEY = 'sarvwigyan-theme';
    const VALID_THEMES = ['light', 'dark', 'pure'];

    function readTheme() {
        try {
            const t = localStorage.getItem(THEME_KEY);
            if (VALID_THEMES.indexOf(t) !== -1) return t;
        } catch (_) {}
        return 'light';
    }

    function applyTheme(theme) {
        if (VALID_THEMES.indexOf(theme) === -1) theme = 'light';
        document.documentElement.setAttribute('data-theme', theme);
        try { localStorage.setItem(THEME_KEY, theme); } catch (_) {}
    }

    applyTheme(readTheme());

    function initTheme() {
        const btn = document.getElementById('themeToggle');
        if (!btn) return;
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            const current = document.documentElement.getAttribute('data-theme') || 'light';
            applyTheme(current === 'dark' ? 'light' : 'dark');
        });
    }

    /* ============= 2. डेटा ============= */
    const fallbackData = [
        {
            title: 'स्वागत',
            link: 'https://sarvwigyan.github.io/',
            tags: ['general'],
            description: 'सर्वविज्ञान मुख्य मंच का अन्वेषण करें।'
        }
    ];

    let data = [];

    try {
        if (typeof elementsData !== 'undefined' && Array.isArray(elementsData)) {
            data = data.concat(elementsData);
        }
        if (typeof cricketData !== 'undefined' && Array.isArray(cricketData)) {
            data = data.concat(cricketData);
        }
        if (data.length === 0) data = fallbackData;
    } catch (err) {
        console.error('डेटा लोड त्रुटि:', err);
        data = fallbackData;
    }

    data.forEach(function (item) {
        item._titleLower = (item.title || '').toLowerCase();
        item._descLower  = (item.description || '').toLowerCase();
        item._tagsLower  = (item.tags || []).map(function (t) { return String(t).toLowerCase(); });
        item._titleClean = String(item.title || '').replace(/\s*\(Elements\)\s*$/i, '').trim();
    });

    /* ============= 3. श्रेणी निर्धारण ============= */
    function deriveCategory(item) {
        const t = item._tagsLower || [];
        const has = function (x) { return t.indexOf(x) !== -1; };

        if (has('cricket'))       return { label: 'क्रीड़ा',         icon: 'fa-baseball',   initials: 'क्री' };
        if (has('radioactive'))   return { label: 'रेडियोधर्मी',    icon: 'fa-radiation',  initials: 'रेड' };
        if (has('gas'))           return { label: 'गैस',            icon: 'fa-wind',       initials: 'गै' };
        if (has('halogen'))       return { label: 'हैलोजन',         icon: 'fa-flask',      initials: 'है' };
        if (has('lanthanide'))    return { label: 'दुर्लभ मृदा',    icon: 'fa-gem',        initials: 'दु' };
        if (has('actinide'))      return { label: 'एक्टिनाइड',      icon: 'fa-atom',       initials: 'ए' };
        if (has('metalloid'))     return { label: 'उपधातु',          icon: 'fa-cubes',      initials: 'उ' };
        if (has('nonmetal'))      return { label: 'अधातु',           icon: 'fa-leaf',       initials: 'अ' };
        if (has('metal'))         return { label: 'धातु',            icon: 'fa-cog',        initials: 'धा' };
        if (has('transition'))    return { label: 'संक्रमण धातु',    icon: 'fa-cog',        initials: 'सं' };
        if (has('synthetic'))     return { label: 'संश्लेषित',       icon: 'fa-flask',      initials: 'सं' };
        if (has('precious'))      return { label: 'बहुमूल्य',         icon: 'fa-gem',        initials: 'ब' };
        return { label: 'सामान्य', icon: 'fa-book', initials: 'सा' };
    }

    /* ============= 4. खोज — समानार्थी ============= */
    const synonyms = {
        'gas':         ['vapor', 'gaseous', 'air', 'वायु'],
        'metal':       ['metallic', 'alloy', 'dhatu', 'धातु'],
        'radioactive': ['nuclear', 'unstable', 'रेडियोधर्मी'],
        'light':       ['lightweight', 'low-density', 'हल्का'],
        'heavy':       ['dense', 'massive', 'भारी'],
        'toxic':       ['poisonous', 'harmful', 'विषैला', 'जहरीला'],
        'noble':       ['inert', 'unreactive', 'अक्रिय'],
        'halogen':     ['reactive', 'हैलोजन'],
        'lanthanide':  ['rare earth', 'दुर्लभ मृदा'],
        'actinide':    ['radioactive series', 'एक्टिनाइड'],
        'synthetic':   ['artificial', 'संश्लेषित'],
        'transition':  ['metallic', 'versatile'],
        'cricket':     ['game', 'sport', 'क्रीड़ा', 'खेल']
    };

    function tokenize(q) {
        return q.toLowerCase().trim().split(/\s+/).filter(function (t) { return t.length > 0; });
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

    function scoreItem(item, tokens) {
        let total = 0;
        tokens.forEach(function (q) {
            const titleExact = item._titleLower.indexOf(q) !== -1 ? 100 : 0;
            const titleLev = levenshtein(item._titleLower, q);
            const titleScore = titleExact + (q.length / (titleLev + 1)) * 20;

            let tagScore = 0;
            item._tagsLower.forEach(function (tag) {
                if (tag === q) tagScore += 50;
                else if (tag.indexOf(q) !== -1) tagScore += 25;
                const lev = levenshtein(tag, q);
                tagScore += (q.length / (lev + 1)) * 8;

                if (synonyms[tag]) {
                    synonyms[tag].forEach(function (syn) {
                        if (syn === q || syn.indexOf(q) !== -1) tagScore += 30;
                    });
                }
            });

            const descScore = item._descLower.indexOf(q) !== -1 ? 80 : 0;
            total += titleScore + tagScore + descScore;
        });
        return total;
    }

    /* ============= 5. खोज UI ============= */
    let searchInput, suggestionsEl, clearBtn;
    let activeIndex = -1;
    let currentItems = [];

    function initSearch() {
        searchInput   = document.getElementById('searchInput');
        suggestionsEl = document.getElementById('suggestions');
        clearBtn      = document.getElementById('clearBtn');
        const trigger = document.getElementById('searchTrigger');

        if (!searchInput || !suggestionsEl) return;

        let debounceTimer;
        searchInput.addEventListener('input', function () {
            const val = searchInput.value;
            if (clearBtn) clearBtn.classList.toggle('visible', val.length > 0);
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(function () { runSearch(val); }, 120);
        });

        searchInput.addEventListener('focus', function () {
            if (searchInput.value.trim().length > 0) runSearch(searchInput.value);
        });

        searchInput.addEventListener('keydown', handleSearchKeydown);

        if (clearBtn) {
            clearBtn.addEventListener('click', function () {
                searchInput.value = '';
                clearBtn.classList.remove('visible');
                closeSuggestions();
                searchInput.focus();
            });
        }

        if (trigger) {
            trigger.addEventListener('click', function () {
                searchInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                setTimeout(function () { searchInput.focus(); }, 250);
            });
        }

        document.addEventListener('keydown', function (e) {
            const isMac = (navigator.platform || '').toUpperCase().indexOf('MAC') !== -1;
            const mod = isMac ? e.metaKey : e.ctrlKey;
            const cmdK = mod && (e.key || '').toLowerCase() === 'k';
            const slash = e.key === '/' &&
                ['INPUT', 'TEXTAREA'].indexOf((document.activeElement || {}).tagName) === -1;

            if (cmdK || slash) {
                e.preventDefault();
                searchInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                setTimeout(function () { searchInput.focus(); searchInput.select(); }, 200);
            }
            if (e.key === 'Escape' && document.activeElement === searchInput) {
                if (searchInput.value) {
                    searchInput.value = '';
                    if (clearBtn) clearBtn.classList.remove('visible');
                    closeSuggestions();
                } else {
                    searchInput.blur();
                }
            }
        });

        document.addEventListener('click', function (e) {
            const wrap = searchInput.closest('.search-wrap');
            if (wrap && !wrap.contains(e.target)) closeSuggestions();
        });
    }

    function handleSearchKeydown(e) {
        if (!suggestionsEl.classList.contains('visible')) return;

        if (e.key === 'ArrowDown') {
            e.preventDefault();
            moveFocus(1);
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            moveFocus(-1);
        } else if (e.key === 'Enter') {
            e.preventDefault();
            if (activeIndex >= 0 && currentItems[activeIndex]) {
                openLink(currentItems[activeIndex].link);
            } else if (currentItems[0]) {
                openLink(currentItems[0].link);
            }
        }
    }

    function moveFocus(dir) {
        const items = $$('.suggestion-item', suggestionsEl);
        if (!items.length) return;

        if (activeIndex >= 0 && items[activeIndex]) items[activeIndex].classList.remove('focused');

        activeIndex += dir;
        if (activeIndex < 0) activeIndex = items.length - 1;
        if (activeIndex >= items.length) activeIndex = 0;

        items[activeIndex].classList.add('focused');
        items[activeIndex].scrollIntoView({ block: 'nearest' });
    }

    function runSearch(query) {
        query = (query || '').trim();
        if (query.length < 1) { closeSuggestions(); return; }

        let top = [];
        if (window.SarvpediaSearch) {
            top = window.SarvpediaSearch.search(data, query, 12);
        } else {
            const tokens = tokenize(query);
            const scored = data.map(function (item) {
                const copy = Object.assign({}, item);
                copy._score = scoreItem(item, tokens);
                return copy;
            }).filter(function (item) { return item._score > 15; });

            scored.sort(function (a, b) { return b._score - a._score; });
            top = scored.slice(0, 12);
        }

        currentItems = top;
        activeIndex = -1;

        renderSuggestions(top, query);
    }

    function renderSuggestions(items, query) {
        suggestionsEl.innerHTML = '';

        if (!items.length) {
            suggestionsEl.innerHTML =
                '<div class="suggestion-empty">' +
                    '<i class="fas fa-om"></i>' +
                    '<strong>विघ्न आया, पुनः प्रयास करें</strong>' +
                    '<div>व्यापक शब्दों से खोजें</div>' +
                '</div>';
            suggestionsEl.classList.add('visible');
            return;
        }

        const frag = document.createDocumentFragment();

        items.forEach(function (item, idx) {
            const cat = deriveCategory(item);
            const title = item._titleClean || item.title;
            const desc = (item.description || '').length > 90
                ? item.description.substring(0, 90) + '...'
                : (item.description || '');

            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'suggestion-item';
            btn.setAttribute('role', 'option');
            btn.setAttribute('data-idx', String(idx));

            btn.innerHTML =
                '<span class="suggestion-icon" aria-hidden="true">' +
                    '<i class="fas ' + cat.icon + '"></i>' +
                '</span>' +
                '<span class="suggestion-body">' +
                    '<span class="suggestion-title">' + highlightMatch(title, query) + '</span>' +
                    '<span class="suggestion-desc">' + escapeHtml(desc) + '</span>' +
                '</span>' +
                '<i class="fas fa-arrow-right suggestion-arrow" aria-hidden="true"></i>';

            btn.addEventListener('click', function () { openLink(item.link); });
            btn.addEventListener('mouseenter', function () {
                const all = $$('.suggestion-item', suggestionsEl);
                all.forEach(function (el) { el.classList.remove('focused'); });
                btn.classList.add('focused');
                activeIndex = idx;
            });

            frag.appendChild(btn);
        });

        suggestionsEl.appendChild(frag);
        suggestionsEl.classList.add('visible');
    }

    function closeSuggestions() {
        suggestionsEl.classList.remove('visible');
        activeIndex = -1;
    }

    function openLink(url) {
        if (!url) return;
        if (/^https?:\/\//i.test(url)) {
            window.open(url, '_blank', 'noopener,noreferrer');
        } else {
            window.location.href = url;
        }
    }

    /* ============= 6. Chips ============= */
    function initChips() {
        const chips = $$('.chip');
        chips.forEach(function (chip) {
            chip.addEventListener('click', function () {
                const q = chip.getAttribute('data-query');
                if (!q) return;
                if (searchInput) {
                    searchInput.value = q;
                    if (clearBtn) clearBtn.classList.add('visible');
                    searchInput.focus();
                    searchInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    runSearch(q);
                }
            });
        });
    }

    /* ============= 7. कैरोसेल ============= */
    function initCarousel() {
        const carousel = document.getElementById('carousel');
        if (!carousel) return;

        const pool = data.filter(function (item) {
            return item.link && item.link.indexOf('_sarvpedia') !== -1;
        });
        const source = pool.length >= 10 ? pool : data;

        const shuffled = source.slice();
        for (let i = shuffled.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            const tmp = shuffled[i];
            shuffled[i] = shuffled[j];
            shuffled[j] = tmp;
        }
        const picked = shuffled.slice(0, 10);

        carousel.innerHTML = '';

        picked.forEach(function (item) {
            const cat = deriveCategory(item);
            const title = item._titleClean || item.title;
            const desc = (item.description || '').length > 110
                ? item.description.substring(0, 110) + '...'
                : (item.description || '');

            const card = document.createElement('article');
            card.className = 'card';
            card.setAttribute('role', 'button');
            card.setAttribute('tabindex', '0');

            card.innerHTML =
                '<div class="card-icon-wrap" aria-hidden="true">' + escapeHtml(cat.initials) + '</div>' +
                '<span class="card-category">' +
                    '<i class="fas ' + cat.icon + '" aria-hidden="true"></i> ' + escapeHtml(cat.label) +
                '</span>' +
                '<h3 class="card-title">' + escapeHtml(title) + '</h3>' +
                '<p class="card-desc">' + escapeHtml(desc) + '</p>' +
                '<span class="card-cta">विस्तार से देखें <i class="fas fa-arrow-right"></i></span>';

            card.addEventListener('click', function () { openLink(item.link); });
            card.addEventListener('keydown', function (e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    openLink(item.link);
                }
            });

            carousel.appendChild(card);
        });

        const prev = document.getElementById('prevBtn');
        const next = document.getElementById('nextBtn');
        const step = 290;

        if (prev) prev.addEventListener('click', function () {
            carousel.scrollBy({ left: -step, behavior: 'smooth' });
        });
        if (next) next.addEventListener('click', function () {
            carousel.scrollBy({ left: step, behavior: 'smooth' });
        });
    }

    /* ============= 8. Reveal ============= */
    function initReveal() {
        const els = $$('.reveal');
        if (!els.length) return;

        if (!('IntersectionObserver' in window)) {
            els.forEach(function (el) { el.classList.add('is-visible'); });
            return;
        }

        const obs = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    entry.target.classList.add('is-visible');
                    obs.unobserve(entry.target);
                }
            });
        }, { threshold: 0.08, rootMargin: '0px 0px -30px 0px' });

        els.forEach(function (el) { obs.observe(el); });

        setTimeout(function () {
            els.forEach(function (el) {
                if (!el.classList.contains('is-visible')) el.classList.add('is-visible');
            });
        }, 3000);
    }

    /* ============= 9. प्रारंभ ============= */
    function boot() {
        initTheme();
        initSearch();
        initChips();
        initCarousel();
        initReveal();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', boot);
    } else {
        boot();
    }
})();