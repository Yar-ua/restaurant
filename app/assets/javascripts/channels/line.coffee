App.line = App.cable.subscriptions.create "LineChannel",

  connected: ->
    console.log "socket connected"

  disconnected: ->
    console.log "socket disconnected"
  
  received: (data) ->
    $('#group_cart').html(data['body'])

    if $('#group_line_item_' + data['line_id']) > 0
      $('#group_line_item_' + data['line_id']).html(data['table_line'])
    else
      $('#group_cart_table').append('asdasdsdasd')

    console.log "socket received cart: #{data['body']}"
    console.log "socket received table: #{data['table_line']}"
    console.log "group line item : #{data['line_id']}"


