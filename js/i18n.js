/**
 * सर्वविज्ञान · Sarvpedia i18n System · v1.0
 * Handles locale management and UI string localization.
 */

(function () {
  'use strict';

  const STORAGE_KEY = 'sarvpedia.lang';
  const DEFAULT_LANG = 'hi';

  const LOCALES = {
    hi: {
      site_title: "सर्वपीडिया",
      site_tagline: "ज्ञान का मंदिर",
      search_placeholder: "सर्वपीडिया में खोजें...",
      search_button: "खोजें...",
      search_clear: "खोज साफ़ करें",
      theme_toggle: "रूप बदलें",
      toc_title: "विषय-सूची",
      breadcrumb_home: "सर्वपीडिया",
      breadcrumb_category: "तत्व विज्ञान",
      footer_status: "सभी प्रणालियाँ सक्रिय",
      footer_copyright: "© २०२६ सर्वविज्ञान",
      nav_home: "मुख्य पृष्ठ",
      nav_sarvpedia: "सर्वपीडिया",
      nav_kosh: "कोष",
      nav_feedback: "प्रतिक्रिया",
      nav_privacy: "गोपनीयता",
      nav_community: "संघ",
      version_not_available: "अंग्रेज़ी संस्करण उपलब्ध नहीं है"
    },
    en: {
      site_title: "Sarvpedia",
      site_tagline: "Temple of Knowledge",
      search_placeholder: "Search in Sarvpedia...",
      search_button: "Search...",
      search_clear: "Clear search",
      theme_toggle: "Toggle theme",
      toc_title: "Table of Contents",
      breadcrumb_home: "Sarvpedia",
      breadcrumb_category: "Elemental Sciences",
      footer_status: "All systems operational",
      footer_copyright: "© 2026 Sarvwigyan",
      nav_home: "Home",
      nav_sarvpedia: "Sarvpedia",
      nav_kosh: "Kosh",
      nav_feedback: "Feedback",
      nav_privacy: "Privacy",
      nav_community: "Community",
      version_not_available: "English version not available"
    }
  };

  const SarvpediaI18n = {
    getLanguage: function () {
      try {
        return localStorage.getItem(STORAGE_KEY) || DEFAULT_LANG;
      } catch (e) {
        return DEFAULT_LANG;
      }
    },

    setLanguage: function (lang) {
      if (lang !== 'hi' && lang !== 'en') lang = DEFAULT_LANG;
      try {
        localStorage.setItem(STORAGE_KEY, lang);
      } catch (e) {}

      document.documentElement.lang = lang;
      document.documentElement.setAttribute('data-locale', lang === 'hi' ? 'hi-IN' : 'en-US');

      this.updateUI(lang);
      window.dispatchEvent(new CustomEvent('sarvpedia:langchange', { detail: { lang: lang } }));
    },

    t: function (key, lang) {
      const currentLang = lang || this.getLanguage();
      const dict = LOCALES[currentLang] || LOCALES[DEFAULT_LANG];
      return dict[key] || key;
    },

    updateUI: function (lang) {
      const currentLang = lang || this.getLanguage();
      const dict = LOCALES[currentLang] || LOCALES[DEFAULT_LANG];

      // Update text nodes
      document.querySelectorAll('[data-i18n]').forEach(function (el) {
        const key = el.getAttribute('data-i18n');
        if (dict[key]) {
          el.textContent = dict[key];
        }
      });

      // Update placeholders
      document.querySelectorAll('[data-i18n-placeholder]').forEach(function (el) {
        const key = el.getAttribute('data-i18n-placeholder');
        if (dict[key]) {
          el.setAttribute('placeholder', dict[key]);
        }
      });

      // Update aria-labels
      document.querySelectorAll('[data-i18n-aria]').forEach(function (el) {
        const key = el.getAttribute('data-i18n-aria');
        if (dict[key]) {
          el.setAttribute('aria-label', dict[key]);
        }
      });

      // Sync language switcher buttons
      document.querySelectorAll('.lang-switcher .lang-btn').forEach(function (btn) {
        const btnLang = btn.getAttribute('data-lang');
        const isActive = btnLang === currentLang;
        btn.classList.toggle('is-active', isActive);
        btn.setAttribute('aria-pressed', isActive ? 'true' : 'false');
      });
    },

    init: function () {
      const activeLang = this.getLanguage();
      document.documentElement.lang = activeLang;
      document.documentElement.setAttribute('data-locale', activeLang === 'hi' ? 'hi-IN' : 'en-US');
      this.updateUI(activeLang);
    }
  };

  window.SarvpediaI18n = SarvpediaI18n;

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function () {
      SarvpediaI18n.init();
    });
  } else {
    SarvpediaI18n.init();
  }
})();
