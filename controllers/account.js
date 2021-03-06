var pool    = require('../config/database.js');
var express = require('express');
var multer  =   require('multer');
var router  = express.Router();
var async     = require('async');
var http    = require('http');
var moment    = require('moment');

var storage =   multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, 'public/uploads');
  },
  filename: function (req, file, callback) {
    var datenow = Date.now();
    var final = file.fieldname + datenow + req.session.user;
    callback(null, final);

    pool.getConnection(function( err, connection ) {
      if (err) {
        console.log('err getconnexion imageadd');
        res.sendStatus( 500 ); callback(null, 3); return ;
      }
      connection.query("INSERT INTO images (user, img) VALUES(?, ?)",  [ req.session.user, final ],  function(err, rows) {
        if (err) {
          console.log('err connexion query account#addimage' + err);
        }
        else {
          console.log('success account#addimage');
        }
      })

      connection.query("UPDATE users SET picture = ? WHERE id = ?", [ final, req.session.user ], function (err, rows) {
        if (err)
          console.log('err update user picture ACCOUNT');
        else
          console.log('picture user updated ACCOUNT')
      });

      connection.release();
    });
  }
});
var upload = multer({ storage : storage}).single('userPhoto');

/**
 * Display Account Page
**/
router.get('/', function(req, res) {
  async.parallel([
    // USER - PART 1 du parallel
    function( callback ) {
      pool.getConnection(function( err, connection ) {
        if ( err ) {  callback( true ); return ; }

        connection.query("SELECT * FROM users WHERE id = ?", [ req.session.user ],  function( err, rows ) {
          if (err) { connection.release(); callback( true ); return ; }

          if (rows[0].picture !== null) {
            connection.query("SELECT * FROM images WHERE id = ?", [ rows[0].picture ],  function( error, rows2 ) {
              if (!error && rows2.length > 0) {
                rows[0].picture = rows2[0].img;

                connection.release();
                callback( false, rows[0] );
              } else {
                connection.release();
                callback( false, rows[0] );
              }
            });
          }
          else {
          connection.release();
          callback( false, rows[0] );
          }
        });
      });
    },
    // TAGS - PART 2 du parallel
    function( callback ) {
      pool.getConnection(function( err, connection ) {
        if ( err ) { callback( true ); return ; }

        connection.query("SELECT * FROM user_tags WHERE user = ?", [ req.session.user ],  function( err, rows ) {
          if (err) { connection.release(); callback( true ); return ; }

          var tags = [];

          if ( rows.length > 0 ) {
            async.each(rows, function (item, callback) {
              connection.query("SELECT * FROM tags WHERE name = ?", [ item.tag ],  function( err, rows2 ) {
                if (err) { console.log(err); connection.release(); callback( true ); return ; }

                if ( rows2.length > 0 ) {
                  tags.push( { id: rows2[0].id, name: rows2[0].name } );
                  callback();
                }
              });
            }, function (err) {
              connection.release();

              if ( err )
                callback( true );
              else
                callback( false, tags );
            });
          } else {
            connection.release();
            callback( false, tags );
          }
        });
      });
    },
    // TAGS - PART 2.1 - GET ALL TAGS
    function ( callback ) {
      pool.getConnection(function( err, connection ) {
        if ( err ) {  callback( true ); return ; }
        
        connection.query("SELECT * FROM tags",  function( err, rows ) {
          if (err) { connection.release(); callback( true ); return ; }
          
          connection.release();
          callback( false, rows );
        });
      });
    },
    // IMAGES - PART 3 du parallel (get user's image)
    function( callback ) {
      pool.getConnection(function( err, connection ) {
        if ( err ) {  console.log('err account#get#part3'); callback( true ); return ; }

        // Get information to build the user data
        connection.query("SELECT * FROM images WHERE user = ?", [ req.session.user ],  function( err, rows ) {
          if (err) { connection.release(); callback( true ); return ; }

          connection.release();
          callback( false, rows );
        });
      });
    }
    ],
    function( err, results ) {
      // si y'a UNE erreur (callback en true) dans les trois functions au dessus, alors erreur ici.
      // Les callbacks de chaque fonction au dessus doivent etre en false.
      if( err ) { res.sendStatus(500); return; }
      results[0].register_date = moment(results[0].register_date).format("MMMM Do YYYY");
      res.render('account', {
        title: 'Account',
        user: results[0],
        tags: results[1],
        all_tags: results[2],
        images: results[3],
        connected: req.session.user !== undefined
      });
    }
  );
});

