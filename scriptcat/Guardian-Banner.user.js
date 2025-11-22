// ==UserScript==
// @name         Guardian-Banner
// @namespace    https://docs.scriptcat.org/
// @version      0.1.0
// @description  Removes Guardian's nagging banner
// @author       Wayne Maurer
// @match        https://www.theguardian.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    const guIsland = document.querySelector("gu-island[name='StickyBottomBanner']")
    if (guIsland) guIsland.style.display = "none"
})();
