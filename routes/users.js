var express = require('express');
var dummy = require('dummy-json');
var fs = require('fs');

var router = express.Router();

router.get('/:numberOfPeople', function(req, res) {
  var template = fs.readFileSync('./templates/dummy-connections.hbs', {encoding: 'utf8'});
  var result = dummy.parse(template, {data: {numberOfPeople: req.params.numberOfPeople}});
  res.send(result);
});

router.get('/', function(req, res) {
  var template = fs.readFileSync('./templates/dummy-connections.hbs', {encoding: 'utf8'});
  var result = dummy.parse(template, {data: {numberOfPeople: 750}});
  res.set('Content-Type', 'application/json');
  res.send(JSON.parse(result));
});

module.exports = router;
