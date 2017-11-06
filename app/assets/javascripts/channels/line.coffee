App.line = App.cable.subscriptions.create "LineChannel",

  connected: ->
    # Called when the subscription is ready for use on the server
    console.log "socket connected"

  disconnected: ->
    # Called when the subscription has been terminated by the server
        console.log "socket disconnected"

  received: (data) ->
    # Called when theres incoming data on the websocket for this channel
    # @update_cart_header(data)

    # update_cart_header: (data) ->
      htmltext = #{data["body"]}
    #  $('#group_cart').html(htmltext)
    


      console.log "socket received: #{data['body']}"
      console.log "#{htmltext}"

