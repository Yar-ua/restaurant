App.line = App.cable.subscriptions.create "LineChannel",

  connected: ->
    console.log "socket connected"

  disconnected: ->
    console.log "socket disconnected"
  
  received: (data) ->
    $('#group_cart').html(data['body'])
    $('#group_cart_table').html(data['table_line'])

    console.log "socket received cart: #{data['body']}"
    console.log "socket received table: #{data['table_line']}"



