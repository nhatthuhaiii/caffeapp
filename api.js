// server.js
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();

// Enable CORS
app.use(cors());
app.use(express.json());

// Database connection
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'database_caffe'
});

// Test connection
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to database:', err);
    return;
  }
  console.log('Connected to MySQL database');
});

// GET all products
app.get('/api/products', (req, res) => {
  const query = 'SELECT * FROM products';
  connection.query(query, (error, results) => {
    if (error) {
      res.status(500).json({ error: error.message });
      return;
    }
    res.json(results);
  });
});

// GET product by id
app.get('/api/products/:id', (req, res) => {
  const query = 'SELECT * FROM products WHERE id = ?';
  connection.query(query, [req.params.id], (error, results) => {
    if (error) {
      res.status(500).json({ error: error.message });
      return;
    }
    if (results.length > 0) {
      res.json(results[0]);
    } else {
      res.status(404).json({ message: 'Product not found' });
    }
  });
});

// POST new product
app.post('/api/products', (req, res) => {
  const { name, price, description, image } = req.body;
  const query = 'INSERT INTO products (name, price, description, image) VALUES (?, ?, ?, ?)';
  connection.query(query, [name, price, description, image], (error, results) => {
    if (error) {
      res.status(500).json({ error: error.message });
      return;
    }
    res.status(201).json({ id: results.insertId, ...req.body });
  });
});

// PUT update product
app.put('/api/products/:id', (req, res) => {
  const { name, price, description, image } = req.body;
  const query = 'UPDATE products SET name = ?, price = ?, description = ?, image = ? WHERE id = ?';
  connection.query(query, [name, price, description, image, req.params.id], (error) => {
    if (error) {
      res.status(500).json({ error: error.message });
      return;
    }
    res.json({ id: req.params.id, ...req.body });
  });
});

// DELETE product
app.delete('/api/products/:id', (req, res) => {
  const query = 'DELETE FROM products WHERE id = ?';
  connection.query(query, [req.params.id], (error) => {
    if (error) {
      res.status(500).json({ error: error.message });
      return;
    }
    res.json({ message: 'Product deleted successfully' });
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});