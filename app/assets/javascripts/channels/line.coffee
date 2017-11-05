App.line = App.cable.subscriptions.create "LineChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log "socket connected"

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log "socket disconnected"

  received: (data) ->
    # Called when theres incoming data on the websocket for this channel
    console.log "socket received: #{data}"
