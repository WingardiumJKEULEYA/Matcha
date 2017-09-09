var express = require('express');
var session = require('express-session');
var sharedsession   = require("express-socket.io-session");
var morgan      = require('morgan');
var compression   = require('compression');
var fs      = require('fs');
var app     = express();
var server  = require('http').Server(app);
var io      = require('socket.io')(server);
var events      = require('./config/event');

// Routes
var index   = require('./controllers/index');
var auth    = require('./controllers/auth');
var account    = require('./controllers/account');
var suggestions = require('./controllers/suggestions');
var search = require('./controllers/search');
var profile = require('./controllers/profile');
var user  = require('./controllers/user');
var map = require('./controllers/map');
var bugs = require('./controllers/bugs')

// Views
app.set('view engine', 'ejs')
.set('views', __dirname + '/views')
.set('trust_proxy', 1)

// Static
.use(express.static(__dirname + '/public'))
.use(express.static(__dirname + '/uploads'))

// Logger
app.use(morgan('dev'))

// Compression
app.use(compression())

// Body parser
.use(require('body-parser').urlencoded({ extended: true }))

// Session
var session_setup = session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true
});

app.use(session_setup)

// Utilisation routes
.use('/', index)
.use('/auth', auth)
.use('/search', function(req, res, next) {
  if (req.session.user == undefined) 
    res.redirect("/auth/signin");
  else
    next();
}, search)
.use('/account', function(req, res, next) {
  if (req.session.user == undefined) 
    res.redirect("/auth/signin");
  else
    next();
}, account)
.use('/map', function(req, res, next) {
  if (req.session.user == undefined) 
    res.redirect("/auth/signin");
  else
    next();
}, map)
.use('/suggestions', function(req, res, next) {
  if (req.session.user == undefined) 
    res.redirect("/auth/signin");
  else
    next();
}, suggestions)
.use('/profile', function(req, res, next) {
  if (req.session.user == undefined) 
    res.redirect("/auth/signin");
  else
    next();
}, profile)
.use('/user', function(req, res, next) {
  if (req.session.user == undefined) 
    res.redirect("/auth/signin");
  else
    next();
}, user)
.use('/bugs', function(req, res, next) {
  if (req.session.user == undefined) 
    res.redirect("/auth/signin");
  else
    next();
}, bugs)
.use(function(req, res, next){
    res.redirect('/');
});

var users = {};

// SOCKETS
io.use(sharedsession(session_setup));
require('./controllers/socket')(io, users);

// EVENTS
require('./controllers/events')(users);

// WORKERS CRON
require('./controllers/workers');

server.listen(3000);

module.exports = events;
