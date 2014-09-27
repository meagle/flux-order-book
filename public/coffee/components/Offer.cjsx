React = require 'react/addons'

Offer = React.createClass

  displayName: 'Offer'

  getInitialState: ->
    priceChanged: false

  render: ->
    <td className={@_getClassName()}>{@props.offer.price}</td>
  
  componentWillReceiveProps: (nextProps)->
    @setState 
      priceChanged: nextProps.offer.price isnt @props.offer.price

  _getClassName: ->
    React.addons.classSet
      offer: true
      change: @state.priceChanged

  componentDidUpdate: (prevProps, prevState) ->
   if @state.increasing or @state.decreasing
     ReactTransitionEvents.addEndEventListener @getDOMNode(), @onTransitionEnd

  componentWillUnmount: ->
    ReactTransitionEvents.removeEndEventListener @getDOMNode(), @onTransitionEnd

  onTransitionEnd: ->
    @getDOMNode().classList.remove 'priceChanged'
    true    

module.exports = Offer
