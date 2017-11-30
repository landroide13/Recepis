App.coments = App.cable.subscriptions.create "ComentsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#messages").prepend(data)
    # Called when there's incoming data on the websocket for this channel
