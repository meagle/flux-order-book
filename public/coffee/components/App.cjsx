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
    _.extend {numberOfOrderBooks: 1, paused: true}, getStateFromStores()


  componentDidMount: ->
    OrderBookStore.addChangeListener @_onChange

    socket.on 'orderbook:current:stats', =>
      OrderBookActions.getCurrentOrderBookStats @state.numberOfOrderBooks 

  renderOrderBook: (orderBook) ->
    <OrderBook orderBook={orderBook} key={orderBook.marketId}/>

  render: ->

    <div>
      <nav role="navigation" className="navbar navbar-default">
        <div className="container-fluid">
          <div className="navbar-header">
            <a href="#" className="navbar-brand">Flux Order Book Demo</a>
          </div>
          <div className="collapse navbar-collapse">
            <ul className="nav navbar-nav">
              <li className={@_getStartClassName()}>
                  <a onClick={@_startReceivingOrders}>Start</a>
              </li>
              <li className={@_getStopClassName()}>
                  <a onClick={@_stopReceivingOrders}>Stop</a>
              </li>
              <li className={@_getAddOrderBookClassName()}>
                  <a onClick={@_addOrderBook}>Add Order Book</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      <ul>{@state.orderBooks.map(@renderOrderBook)}</ul>
    </div>
  
  _onChange: ->
    @setState getStateFromStores()

  _startReceivingOrders: ->
    @setState paused: false
    socket.emit 'start:receiving:orders'
  
  _stopReceivingOrders: ->
    @setState paused: true
    socket.emit 'stop:receiving:orders'

  _addOrderBook: ->
    if @state.numberOfOrderBooks < 9
      @setState numberOfOrderBooks: @state.numberOfOrderBooks + 1

  _getStartClassName: ->
    React.addons.classSet
      active: not @state.paused

  _getStopClassName: ->
    React.addons.classSet
      active: @state.paused

  _getAddOrderBookClassName: ->
    React.addons.classSet
      hide: @state.paused


module.exports = App