router.post('/', function(req, res) {
  var mail = req.body.email, firstname = req.body.firstname, lastname = req.body.lastname, gender = req.body.gender, bio = req.body.bio, orientation = req.body.orientation, age = req.body.age
  if (mail == undefined || firstname == undefined || lastname == undefined || gender == undefined || orientation == undefined || age == undefined) {
    console.log("un champ vide account#post");
    res.render('account', {title: "Account", error: "Fill all fields !", connected: req.session.user !== undefined});
    return ;
  }

  async.series([
    function(callback) { 
      pool.getConnection(function( err, connection ) {
        if (err) {
          console.log('err getconnexion account#update1');
          res.sendStatus( 500 ); callback(null, 1); return ;
        }
        connection.query("UPDATE users SET mail=?, firstname=?, lastname=?, gender=?, bio=?, orientation=?, age=? WHERE id = ?",  [ mail, firstname, lastname, gender, bio, orientation, age, req.session.user ],  function(err, rows) {
          if (err) {
            console.log('err connexion query account#update1' + err);
            connection.release();
          }
          else {
            console.log('success account#update1');
            connection.release();
          }
          callback(null, 1);
        })
      });  
    },
    function(callback) { 
      pool.getConnection(function( err, connection ) {
        if (err) {
          console.log('err getconnexion account#update2');
          res.sendStatus( 500 ); callback(null, 2); return ;
        }
        connection.query("DELETE FROM user_tags WHERE user=?",  [ req.session.user ],  function(err, rows) {
          if (err) {
            console.log('err connexion query account#update2' + err);
            connection.release();
          }
          else {
            console.log('success account#update2');
            connection.release();
          }
          callback(null, 2);
        })
      });  
    },
    function(callback) { 
      if (req.body.tag_user) {
        pool.getConnection(function( err, connection ) {
          if (err) {
            console.log('err getconnexion account#update3');
            res.sendStatus( 500 ); callback(null, 3); return ;
          }
          if (!Array.isArray(req.body.tag_user)) {
              connection.query("INSERT INTO user_tags (user,tag) VALUES(?, ?)",  [ req.session.user, req.body.tag_user ],  function(err, rows) {
                if (err) {
                  console.log('err connexion query account#update3' + err);
                }
                else {
                  console.log('success account#update3 - un seul tag');
                }
              })
          } else {
            for(var i = 0; i < req.body.tag_user.length; i++) {
              connection.query("INSERT INTO user_tags (user,tag) VALUES(?, ?)",  [ req.session.user, req.body.tag_user[i] ],  function(err, rows) {
                if (err) {
                  console.log('err connexion query account#update3' + err);
                }
                else {
                  console.log('success account#update3 - plusieurs tags');
                }
              })
            }
          }
          connection.release();
          callback(null, 3);
        });  
      }
      res.redirect('account');
    }
  ]);
});

// ADD image
router.post('/image/add',function(req,res){
  pool.getConnection(function( err, connection ) {
    if (err) {
      console.log('err getconnexion account#image_add');
      res.sendStatus( 500 ); callback(null, 3); return ;
    }
    connection.query("SELECT * FROM images WHERE user = ?",  [ req.session.user ],  function(err, rows) {
      if (err) {
        console.log('err connexion query account#image_add' + err);
      }
      else if ( rows.length >= 2) {
        console.log('deja deux images user account');
        res.redirect('/account');
        return ;
      }
      upload(req,res,function(err) {
        if(err) {
            return console.log(err);
        }
        console.log('upload image_add good');
        res.redirect('/account');
        return ;
      });
    })
    connection.release();
  });  
});

// Alerts
router.get('/alert', function( req, res ) {
   
   pool.getConnection(function( err, connection ) {
    if ( err ) { res.sendStatus( 500 ); return ; }
      
    connection.query("SELECT * FROM user_alerts WHERE visitor = ? ORDER BY displayed,date DESC LIMIT 20", [ req.session.user ], function ( err, rows ) {
      
      for(var i = 0; i < rows.length; i++) {
        rows[i].date = moment(rows[i].date).fromNow();
      }
      res.send(rows);
    });
    
    connection.release();
  });
});

router.post('/image/first', function(req, res) {
  var first_picture = req.body.picture_name;

   pool.getConnection(function( err, connection ) {
    if ( err ) { res.sendStatus( 500 ); return ; }
    connection.query("UPDATE users SET picture = ? WHERE id = ?", [ first_picture, req.session.user ], function (err, rows) {
      if (err){
        console.log('err update user first_picture ACCOUNT');
        res.sendStatus(500);
      }
      else{
        console.log('first_picture user updated ACCOUNT');
        res.sendStatus(200);
      }
    });
    connection.release();
    return;
  });
});

router.post('/image/delete', function(req, res) {
  var delete_picture = req.body.picture_name;

   pool.getConnection(function( err, connection ) {
    if ( err ) { res.sendStatus( 500 ); return ; }
    connection.query("DELETE FROM images WHERE img = ? AND user = ?", [ delete_picture, req.session.user ], function (err, rows) {
      if (err){
        console.log('err update user first_picture ACCOUNT');
        res.sendStatus(500);
      }
      else{
        console.log('first_picture user updated ACCOUNT');
        res.sendStatus(200);
      }
    });
    connection.release();
    return;
  });
});

module.exports = router;