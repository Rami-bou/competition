const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');

const crypto = require('crypto');


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
    const { name, email, password } = req.body;
    const docRef = await db.collection('Admins').add({ name, email, password, createdAt: admin.firestore.FieldValue.serverTimestamp() });
    res.status(201).send({ id: docRef.id, message: 'Admin added' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});


// Add Hospital
app.post('/addHospital', async (req, res) => {
  try {
    const { name, location, email, password } = req.body;
    const docRef = await db.collection('Hospitals').add({ name, location, email, password, createdAt: admin.firestore.FieldValue.serverTimestamp() });
    res.status(201).send({ id: docRef.id, message: 'Hospital added' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});


// List of hospit
app.get('/getHospitals', async (req, res) => {
  try {
    const snapshot = await db.collection('Hospitals').get();
    const hospitals = snapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    }));
    res.status(200).json(hospitals);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



// Get a hospital by id
app.get('/getHospital/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const doc = await db.collection('Hospitals').doc(id).get();
    if (!doc.exists) {
      res.status(404).json({ error: 'Hospital not found' });
    } else {
      res.status(200).json({ id: doc.id, ...doc.data() });
    }
  } catch (error) {
    console.error('Error getting hospital:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Upadte a hospital infos
app.put('/updateHospital/:id', async (req, res) => {
  const { id } = req.params;
  const { name, location, email, phone } = req.body;
  try {
    const hospitalRef = db.collection('Hospitals').doc(id);
    const hospital = await hospitalRef.get();
    if (!hospital.exists) {
      res.status(404).json({ error: 'Hospital not found' });
    } else {
      await hospitalRef.update({
        name,
        location,
        email,
        phone,
      });
      res.status(200).json({ id, name, location, email, phone });
    }
  } catch (error) {
    console.error('Error updating hospital:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Delete a hospital
app.delete('/deleteHospital/:id', async (req, res) => {
  try {
    await db.collection('Hospitals').doc(req.params.id).delete();
    res.status(200).json({ message: 'Hospital deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
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


// List of DSPs
app.get('/getDSPList', async (req, res) => {
  try {
    const snapshot = await db.collection('DSPs').get();

    const dsps = [];
    snapshot.forEach(doc => {
      dsps.push({ id: doc.id, ...doc.data() });
    });

    res.status(200).json(dsps);

  } catch (error) {
    console.error('Error getting DSPs list:', error);
    res.status(500).json({ error: 'Internal server error' });
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


// List of APCs
app.get('/getAPCList', async (req, res) => {
  try {
    const snapshot = await db.collection('APCs').get();

    const apcs = [];
    snapshot.forEach(doc => {
      apcs.push({ id: doc.id, ...doc.data() });
    });

    res.status(200).json(apcs);

  } catch (error) {
    console.error('Error getting APCs list:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


// Add Death Record (Signed by the Hospital)
app.post('/addDeathRecord', async (req, res) => {
  const { patientName, dateOfDeath, causeOfDeath, hospitalId } = req.body;

  try {
    // Create a hash of the record (representing the hospital's signature)
    const hash = crypto.createHash('sha256').update(`${patientName}${dateOfDeath}${causeOfDeath}${hospitalId}`).digest('hex');
    
    const newDeathRecord = {
      patientName,
      dateOfDeath,
      causeOfDeath,
      hospitalId,
      hash,
      status: 'pending', // Not verified by DSP yet
      createdAt: new Date(),
    };

    // Add to the DeathRecords collection
    const docRef = await db.collection('DeathRecords').add(newDeathRecord);
    res.status(201).json({ id: docRef.id, ...newDeathRecord });
  } catch (error) {
    console.error('Error adding death record:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Get all Death records
app.get('/getDeathRecords', async (req, res) => {
  try {
    const snapshot = await db.collection('DeathRecords').get();
    const deathRecords = [];
    snapshot.forEach(doc => {
      deathRecords.push({ id: doc.id, ...doc.data() });
    });
    res.status(200).json(deathRecords);
  } catch (error) {
    console.error('Error getting death records:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


// Verify a death record (by DSP)

app.put('/verifyDeathRecord/:id', async (req, res) => {
  const { id } = req.params;
  const { dspId, verificationCode } = req.body; // DSP verifies using some code or method

  try {
    // Get the death record by ID
    const deathRecordRef = db.collection('DeathRecords').doc(id);
    const deathRecord = await deathRecordRef.get();

    if (!deathRecord.exists) {
      return res.status(404).json({ error: 'Death record not found' });
    }

    // Update the death record to verified by DSP
    await deathRecordRef.update({
      status: 'verified',
      verifiedBy: dspId,
      verificationCode, // Store DSP's verification code or other verification method
      verifiedAt: new Date(),
    });

    res.status(200).json({ message: 'Death record verified successfully' });
  } catch (error) {
    console.error('Error verifying death record:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


// Add Birth Record (Signed by the Hospital)
app.post('/addBirthRecord', async (req, res) => {
  const { babyName, dateOfBirth, motherName, hospitalId } = req.body;

  try {
    // Create a hash of the record (representing the hospital's signature)
    const hash = crypto.createHash('sha256').update(`${babyName}${dateOfBirth}${motherName}${hospitalId}`).digest('hex');
    
    const newBirthRecord = {
      babyName,
      dateOfBirth,
      motherName,
      hospitalId,
      hash,
      status: 'pending', // Not verified by DSP yet
      createdAt: new Date(),
    };

    // Add to the BirthRecords collection
    const docRef = await db.collection('BirthRecords').add(newBirthRecord);
    res.status(201).json({ id: docRef.id, ...newBirthRecord });
  } catch (error) {
    console.error('Error adding birth record:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


// Get all Birth Records
app.get('/getBirthRecords', async (req, res) => {
  try {
    const snapshot = await db.collection('BirthRecords').get();
    const birthRecords = [];
    snapshot.forEach(doc => {
      birthRecords.push({ id: doc.id, ...doc.data() });
    });
    res.status(200).json(birthRecords);
  } catch (error) {
    console.error('Error getting birth records:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


app.put('/verifyBirthRecord/:id', async (req, res) => {
  const { id } = req.params;
  const { dspId, verificationCode } = req.body; // DSP verifies using some code or method

  try {
    // Get the birth record by ID
    const birthRecordRef = db.collection('BirthRecords').doc(id);
    const birthRecord = await birthRecordRef.get();

    if (!birthRecord.exists) {
      return res.status(404).json({ error: 'Birth record not found' });
    }

    // Update the birth record to verified by DSP
    await birthRecordRef.update({
      status: 'verified',
      verifiedBy: dspId,
      verificationCode, // Store DSP's verification code or other verification method
      verifiedAt: new Date(),
    });

    res.status(200).json({ message: 'Birth record verified successfully' });
  } catch (error) {
    console.error('Error verifying birth record:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});









app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});