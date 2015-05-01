# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(window).load ->
  $('a[data-target]').click (e) ->
    e.preventDefault()
    $this = $(this)
    url = $this.data('addurl')    
    $.ajax url: url, type: 'put', success: (data) ->
      $('.cart-count').html(data)