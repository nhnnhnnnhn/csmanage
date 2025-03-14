const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

const routes = require('./routes');

const app = express();
const PORT = process.env.PORT || 5001;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Đăng ký routes
app.use('/api', routes);

// Xử lý lỗi
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Lỗi server!', error: err.message });
});

// Khởi động server
const server = app.listen(PORT, () => {
  console.log(`Server đang chạy trên cổng ${PORT}`);
}).on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.log(`Cổng ${PORT} đã được sử dụng, thử cổng ${parseInt(PORT) + 1}`);
    app.listen(parseInt(PORT) + 1, () => {
      console.log(`Server đang chạy trên cổng ${parseInt(PORT) + 1}`);
    });
  } else {
    console.error('Lỗi khởi động server:', err);
  }
}); 