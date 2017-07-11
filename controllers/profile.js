var express   = require('express');
var router    = express.Router();
var async     = require('async');
var pool    = require('../config/database.js');
var http    = require('http');
var moment    = require('moment');
var events    = require('../config/event');

  /**
   * Display Account page
  **/
router.get('/:id', function( req, res ) {
  var user = req.params.id;

  pool.getConnection(function( err, connection ) {
    async.parallel([
      function (callback) {
        // Premier callback : On recup l'utilisateur de l'user en params
        connection.query("SELECT * FROM users WHERE id = ?", [ user ],  function( err, rows ) {
          if (err || rows.length == 0) { connection.release(); console.log('err ou pas ID url PROFILE'); callback( true ); return ; }
          if (rows[0].picture !== undefined) {
            // S'il a une photo
            connection.query("SELECT * FROM images WHERE id = ?", [ rows[0].picture ],  function( error, rows2 ) {
              // Check si la photo est trouvee
              if (!error && rows2.length > 0) {
                rows[0].picture = rows2[0].img;   
                // Image ok - fin - callback
                callback( false, rows[0] );
              }
              else 
                callback( false, rows[0] );
            });
          }
          else {
            // Il n'a pas d'image - fin - callback
            callback( false, rows[0] );
          }
        });
      },
      function (callback) {
        // Deuxieme callback : On recup les tags (tjrs le meme user)
        connection.query("SELECT * FROM user_tags WHERE user = ?", [ user ],  function( err, rows ) {
          if (err) { console.log('err tags PROFILE'); callback( true ); return ; }
          var tags = [];
          if ( rows.length > 0 ) {
            // user a des tags
            async.each(rows, function (item, callback) {
              connection.query("SELECT * FROM tags WHERE name = ?", [ item.tag ],  function( err, rows2 ) {
                // Alors on va les prendre
                if (err) { console.log('err tags2 PROFILE'); callback( true ); return ; }
                if ( rows2.length > 0 ) {
                  // On push le tag dans le tableau "tags"
                  tags.push( { id: rows2[0].id, name: rows2[0].name } );
                  callback();
                }
              });
            }, function (err) {
              if ( err ) {
                console.log(err + " PROFILE #1")
                callback( true );
              }
              else
                callback( false, tags );
            });
          }
          else {
            // aucun tag - fin - callback
            callback( false, tags );
          }
        });
      },
      function (callback) {
        // Troisieme callback : On recupere les images tjrs du meme user
        connection.query("SELECT * FROM images WHERE user = ?", [ user ],  function( err, rows ) {
          if (err) { console.log('err img PROFILE'); callback( true ); return ; }
          callback( false, rows );
        });
      },
      function (callback) {
        // Quatrieme callback : On va check si l'user est bloqué.
        connection.query("SELECT * FROM blocked_users WHERE blocked_target = ? AND user = ?", [ user, req.session.user ],  function( err, rows ) {
          if (err) { console.log('err blocked user PROFILE'); callback( true ); return ; }
          // est-il bloqué ?
          if (rows.length == 0) 
            callback( false, false );
          else
            callback ( false, true );  
        });
      },
      function (callback) {
        // Cinquieme callback : On check si le match est la
        connection.query("SELECT * FROM matchs WHERE match_target = ? AND user = ?", [ user, req.session.user ],  function( err, rows ) {
          if (err) { console.log('err matchs PROFILE'); callback( true ); return ; }
          // return the result
          if (rows.length == 0) 
            callback( false, false );
          else
            callback ( false, true ); 
        });
      }
    ],
    function(err, results) {
      // Callback Final
      if( err ) { console.log('err 500 final callback PROFILE'); res.sendStatus(500); return; }
      var no_moment = results[0].last_visit;
      results[0].last_visit = moment(results[0].last_visit).fromNow();
      results[0].register_date = moment(results[0].register_date).format("MMMM Do YYYY");

      res.render('profile', {
        title: results[0].firstname + "'s profile",
        user: results[0],
        tags: results[1],
        images: results[2],
        blocked: results[3],
        matched: results[4],
        no_moment: no_moment,
        connected: req.session.user !== undefined
      });
      // Last Visit
      connection.query("INSERT INTO visits (user, visit_target) VALUES (?, ?)", [ req.session.user, results[0].id ], function (err, rows) {});
      // Event de la visite
      events.emit('user_visit', req.session.user, user );
      connection.release();
    });
  });
});

module.exports = router;