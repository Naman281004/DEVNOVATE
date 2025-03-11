const express = require('express');
const bodyParser = require('body-parser');
const userRoute = require('./routes/user')

const app = express();

// middleware
app.use(express.json());
app.use(bodyParser.json());

// Routes
app.use('/api/user', userRoute);

// Root route
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Event Platform API' });
});

module.exports = app;
