/**
 * सर्वविज्ञान · Sarvpedia Language Switcher · v1.0
 * Manages language switching, chrome localization, and article routing.
 */

(function () {
  'use strict';

  function showLanguageNotice(message) {
    let noticeEl = document.getElementById('sarvpedia-lang-notice');
    if (!noticeEl) {
      noticeEl = document.createElement('div');
      noticeEl.id = 'sarvpedia-lang-notice';
      noticeEl.className = 'lang-notice';
      noticeEl.setAttribute('role', 'status');
      noticeEl.setAttribute('aria-live', 'polite');
      noticeEl.style.cssText = [
        'position: fixed',
        'bottom: var(--space-6, 1.5rem)',
        'right: var(--space-6, 1.5rem)',
        'background: var(--surface, #FFFFFF)',
        'color: var(--text, #1C1917)',
        'border: 1px solid var(--border-strong, #D6D3D1)',
        'border-radius: var(--radius-md, 12px)',
        'padding: var(--space-3, 0.75rem) var(--space-5, 1.25rem)',
        'box-shadow: var(--shadow-lg, 0 12px 32px rgba(28,25,23,0.12))',
        'font-family: var(--font-hindi, Mukta, sans-serif)',
        'font-size: var(--text-sm, 0.875rem)',
        'display: flex',
        'align-items: center',
        'gap: var(--space-3, 0.75rem)',
        'z-index: 9999',
        'transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1)'
      ].join(';');
      document.body.appendChild(noticeEl);
    }

    noticeEl.innerHTML = `
      <i class="fas fa-circle-info" style="color: var(--accent, #B45309);" aria-hidden="true"></i>
      <span>${message}</span>
      <button type="button" aria-label="बंद करें" style="background:transparent;border:0;cursor:pointer;color:var(--text-muted);padding:0 var(--space-1);" onclick="this.parentElement.remove()">
        <i class="fas fa-xmark" aria-hidden="true"></i>
      </button>
    `;

    setTimeout(function () {
      if (noticeEl && noticeEl.parentElement) {
        noticeEl.style.opacity = '0';
        noticeEl.style.transform = 'translateY(8px)';
        setTimeout(function () {
          if (noticeEl.parentElement) noticeEl.parentElement.removeChild(noticeEl);
        }, 300);
      }
    }, 4500);
  }

  function handleLanguageSwitch(targetLang) {
    if (window.SarvpediaI18n) {
      window.SarvpediaI18n.setLanguage(targetLang);
    } else {
      document.documentElement.lang = targetLang;
      try {
        localStorage.setItem('sarvpedia.lang', targetLang);
      } catch (e) {}
    }

    if (targetLang === 'en') {
      // Check if alternate English link exists in head
      const altEn = document.querySelector('link[rel="alternate"][hreflang="en"]');
      const currentPath = window.location.pathname;

      if (altEn && altEn.getAttribute('href') && !currentPath.includes('/en/')) {
        const href = altEn.getAttribute('href');
        // If not home page, check if specific translated article exists
        if (currentPath.endsWith('.html') && !currentPath.endsWith('index.html')) {
          // If a distinct alternate page was provided:
          showLanguageNotice('अंग्रेज़ी संस्करण उपलब्ध नहीं है · English version not available');
        }
      }
    }
  }

  function initLangSwitcher() {
    document.addEventListener('click', function (e) {
      const btn = e.target.closest('.lang-btn');
      if (!btn) return;

      const targetLang = btn.getAttribute('data-lang');
      if (targetLang) {
        handleLanguageSwitch(targetLang);
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initLangSwitcher);
  } else {
    initLangSwitcher();
  }
})();
