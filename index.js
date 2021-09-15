var express = require('express')
var app = express()
var httpProxy = require('http-proxy')
//var port = process.env.PORT || 5000;

app.set('port', (process.env.PORT || 5000))
app.use(express.static(__dirname + '/public'))

app.get('/', function(request, response) {
  response.send('Owl-View')
})

app.listen(app.get('port'), function() {
  console.log("Node app is running at localhost:" + app.get('port'))
})


//var port = process.env.PORT || 5000;

var routing = {
'/api': { port: process.env.DEVICES_PORT || 80, host: cn-node-prod-app.herokuapp.com }
}

var server = httpProxy.createServer(
require('./lib/uri-middleware')(routing)
).listen(5000);

//Mongoose Settings
//-----------------------------------------
// const {User} = require("./models");
// const mongoose = require("mongoose");

// console.log("mongoose stuff intialized");

// app.use((req, res, next) => {
//  console.log("use for mongoose callback");
//  if (mongoose.connection.readyState) {
//    console.log("if (mongoose.connection.readyState)");
//    next();
//  } else {
//    console.log("else (mongoose.connection.readyState)");
//    require("./mongo")().then(() => next());
//    console.log("else (mongoose.connection.readyState)");
//  }
//});*//

