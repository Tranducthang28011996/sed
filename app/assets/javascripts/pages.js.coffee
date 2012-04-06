# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#selectable").live 'click', (event) ->
    $("#selectable").selectable
      selected: ->
        id = $("li.ui-selected").find("input[type=hidden]").val()
        $.ajax
          url: "users/" + id + "/",
          dataType: "script",
  $('#user-list-content .pagination a').live 'click', (event) ->
    $.getScript(this.href);
    return false;
  $("section#user-flyout").click (event) ->
    $("div#user_flyout_menu").animate
      width: 'toggle'
  $("div#user_flyout_menu").click (event) ->
    (event).stopPropagation();
  $("div#user_flyout_menu ul li.hide").click (event) ->
    $("div#user_flyout_menu").animate
      width: 'toggle'
