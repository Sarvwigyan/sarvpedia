// Fallback data in case elements.js and cricket.js fail
const fallbackData = [
    {
        title: "Sample Topic 1",
        description: "Explore interesting facts about science and technology.",
        link: "https://sarvwigyan.github.io/",
        tags: ["science", "technology"]
    },
    {
        title: "Sample Topic 2",
        description: "Learn about cultural heritage and its importance.",
        link: "https://sarvwigyan.github.io/",
        tags: ["culture", "heritage"]
    }
];

// Initialize data array
let data = [];
try {
    if (typeof elementsData !== 'undefined' && Array.isArray(elementsData)) {
        data = [...data, ...elementsData];
    }
    if (typeof cricketData !== 'undefined' && Array.isArray(cricketData)) {
        data = [...data, ...cricketData];
    }
    if (data.length === 0) {
        console.warn('No valid data from elements.js or cricket.js. Using fallback data.');
        data = fallbackData;
    }
} catch (error) {
    console.error('Error initializing data:', error.message);
    data = fallbackData;
}

// Pre-calculate lowercased values for high performance
data.forEach(item => {
    item._titleLower = (item.title || '').toLowerCase();
    item._descLower = (item.description || '').toLowerCase();
    item._tagsLower = (item.tags || []).map(t => t.toLowerCase());
});

// Expanded synonym dictionary
const synonyms = {
    "gas": ["vapor", "gaseous", "air"],
    "metal": ["metallic", "element", "alloy"],
    "radioactive": ["nuclear", "radiant", "unstable"],
    "light": ["lightweight", "low-density", "featherweight"],
    "heavy": ["dense", "weighty", "massive"],
    "toxic": ["poisonous", "harmful", "dangerous"],
    "noble": ["inert", "unreactive", "stable"],
    "halogen": ["reactive", "chemical"],
    "lanthanide": ["rare earth", "lanthanoid"],
    "actinide": ["radioactive series", "actinoid"],
    "synthetic": ["artificial", "essential"],
    "transition": ["metallic", "versatile"],
    "cricket": ["game", "batting", "sport"]
};

// Search history tracking
let searchHistory = JSON.parse(localStorage.getItem('searchHistory')) || [];

function tokenizeQuery(query) {
    return query.toLowerCase().split(/\s+/).filter(token => token.length > 0);
}

// Fast Levenshtein distance with length delta pruning
function levenshteinDistance(a, b) {
    if (Math.abs(a.length - b.length) > 4) return 99; // Prune distant strings immediately
    const matrix = Array(b.length + 1).fill(null).map(() => Array(a.length + 1).fill(null));
    for (let i = 0; i <= a.length; i++) matrix[0][i] = i;
    for (let j = 0; j <= b.length; j++) matrix[j][0] = j;
    
    for (let j = 1; j <= b.length; j++) {
        for (let i = 1; i <= a.length; i++) {
            const indicator = a[i - 1] === b[j - 1] ? 0 : 1;
            matrix[j][i] = Math.min(
                matrix[j][i - 1] + 1,
                matrix[j - 1][i] + 1,
                matrix[j - 1][i - 1] + indicator
            );
        }
    }
    return matrix[b.length][a.length];
}

// Enhanced relevance scoring
function calculateRelevance(item, queryTokens) {
    let totalScore = 0;

    queryTokens.forEach(query => {
        const titleExact = item._titleLower.includes(query) ? 100 : 0;
        const titleLev = levenshteinDistance(item._titleLower, query);
        const titleScore = titleExact + (query.length / (titleLev + 1)) * 20;

        let tagScore = 0;
        item._tagsLower.forEach(tag => {
            const tagExact = tag === query ? 50 : 0;
            const tagLev = levenshteinDistance(tag, query);
            tagScore += tagExact + (query.length / (tagLev + 1)) * 10;

            if (synonyms[tag]) {
                synonyms[tag].forEach(syn => {
                    if (syn === query) tagScore += 30;
                });
            }
        });

        const descExact = item._descLower.includes(query) ? 80 : 0;
        const descScore = descExact;

        totalScore += titleScore + tagScore + descScore;
    });

    return totalScore;
}

function addToSearchHistory(query) {
    const existing = searchHistory.find(item => item.query.toLowerCase() === query.toLowerCase());
    if (existing) {
        existing.count++;
        existing.timestamp = Date.now();
    } else {
        searchHistory.push({ query, count: 1, timestamp: Date.now() });
    }
    searchHistory = searchHistory.sort((a, b) => b.timestamp - a.timestamp).slice(0, 50);
    localStorage.setItem('searchHistory', JSON.stringify(searchHistory));
}

