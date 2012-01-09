// ==UserScript==
// @name        DeviantART Link Disobnoxiator
// @description Removes the idiot guard from links on DeviantART.
// @version     1.0
// @author      Eris
// @namespace   http://erisdiscord.github.com/
// @match       http://*.deviantart.com/*
// @match       http://www.deviantart.com/users/outgoing?*
// ==/UserScript==
var disobnoxiateLinks, script;

disobnoxiateLinks = function($) {
  return $('a.external').attr('href', function(i, href) {
    return decodeURIComponent(href.replace(/^.*\/outgoing\?/, ''));
  });
};

if (location.pathname === '/users/outgoing') {
  location.replace(location.search.slice(1));
} else {
  script = document.createElement('script');
  script.type = 'text/javascript';
  script.textContent = "(" + disobnoxiateLinks + ")(jQuery)";
  document.getElementsByTagName('head')[0].appendChild(script);
}
