const mysql = require('mysql');

const pool = mysql.createPool({
  host     : 'sql8.freemysqlhosting.net',
  user     : 'sql8193488',
  password : 'qgFd53pbqg',
  database : 'sql8193488',
  port: '3306'
});

module.exports = pool;
