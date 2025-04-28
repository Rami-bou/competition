const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');

// Initialize Firebase Admin SDK
const serviceAccount = require('./medic_key.json');  // <-- Make sure you downloaded it!

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
const app = express();
app.use(cors());
app.use(express.json()); // For parsing application/json

const PORT = process.env.PORT || 3000;

// Collections:
// - Admins
// - Hospitals
// - DSPs
// - APCs

// Add Admin
app.post('/addAdmin', async (req, res) => {
  try {
    const { name, email } = req.body;
    const docRef = await db.collection('Admins').add({ name, email, createdAt: admin.firestore.FieldValue.serverTimestamp() });
    res.status(201).send({ id: docRef.id, message: 'Admin added' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Add Hospital
app.post('/addHospital', async (req, res) => {
  try {
    const { name, location, email } = req.body;
    const docRef = await db.collection('Hospitals').add({ name, location, email, createdAt: admin.firestore.FieldValue.serverTimestamp() });
    res.status(201).send({ id: docRef.id, message: 'Hospital added' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Add DSP
app.post('/addDSP', async (req, res) => {
  try {
    const { name, region } = req.body;
    const docRef = await db.collection('DSPs').add({ name, region, createdAt: admin.firestore.FieldValue.serverTimestamp() });
    res.status(201).send({ id: docRef.id, message: 'DSP added' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Add APC
app.post('/addAPC', async (req, res) => {
  try {
    const { name, area } = req.body;
    const docRef = await db.collection('APCs').add({ name, area, createdAt: admin.firestore.FieldValue.serverTimestamp() });
    res.status(201).send({ id: docRef.id, message: 'APC added' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
