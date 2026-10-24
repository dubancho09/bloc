# API de tareas

REST sencilla con Express. La "base de datos" es el archivo `db.json`.

```
cd server
npm install
npm start        # http://localhost:3000
```

| Método | Ruta          | Descripción                      |
|--------|---------------|----------------------------------|
| GET    | /tareas       | Lista las tareas                 |
| GET    | /tareas/:id   | Obtiene una tarea                |
| POST   | /tareas       | Crea (`nombre`, `descripcion`, `terminada`) |
| PATCH  | /tareas/:id   | Actualiza campos                 |
| DELETE | /tareas/:id   | Elimina                          |

Flutter usa `http://10.0.2.2:3000` en el emulador Android y `http://localhost:3000`
en el resto. En un dispositivo físico:
`flutter run --dart-define=API_URL=http://IP_DE_TU_PC:3000`
