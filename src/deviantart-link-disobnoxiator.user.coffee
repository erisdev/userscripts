# ==UserScript==
# @name        DeviantART Link Disobnoxiator
# @description Removes the idiot guard from links on DeviantART.
# @version     1.0
# @author      Eris
# @namespace   http://erisdiscord.github.com/
# @match       http://*.deviantart.com/*
# @match       http://www.deviantart.com/users/outgoing?*
# ==/UserScript==

disobnoxiateLinks = ($) ->
  $('a.external').attr 'href', (i, href) ->
    decodeURIComponent href.replace(/// ^ .* /outgoing\? ///, '')

if location.pathname is '/users/outgoing'
  # If we're already on that stupid idiot guard page, GET OUTTA THERE.
  location.replace location.search[1..]
else
  # Inject this script into the web page directly.
  # This is so we can use DeviantART's jQuery without loading our own copy.
  script = document.createElement 'script'
  script.type = 'text/javascript'
  script.textContent = "(#{disobnoxiateLinks})(jQuery)"
  document.getElementsByTagName('head')[0].appendChild script
