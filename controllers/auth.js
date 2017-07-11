var pool    = require('../config/database.js');
var bcrypt    = require('bcryptjs');
var salt    = bcrypt.genSaltSync(10);
var express = require('express');
var router  = express.Router();
var mailsender  = require('./mail.js');

  /**
   *  Signup 
  **/
  router.get('/signup', function(req, res) {
    if (req.session.user !== undefined){
      res.redirect('/');
    } else {
      res.render('signup', {
        title: "Signup",
        connected: req.session.user !== undefined
      });
    }
  });

  router.post('/signup', function(req, res) {
    var mail = req.body.email, username = req.body.username, pwd = req.body.password, r_pwd = req.body.r_password, firstname = req.body.firstname, lastname = req.body.lastname;

    // Si un champ est undefined
    if (mail == undefined || username == undefined || pwd == undefined || r_pwd == undefined || firstname == undefined || lastname == undefined) {
      console.log("un champ vide signup");
      res.sendStatus(400); return ;
    }

    // Si les deux pwd ne match pas
    if (pwd !== r_pwd) {
      console.log("pwd not match signup");
      res.render('signup', {title: "Signup", error: "Password don't match !", connected: req.session.user !== undefined});
      return ;
    }

    pool.getConnection(function(err, connection) {
      if (err) {
        console.log("error connexion pool signup");
        res.sendStatus(500); return ;
      }

      connection.query("SELECT * FROM users WHERE mail = ?",  [mail],  function(err, rows) {
        if (err || rows.length > 0) {
          console.log("mail deja dans db signup");
          res.render('signup', {title: "Signup", error: "Mail already exists in DB !", connected: req.session.user !== undefined});
          connection.release();
          return ;
        } else {
          var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
            return v.toString(16);
          });
          connection.query("INSERT INTO users (id, mail, username, password, firstname, lastname, status) VALUES (?, ?, ?, ?, ?, ?, ?)", 
          [uuid, mail, username, bcrypt.hashSync(pwd, salt), firstname, lastname, 'CONFIRMED'], function (err, rows) {
            if (err) {
              console.log("Erreur INSERT signup");
              console.log(err);
              // res.sendStatus(500);
            } 
            else {
              console.log("Success SIGNUP");
              req.session.user = uuid;
              // res.sendStatus(200);
            }
            connection.release();
            res.redirect('/');
          });
        }
      });
    });
  });

  /**
   *  Signin 
  **/
  router.get('/signin', function(req, res) {
    if (req.session.user !== undefined){
      res.redirect('/');
    } else {
      res.render('signin', {
        title: "Signin",
        connected: req.session.user !== undefined
      });
    }
  });

  router.post('/signin', function(req, res) {
    var username = req.body.username, pwd = req.body.password
    // Si un des deux champs est undefined
    if (username == undefined || pwd == undefined) {
      console.log("champ vide SIGNIN");
      res.render('signin', {title: "Signin", error: "Fields empty", connected: req.session.user !== undefined});
      return ;
    }

    pool.getConnection(function(err, connection) {
      if (err) {
        console.log("erreur connexion pool signin");
        res.sendStatus(500); return ;
      }

      connection.query("SELECT * FROM users WHERE username = ?", [ username ],  function(err, rows) {
        if (err || rows.length == 0) {
          console.log('username not in DB ! signin');
          res.render('signin', {title: "Signin", error: "User not in DB !", connected: req.session.user !== undefined});
          connection.release();
          return ;      
        }

        var state = bcrypt.compareSync( pwd, rows[0].password );
        
        if (state) {
          console.log("logged succes signin");
          req.session.user = rows[0].id;
          connection.release();
        } else {
          console.log("mdp incorrect signin");
          res.render('signin', {title: "Signin", error: "Incorrect password !", connected: req.session.user !== undefined});
          connection.release();
          return;
        }
        res.redirect('/');
      });
    });
  });

  /**
   * Receive logout request
  **/
  router.get('/signout', function(req, res) {  
    pool.getConnection(function (err, connection) {
      if ( !err ) {
        connection.query("UPDATE users SET last_visit = NOW() WHERE id = ?", [ req.session.user ], function(err, rows) {});
       }
      req.session.destroy(function(err) {
        res.redirect('/');
      });
      connection.release();
    });
  });

  /**
   * Reset PWD
  **/
  router.get('/reset', function(req, res) {
    res.render('reset', {
      title: "Forgot password",
      connected: req.session.user !== undefined
    });
  });

  router.post('/reset', function(req, res) {
    var mail = req.body.email

    if (mail == undefined) {
      console.log("un champ vide reset");
      res.sendStatus(400); return ;
    }

    pool.getConnection(function(err, connection) {
      if (err) {
        console.log("error connexion pool reset");
        res.sendStatus(500); return ;
      }
      connection.query("SELECT * FROM users WHERE mail = ?",  [ mail ],  function(err, rows) {
        if (rows.length == 0) {
          console.log("mail inexistant reset");
          res.sendStatus(404);
        } else { 
          var pwd = Math.random().toString(36).slice(2);

          let mailOptions = {
              from: '"❤️ Matcha42" <jkeuleyamatcha@gmail.com>', // sender address
              to: rows[0].mail, // list of receivers
              subject: '🔧 Reset your password !', // Subject line
              text: "🚷 Hello ! Here's your new password : " + pwd // plain text body
              // html: '<b>Hello world ?</b>' // html body
          };

          mailsender.sendMail(mailOptions, (error, info) => {
              if (error) {
                  return console.log(error);
              }
              console.log('Message %s sent: %s', info.messageId, info.response);
          });

          res.redirect('/');

          connection.query("UPDATE users SET password = ? WHERE id = ?", [ bcrypt.hashSync(pwd, salt), rows[0].id ], function (err, rows) {});
        }
        connection.release();
      })
    });
  });

module.exports = router;