function filterSuggestions() {
    const searchBar = document.getElementById('search-bar');
    if (!searchBar) return;
    const query = searchBar.value.trim();
    const suggestionsList = document.getElementById('suggestions-list');
    const clearButton = document.getElementById('clear-button');
    suggestionsList.innerHTML = '';

    if (query.length > 0) {
        clearButton.style.display = 'flex';
    } else {
        clearButton.style.display = 'none';
        suggestionsList.style.display = 'none';
        return;
    }

    if (data.length === 0) {
        suggestionsList.style.display = 'block';
        suggestionsList.innerHTML = '<div class="suggestion-item">No data available.</div>';
        return;
    }

    const queryTokens = tokenizeQuery(query);
    const scoredItems = data.map(item => ({
        ...item,
        score: calculateRelevance(item, queryTokens)
    })).filter(item => item.score > 15);

    scoredItems.sort((a, b) => b.score - a.score);
    const topSuggestions = scoredItems.slice(0, 10);

    if (topSuggestions.length > 0) {
        suggestionsList.style.display = 'block';
        topSuggestions.forEach(item => {
            const div = document.createElement('div');
            div.classList.add('suggestion-item');
            if (item.score > 150) div.classList.add('highlight');

            const button = document.createElement('button');
            button.classList.add('suggestion-button');
            button.textContent = `${item.title} — ${item.description.substring(0, 55)}...`;

            button.onclick = function() {
                window.open(item.link, '_blank');
                addToSearchHistory(query);
            };

            div.appendChild(button);
            suggestionsList.appendChild(div);
        });
    } else {
        suggestionsList.style.display = 'block';
        const div = document.createElement('div');
        div.classList.add('suggestion-item');
        div.textContent = 'No results found. Try broader terms.';
        suggestionsList.appendChild(div);
    }
}

function clearSearch() {
    const searchBar = document.getElementById('search-bar');
    const clearButton = document.getElementById('clear-button');
    const suggestionsList = document.getElementById('suggestions-list');
    if (searchBar) {
        searchBar.value = '';
        searchBar.focus();
    }
    if (clearButton) clearButton.style.display = 'none';
    if (suggestionsList) suggestionsList.style.display = 'none';
}

function debounce(func, wait) {
    let timeout;
    return function(...args) {
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(this, args), wait);
    };
}

const debouncedFilterSuggestions = debounce(filterSuggestions, 150);

// Carousel Controls
function scrollCards(direction) {
    const cardContainer = document.getElementById('card-container');
    if (cardContainer) {
        const scrollAmount = direction === 'left' ? -300 : 300;
        cardContainer.scrollBy({ left: scrollAmount, behavior: 'smooth' });
    }
}

function populateCards() {
    const cardContainer = document.getElementById('card-container');
    if (!cardContainer) return;
    cardContainer.innerHTML = '';

    const shuffledData = [...data].sort(() => 0.5 - Math.random()).slice(0, 10);

    shuffledData.forEach(item => {
        const card = document.createElement('div');
        card.classList.add('card');
        card.onclick = function() {
            window.open(item.link, '_blank');
        };

        const truncatedDesc = item.description.length > 80 
            ? item.description.substring(0, 80) + '...' 
            : item.description;

        card.innerHTML = `
            <h3>${item.title}</h3>
            <p>${truncatedDesc}</p>
            <a href="${item.link}" target="_blank" onclick="event.stopPropagation();">विस्तृत विवरण देखें &rarr;</a>
        `;
        cardContainer.appendChild(card);
    });
}

function Expsarvwigyan() {
    window.open("https://sarvwigyan.github.io/", "_blank");
}

document.addEventListener('DOMContentLoaded', () => {
    populateCards();

    const searchBar = document.getElementById('search-bar');
    if (searchBar) {
        searchBar.addEventListener('input', debouncedFilterSuggestions);
        searchBar.addEventListener('keydown', function(e) {
            const suggestions = document.querySelectorAll('.suggestion-button');
            let currentIndex = -1;
            suggestions.forEach((sug, index) => {
                if (sug.classList.contains('focused')) currentIndex = index;
            });

            if (e.key === 'ArrowDown') {
                e.preventDefault();
                if (currentIndex < suggestions.length - 1) {
                    if (currentIndex >= 0) suggestions[currentIndex].classList.remove('focused');
                    currentIndex++;
                    suggestions[currentIndex].classList.add('focused');
                    suggestions[currentIndex].scrollIntoView({ block: 'nearest' });
                }
            } else if (e.key === 'ArrowUp') {
                e.preventDefault();
                if (currentIndex > 0) {
                    suggestions[currentIndex].classList.remove('focused');
                    currentIndex--;
                    suggestions[currentIndex].classList.add('focused');
                    suggestions[currentIndex].scrollIntoView({ block: 'nearest' });
                }
            } else if (e.key === 'Enter' && currentIndex >= 0) {
                e.preventDefault();
                suggestions[currentIndex].click();
            }
        });
    }

    document.addEventListener('click', function(event) {
        const suggestionsList = document.getElementById('suggestions-list');
        const searchBar = document.getElementById('search-bar');
        const clearButton = document.getElementById('clear-button');

        if (suggestionsList && searchBar && clearButton) {
            if (!searchBar.contains(event.target) && !suggestionsList.contains(event.target) && !clearButton.contains(event.target)) {
                suggestionsList.style.display = 'none';
            }
        }
    });
});