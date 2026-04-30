// server.js

require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const { Parser } = require('json2csv');

const app = express();
app.use(cors());
app.use(express.json());

// --- 1. Connexion à MongoDB ---
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('MongoDB connecté'))
.catch(err => console.error('Erreur de connexion à MongoDB:', err));

// --- 2. Définition des modèles Mongoose ---

// Utilisateur (gestionnaire)
const userSchema = new mongoose.Schema({
  username: String,
  password: String, // en production, stocker un hash
});
const User = mongoose.model('User', userSchema);

// Réservation
const reservationSchema = new mongoose.Schema({
  nom: String,
  email: String,
  date: String,
  heure: String,
  personnes: Number,
  createdAt: { type: Date, default: Date.now }
});
const Reservation = mongoose.model('Reservation', reservationSchema);

// Absence
const absenceSchema = new mongoose.Schema({
  employeeId: mongoose.Schema.Types.ObjectId,
  dateDebut: String,
  dateFin: String,
  motif: String,
  createdAt: { type: Date, default: Date.now }
});
const Absence = mongoose.model('Absence', absenceSchema);

// --- 3. Middleware d’authentification JWT ---
function authenticateToken(req, res, next) {
  const authHeader = req.header('Authorization');
  const token = authHeader && authHeader.split(' ')[1]; // "Bearer TOKEN"
  if (!token) return res.status(401).json({ error: 'Accès refusé' });

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ error: 'Token invalide' });
    req.user = user;
    next();
  });
}

// --- 4. Route de login (génération de JWT) ---
app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  // Ici, on cherche l'utilisateur en base ; pour l'instant, on peut créer un user par défaut
  let user = await User.findOne({ username });
  if (!user) {
    // création d'un user test (uniquement si pas d'utilisateur en base)
    user = await User.create({ username, password });
  }
  if (user.password !== password) {
    return res.status(401).json({ error: 'Identifiants incorrects' });
  }
  // Création du token
  const token = jwt.sign({ id: user._id, username: user.username }, process.env.JWT_SECRET, { expiresIn: '1h' });
  res.json({ token });
});

// --- 5. Routes de gestion des réservations (persistées en MongoDB) ---

// Création d’une réservation
// Création d’une réservation (ouverte à tous les clients)
app.post('/reservations', async (req, res) => {
  try {
    const { nom, email, date, heure, personnes } = req.body;
    const newRes = await Reservation.create({ nom, email, date, heure, personnes });
    res.json({ success: true, reservation: newRes });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
;

// Liste de toutes les réservations
app.get('/reservations', authenticateToken, async (req, res) => {
  const list = await Reservation.find().sort({ createdAt: -1 });
  res.json(list);
});

// --- 6. Route d’export CSV des réservations ---
app.get('/export/reservations', authenticateToken, async (req, res) => {
  const data = await Reservation.find().lean();
  const parser = new Parser();
  const csv = parser.parse(data);
  res.header('Content-Type', 'text/csv');
  res.attachment('reservations.csv');
  res.send(csv);
});

// --- 7. Routes de gestion des absences ---
app.post('/absences', authenticateToken, async (req, res) => {
  try {
    const abs = await Absence.create(req.body);
    res.json({ success: true, absence: abs });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/absences', authenticateToken, async (req, res) => {
  const list = await Absence.find().sort({ createdAt: -1 });
  res.json(list);
});

// --- 8. Route de test ---
app.get('/', (req, res) => {
  res.send('API est en cours de fonctionnement !');
});

// --- 9. Démarrage ---
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Serveur en cours d'exécution sur le port ${PORT}`);
});
