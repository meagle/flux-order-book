Summary = require './Summary'
PriceLevel = require './PriceLevel'
React = require 'react'

OrderBook = React.createClass

  displayName: 'OrderBook'

  renderPriceLevel: (priceLevel, index) ->
    <PriceLevel priceLevel={priceLevel} key={index}/>

  render: ->
    <li className="orderbook">
      <div><Summary summary={@props.orderBook}/></div>
      <table>
        <thead>
          <th>
            Qty
          </th>
          <th>
            Bids
          </th>
          <th>
            Offers
          </th>
          <th>
            Qty
          </th>
        </thead>
        <tbody>
          {@props.orderBook.orders.map(@renderPriceLevel)}
        </tbody>
      </table>
    </li>
  
module.exports = OrderBook