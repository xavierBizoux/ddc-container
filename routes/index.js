var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/ddc', function(req, res, next) {
  res.render('index', { title: 'Node SAS DDC' });
});

module.exports = router;
