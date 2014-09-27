React = require 'react'
App = require './components/App'

require('react-raf-batching').inject()

React.renderComponent <App/>, document.getElementById('order-book')

# For React Developer Tools
window.React = React