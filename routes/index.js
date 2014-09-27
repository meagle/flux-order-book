var express           = require('express');
var router            = express.Router();
var orderUtil         = require('../util/orders')

/* GET home page. */
router.get('/generateorders', function(req, res) {
  orderUtil.generateOrderBookData();
  res.render('index', { title: 'Flux Order Book Demo' });
});

router.get('/', function(req, res) {
  res.render('index', { title: 'Flux Order Book Demo' });
});

module.exports = router;
