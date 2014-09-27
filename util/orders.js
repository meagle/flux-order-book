var MAX_REQUESTS, Promise, fs, ordersUrl, request;

Promise = require('bluebird');
var sleep = require('sleep');

request = Promise.promisify(require('request'));

fs = require('fs');

ordersUrl = 'https://www.theice.com/realtime/DollarsRealTime.action?snapshot=&_1410543671465&marketNames%5B%5D=dollars_usdx_1&marketNames%5B%5D=dollars_usdx_2&marketNames%5B%5D=dollars_usdx_3&referenceMarketName=reuters_dx_index&marketNames%5B%5D=russell_2000_mini_primary&marketNames%5B%5D=russell_2000_mini_secondary&marketNames%5B%5D=russell_2000_mini_spread&marketNames%5B%5D=russell_1000_mini_primary&marketNames%5B%5D=russell_1000_mini_secondary&marketNames%5B%5D=russell_1000_mini_spread';

MAX_REQUESTS = 100;

module.exports = {
  generateOrderBookData: function() {
    var fileStream = fs.createWriteStream('order_book_snapshots.json');
    fileStream.write('[');

    var promise = new Promise(function (resolve, reject) {
      var requests = [];
      for (var i = 1; i <= MAX_REQUESTS; i++) {
        (function (i) {
          setTimeout(function () {
            console.log('i', i);
            requests.push(request(ordersUrl));
            if (i === MAX_REQUESTS) resolve(requests);
          }, i * 1000)
        }(i))
      }
    });

    promise.then(function (promises) {
      Promise.all(promises).then(function(responses){
        console.log('responses', responses);
        for(var i=0; i < responses.length; i++) {
          console.log('RESPONSE:', responses[i][1]);
          fileStream.write(responses[i][1]);
          if(i < responses.length - 1)
            fileStream.write(',');
        }
        fileStream.write(']');
      });
    });
  },

  getMockOrderBookData: function() {
    orderBookJSON = require('../order_book_snapshots.json');
    for(var i=0; i < 100; i++)
      console.log(orderBookJSON[i].markets[1].stats.orders[0]);
  }
};