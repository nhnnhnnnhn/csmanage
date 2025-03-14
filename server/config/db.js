const sql = require('mssql');
require('dotenv').config();

const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  options: {
    encrypt: false,
    enableArithAbort: true,
    trustServerCertificate: true,
    connectionTimeout: 30000
  },
  port: 1433
};

const poolPromise = new sql.ConnectionPool(config)
  .connect()
  .then(pool => {
    console.log('Kết nối database thành công!');
    return pool;
  })
  .catch(err => {
    console.error('Lỗi kết nối database:', err);
  });

module.exports = {
  sql,
  poolPromise
}; 