# ==UserScript==
# @name        Reddit: Block Users from Your Inbox
# @description Adds a "block user" link to all comment replies in your inbox.
# @version     1.0
# @author      Eris
# @namespace   http://erisdiscord.github.com/
# @match       http://www.reddit.com/message/*
# ==/UserScript==

# HTML taken directly from Reddit. Guaranteed fresh. For now.
addBlockButton = ($) ->
  $('.was-comment .report-button').closest('li').after('''
    <li>
      <form class="toggle block-button" action="#" method="get">
        <input type="hidden" name="executed" value="blocked" class="active">
        <span class="option active">
          <a onclick="return toggle(this)">block user</a>
        </span>
        <span class="option error">
          are you sure?
          <a class="yes" onclick="change_state(this, 'block', hide_thing)">yes</a> /
          <a class="no" onclick="return toggle(this)">no</a>
        </span>
      </form>
    </li>
  ''')

# Inject this script into the web page directly.
# This is so we can use Reddit's jQuery without loading our own copy.
script = document.createElement 'script'
script.type = 'text/javascript'
script.textContent = "(#{addBlockButton})(jQuery)"
document.getElementsByTagName('head')[0].appendChild script

