const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const Bus = require('./models/Bus');
const busRoutes = require('./routes/busRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // Parse JSON bodies

// API routes
app.use('/api/buses', busRoutes);

// Simple home route
app.get('/', (req, res) => {
  res.send('Bus Tracker API is running');
});

// Connect to MongoDB and start server
const PORT = process.env.PORT || 5000;
const MONGO_URI = process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/bus_tracker';

mongoose
  .connect(MONGO_URI)
  .then(async () => {
    console.log('Connected to MongoDB');
    await seedInitialBuses();

    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  })
  .catch((err) => {
    console.error('MongoDB connection error:', err);
  });

// Seed DB with some sample buses if empty
async function seedInitialBuses() {
  try {
    const count = await Bus.countDocuments();
    if (count === 0) {
      await Bus.insertMany([
        {
          name: 'City Bus 1',
          route: 'Route A',
          latitude: 37.7749,
          longitude: -122.4194,
          speed: 35,
        },
        {
          name: 'City Bus 2',
          route: 'Route B',
          latitude: 37.7849,
          longitude: -122.4094,
          speed: 28,
        },
        {
          name: 'City Bus 3',
          route: 'Route C',
          latitude: 37.7649,
          longitude: -122.4294,
          speed: 42,
        },
      ]);

      console.log('Seeded initial buses into database.');
    } else {
      console.log('Database already has buses, skipping seeding.');
    }
  } catch (err) {
    console.error('Error seeding initial buses:', err);
  }
}