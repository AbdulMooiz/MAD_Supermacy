const express = require('express');
const router = express.Router();
const Bus = require('../models/Bus');

// GET all buses
router.get('/', async (req, res) => {
  try {
    const buses = await Bus.find();
    res.json(buses);
  } catch (err) {
    console.error('Error getting buses:', err);
    res.status(500).json({ message: 'Server error' });
  }
});

// GET a single bus by id
router.get('/:id', async (req, res) => {
  try {
    const bus = await Bus.findById(req.params.id);
    if (!bus) {
      return res.status(404).json({ message: 'Bus not found' });
    }
    res.json(bus);
  } catch (err) {
    console.error('Error getting bus:', err);
    res.status(500).json({ message: 'Server error' });
  }
});

// POST create a new bus
router.post('/', async (req, res) => {
  try {
    const { name, route, latitude, longitude, speed, isActive } = req.body;

    const bus = new Bus({
      name,
      route,
      latitude,
      longitude,
      speed,
      isActive,
    });

    const savedBus = await bus.save();
    res.status(201).json(savedBus);
  } catch (err) {
    console.error('Error creating bus:', err);
    res.status(400).json({ message: 'Invalid data' });
  }
});

// PUT update bus location (latitude, longitude, speed, isActive)
router.put('/:id/location', async (req, res) => {
  try {
    const { latitude, longitude, speed, isActive } = req.body;
    const bus = await Bus.findById(req.params.id);

    if (!bus) {
      return res.status(404).json({ message: 'Bus not found' });
    }

    if (latitude !== undefined) bus.latitude = latitude;
    if (longitude !== undefined) bus.longitude = longitude;
    if (speed !== undefined) bus.speed = speed;
    if (isActive !== undefined) bus.isActive = isActive;

    bus.lastUpdated = new Date();

    const updatedBus = await bus.save();
    res.json(updatedBus);
  } catch (err) {
    console.error('Error updating bus:', err);
    res.status(400).json({ message: 'Invalid data' });
  }
});

module.exports = router;