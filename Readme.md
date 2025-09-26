README.md – Laravel API en Render
🔹 Descripción

Este proyecto es un backend en Laravel 10 desplegado en Render.
Permite manejar usuarios (/api/users) y consultar Pokémon (/api/pokemon/{name}) mediante endpoints JSON.

🔹 URL del deploy
https://purueba-render-limpio.onrender.com


Cambia mi-laravel-app por tu URL real de Render.

🔹 Endpoints API
1️⃣ Ping – probar si la API está viva
GET /api/ping


Response:

{
"pong": true
}

2️⃣ Users – CRUD completo

Base URL: /api/users

a) Listar usuarios
GET /api/users


Response ejemplo:

[
{
"id": 1,
"name": "Selene",
"email": "selene@example.com",
"created_at": "2025-09-26T12:00:00.000000Z",
"updated_at": "2025-09-26T12:00:00.000000Z"
}
]

b) Crear usuario
POST /api/users
Content-Type: application/json

{
"name": "Nuevo Usuario",
"email": "nuevo@example.com",
"password": "12345678"
}


Response:

{
"id": 2,
"name": "Nuevo Usuario",
"email": "nuevo@example.com",
"created_at": "2025-09-26T12:10:00.000000Z",
"updated_at": "2025-09-26T12:10:00.000000Z"
}


🔒 Password se guarda hasheado automáticamente.

c) Ver usuario
GET /api/users/{id}


Response ejemplo:

{
"id": 2,
"name": "Nuevo Usuario",
"email": "nuevo@example.com",
"created_at": "2025-09-26T12:10:00.000000Z",
"updated_at": "2025-09-26T12:10:00.000000Z"
}

d) Actualizar usuario
PUT /api/users/{id}
Content-Type: application/json

{
"name": "Usuario Editado",
"email": "editado@example.com",
"password": "nuevopass"
}


Response ejemplo:

{
"id": 2,
"name": "Usuario Editado",
"email": "editado@example.com",
"created_at": "2025-09-26T12:10:00.000000Z",
"updated_at": "2025-09-26T12:20:00.000000Z"
}

e) Eliminar usuario
DELETE /api/users/{id}


Response: 204 No Content

3️⃣ Pokémon – endpoint público
GET /api/pokemon/{name}


Ejemplo:

GET /api/pokemon/pikachu


Response ejemplo:

{
"name": "pikachu",
"id": 25,
"types": ["electric"],
"abilities": ["static", "lightning-rod"]
}
