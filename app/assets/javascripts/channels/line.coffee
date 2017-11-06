App.line = App.cable.subscriptions.create "LineChannel",

  connected: ->
    console.log "socket connected"

  disconnected: ->
    console.log "socket disconnected"
  
  received: (data) ->
    $('#group_cart').html(data['body'])
    console.log "socket received: #{data['body']}"


