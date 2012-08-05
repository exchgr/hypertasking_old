# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#delete-account').tooltip(
    title: 'Delete your account'
  ).click ->
    $('#delete-account-confirm').modal()

  $('ul.nav-list a').click ->
    $(this).parent().parent().find('li.active').removeClass('active').find('.icon-white').removeClass 'icon-white'
    $(this).parent().addClass('active').find('i').addClass 'icon-white'
