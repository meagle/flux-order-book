AppDispatcher = require("../dispatcher/AppDispatcher")

module.exports = 

  getCurrentOrderBookStats: (numberOfOrderBooks)->
    AppDispatcher.handleServerAction
      type: "GET_CURRENT_ORDER_BOOK_INFO"
      numberOfOrderBooks: numberOfOrderBooks

  addOrderBook: ->
    AppDispatcher.handleServerAction
      type: "ADD_ORDER_BOOK"


  