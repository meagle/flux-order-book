React = require 'react/addons'

Summary = React.createClass

  displayName: 'Summary'

  render: ->
    <div>
      <h3>{@props.summary.label} {@props.summary.stripName}</h3>
      <dl>
        <dt>Last</dt>
        <dd>
          <span>{@_getLastPrice()}</span>
          <span className={@_getClassName()}>{@_getChange()}</span>
        </dd>
        <dt>Settle</dt>
        <dd>{@_getSettlement()}</dd>
        <dt>Volume</dt>
        <dd>{@_getVolume()}</dd>
        <dt>High</dt>
        <dd>{@_getHigh()}</dd>
        <dt>Low</dt>
        <dd>{@_getLow()}</dd>
      </dl>
    </div>
  
  _getClassName: ->
    change = @_getChange()
    if change is '-'
      change = 0

    React.addons.classSet
      'last-price': true
      directionUp: change > 0
      directionDown: change < 0

  _getSettlement: ->
    @props.summary.settlement

  _getChange: ->
    settlement = @_getSettlement() or '-'
    lastPrice = @_getLastPrice()
    return '-' if (settlement is '-') or (lastPrice is '-')
    change = lastPrice - settlement
    change.toFixed 2

  _getLastPrice: ->
    return '-' unless @props.summary.last
    @props.summary.last

  _getVolume: ->
    return '-' unless @props.summary.volume
    @props.summary.volume

  _getHigh: ->
    return '-' unless @props.summary.high
    @props.summary.high

  _getLow: ->
    return '-' unless @props.summary.low
    @props.summary.low


module.exports = Summary
