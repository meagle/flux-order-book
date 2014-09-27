OrderBookStore = require '../stores/OrderBookStore'
OrderBookActions = require '../actions/OrderBookActions'
OrderBook = require './OrderBook'
_ = require 'underscore'
React = require 'react'

getStateFromStores = ->
  orderBooks: OrderBookStore.getCurrentOrderBookStats()

App = React.createClass
  displayName: 'App'

  getInitialState: ->
    _.extend numberOfOrderBooks: 1, getStateFromStores()

  componentDidMount: ->
    OrderBookStore.addChangeListener @_onChange

    socket.on 'orderbook:current:stats', =>
      OrderBookActions.getCurrentOrderBookStats @state.numberOfOrderBooks 

  renderOrderBook: (orderBook) ->
    <OrderBook orderBook={orderBook} key={orderBook.marketId}/>

  render: ->
    <div>
      <div><a href="#" onClick={@_startReceivingOrders}>Start</a> | 
      <a href="#" onClick={@_stopReceivingOrders}>Stop</a> |
      <a href="#" onClick={@_addOrderBook}>Add Order Book</a> 
      </div>
      <ul>{@state.orderBooks.map(@renderOrderBook)}</ul>
    </div>
  
  _onChange: ->
    @setState getStateFromStores()

  _startReceivingOrders: ->
    socket.emit 'start:receiving:orders'
  
  _stopReceivingOrders: ->
    socket.emit 'stop:receiving:orders'

  _addOrderBook: ->
    if @state.numberOfOrderBooks < 9
      @setState numberOfOrderBooks: @state.numberOfOrderBooks + 1


module.exports = App