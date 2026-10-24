const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const DB_PATH = path.join(__dirname, 'db.json');
const PORT = process.env.PORT || 3000;

const leerDb = () => JSON.parse(fs.readFileSync(DB_PATH, 'utf8'));
const guardarDb = (db) =>
  fs.writeFileSync(DB_PATH, JSON.stringify(db, null, 2));

const app = express();
app.use(cors());
app.use(express.json());

// Listar tareas
app.get('/tareas', (req, res) => {
  res.json(leerDb().tareas);
});

// Obtener una tarea
app.get('/tareas/:id', (req, res) => {
  const tarea = leerDb().tareas.find((t) => t.id === Number(req.params.id));
  if (!tarea) return res.status(404).json({ error: 'Tarea no encontrada' });
  res.json(tarea);
});

// Crear tarea
app.post('/tareas', (req, res) => {
  const { nombre, descripcion = '', terminada = false } = req.body;
  if (typeof nombre !== 'string' || !nombre.trim()) {
    return res.status(400).json({ error: 'El nombre es obligatorio' });
  }
  const db = leerDb();
  const id = db.tareas.reduce((max, t) => Math.max(max, t.id), 0) + 1;
  const tarea = { id, nombre: nombre.trim(), descripcion, terminada: !!terminada };
  db.tareas.push(tarea);
  guardarDb(db);
  res.status(201).json(tarea);
});

// Actualizar tarea (parcial)
app.patch('/tareas/:id', (req, res) => {
  const db = leerDb();
  const tarea = db.tareas.find((t) => t.id === Number(req.params.id));
  if (!tarea) return res.status(404).json({ error: 'Tarea no encontrada' });
  const { nombre, descripcion, terminada } = req.body;
  if (nombre !== undefined) tarea.nombre = nombre;
  if (descripcion !== undefined) tarea.descripcion = descripcion;
  if (terminada !== undefined) tarea.terminada = !!terminada;
  guardarDb(db);
  res.json(tarea);
});

// Eliminar tarea
app.delete('/tareas/:id', (req, res) => {
  const db = leerDb();
  const idx = db.tareas.findIndex((t) => t.id === Number(req.params.id));
  if (idx === -1) return res.status(404).json({ error: 'Tarea no encontrada' });
  db.tareas.splice(idx, 1);
  guardarDb(db);
  res.status(204).end();
});

app.listen(PORT, () => console.log(`API de tareas en http://localhost:${PORT}`));
