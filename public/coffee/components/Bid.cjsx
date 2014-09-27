React = require 'react/addons'

Bid = React.createClass

  displayName: 'Bid'

  getInitialState: ->
    priceChanged: false

  render: ->
    <td className={@_getClassName()}>{@props.bid.price}</td>
  
  componentWillReceiveProps: (nextProps)->
    @setState 
      priceChanged: nextProps.bid.price isnt @props.bid.price

  _getClassName: ->
    React.addons.classSet
      bid: true
      change: @state.priceChanged

 componentDidUpdate: (prevProps, prevState) ->
   if @state.increasing or @state.decreasing
     ReactTransitionEvents.addEndEventListener @getDOMNode(), @onTransitionEnd

 componentWillUnmount: ->
   ReactTransitionEvents.removeEndEventListener @getDOMNode(), @onTransitionEnd

 onTransitionEnd: ->
   @getDOMNode().classList.remove 'priceChanged'
   true

module.exports = Bid
