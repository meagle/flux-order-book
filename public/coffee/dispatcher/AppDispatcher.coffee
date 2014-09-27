###
A singleton that operates as the central hub for application updates.
###

Dispatcher = require('flux').Dispatcher
copyProperties = require("react/lib/copyProperties")
AppDispatcher = copyProperties(new Dispatcher(),
  
  handleServerAction: (action) ->
    payload =
      source: "SERVER_ACTION"
      action: action

    @dispatch payload
  
  handleViewAction: (action) ->
    payload =
      source: "VIEW_ACTION"
      action: action

    @dispatch payload
)

module.exports = AppDispatcher