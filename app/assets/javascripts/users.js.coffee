# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#delete-account').tooltip(
    title: 'Delete your account'
  ).click ->
    $('#delete-account-confirm').modal()

  $('a[data-toggle="tab"]').on('shown', (e) ->
    $(e.relatedTarget).removeClass('active').find('.icon-white').removeClass 'icon-white'
    $(e.target).parent().addClass('active').find('i').addClass 'icon-white'
  )
