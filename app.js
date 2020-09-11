var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');

const config = require('./config.js');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(config.baseUrl, express.static(path.join(__dirname, 'public')));
app.use(config.baseUrl + '/javascripts/bootstrap', express.static(path.join(__dirname, '/node_modules/bootstrap/dist/js'))); // redirect bootstrap JS
app.use(config.baseUrl + '/javascripts/jquery', express.static(path.join(__dirname, '/node_modules/jquery/dist'))); // redirect JS jQuery
app.use(config.baseUrl + '/javascripts/popper', express.static(path.join(__dirname, '/node_modules/popper.js/dist'))); // redirect Popper JS
app.use(config.baseUrl + '/javascripts/sas', express.static(path.join(__dirname, '/libs/sas-visualanalytics-thirdpartyvisualizations')));
app.use(config.baseUrl + '/stylesheets/bootstrap', express.static(path.join(__dirname, '/node_modules/bootstrap/dist/css'))); // redirect CSS bootstrap

app.use(config.baseUrl, indexRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
