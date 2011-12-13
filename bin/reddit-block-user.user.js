// ==UserScript==
// @name        Reddit: Block Users from Your Inbox
// @description Adds a "block user" link to all comment replies in your inbox.
// @version     1.0
// @author      Eris
// @namespace   http://erisdiscord.github.com/
// @match       http://www.reddit.com/message/*
// ==/UserScript==
var addBlockButton, script;

addBlockButton = function($) {
  return $('.was-comment .report-button').closest('li').after('<li>\n  <form class="toggle block-button" action="#" method="get">\n    <input type="hidden" name="executed" value="blocked" class="active">\n    <span class="option active">\n      <a onclick="return toggle(this)">block user</a>\n    </span>\n    <span class="option error">\n      are you sure?\n      <a class="yes" onclick="change_state(this, \'block\', hide_thing)">yes</a> /\n      <a class="no" onclick="return toggle(this)">no</a>\n    </span>\n  </form>\n</li>');
};

script = document.createElement('script');

script.type = 'text/javascript';

script.textContent = "(" + addBlockButton + ")(jQuery)";

document.getElementsByTagName('head')[0].appendChild(script);
