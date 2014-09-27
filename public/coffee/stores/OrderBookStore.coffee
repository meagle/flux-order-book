AppDispatcher     = require("../dispatcher/AppDispatcher")
EventEmitter      = require("events").EventEmitter
merge             = require("react/lib/merge")
orderBookJSON = require('../../../order_book_snapshots.json');
    
CHANGE_EVENT = "change"

_orderBookStatsIndex = 0;
_currentOrderBookStats = [];

OrderBookStore = merge(EventEmitter::,
  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  setCurrentOrderBookStats: (orderBookIndex, numberOfOrderBooks)->
    _currentOrderBookStats = []
    for i in [0...numberOfOrderBooks]
      _currentOrderBookStats.push orderBookJSON[orderBookIndex].markets[i].stats

  getCurrentOrderBookStats: ->
    _currentOrderBookStats
)

OrderBookStore.dispatchToken = AppDispatcher.register((payload) ->
  
  action = payload.action
  numberOfOrderBooks = action.numberOfOrderBooks
  switch action.type
    when "GET_CURRENT_ORDER_BOOK_INFO"
      OrderBookStore.setCurrentOrderBookStats(_orderBookStatsIndex % 100, numberOfOrderBooks)
      _orderBookStatsIndex += 1;
      OrderBookStore.emitChange()
      break
)

module.exports = OrderBookStore