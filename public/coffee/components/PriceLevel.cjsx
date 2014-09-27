Bid = require './Bid'
Offer = require './Offer'
React = require 'react/addons'

PriceLevel = React.createClass

  displayName: 'PriceLevel'

  render: ->
    <tr>
      <td className="qty">{@props.priceLevel.bid.qty}</td>
      <Bid bid={@props.priceLevel.bid}/>
      <Offer offer={@props.priceLevel.offer}/>
      <td className="qty">{@props.priceLevel.offer.qty}</td>
    </tr>
  
module.exports = PriceLevel

