# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#students th a').live 'click', (event) ->
    $.getScript(this.href)
    return false
  $('#students .pagination a').live 'click', (event) ->
    $.getScript(this.href)
    return false
  $('#user_search_full input').submit ->
    $.get($('#user_search_full').attr('action'),
      $('#user_search_full').serialize(), null, 'script')
    false
  $("a.remote").click (event) ->
    $.getScript(this.href)
    false
