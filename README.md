# API-Tableros

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado en tu máquina:

- Node.js 
- npm
- mysql

## Configuración del Proyecto

1. **Clona el Repositorio:**
   ```bash
   git clone https://github.com/joaquin8123/API-Tableros.git

2. **Instala las dependencias**  
    ```bash
        npm i 

3. **Crea un archivo .env en la raíz del proyecto y configura las variables necesarias. Puedes encontrar un ejemplo en el archivo .env.example**  
    ```bash
        HOST=
        USER=
        PASSWORD=
        DATABASE=
        PORT=

4. **Copiar el codigo sql del scriptBD y crear la base de datos local**
    ```bash
       scriptBD.sql

5. **Ejecuta la aplicacion**
    ```bash
        npm run dev


## Endpoints

A continuación se presentan los endpoints disponibles en la API:

| Endpoint              | Método | Body                                  |
|-----------------------|--------|---------------------------------------|
| `/auth/register`      | POST    | `{ "name": "joaquin", "password": "asd132", "username": "joaquin123" }`|
| `/auth/login`      | POST   | `{ "username": "joaquin123", "password": "asd132" }` | 
| `/sale/`   | GET    |               | 
| `/sale/:id`   | GET |                                    | 
| `/sale/dashborad`   | POST |                `{ "dashboardName": "dashboard1", "value": 5 }`                    | 
