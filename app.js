
/**
 * Module dependencies.
 */

var express = require('express');

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyDecoder());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.staticProvider(__dirname + '/public'));
});

app.configure('development', function(){
  PORT = process.env.PORT || 3000;
  FB_APP_ID='114140975331019'; // localhost
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 
});

app.configure('staging', function(){
  PORT = process.env.PORT || 80;
  FB_APP_ID='196846820339657'; // AWS
  app.use(express.errorHandler()); 
});

app.configure('production', function(){
  PORT = process.env.PORT || 80;
  FB_APP_ID='144378295625951'; // Joyent
  app.use(express.errorHandler()); 
});

// Routes

app.get('/', function(req, res){
  res.render('index', {
    locals: {
      title: 'jwalsh.no.de',
      fb_app_id: FB_APP_ID
    }
  });
});

// Only listen on $ node app.js

if (!module.parent) {
  app.listen(PORT);
  console.log("Express server listening on port %d", app.address().port)
}
