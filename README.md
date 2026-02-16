🐬 Ejercicios SQL con la base de datos Sakila
Este repositorio recoge los ejercicios que he ido realizando para practicar SQL usando la base de datos Sakila. La idea es tener un sitio ordenado donde guardar consultas, probar cosas nuevas y ver mi evolución con SQL.

📌 ¿Qué encontrarás aquí?
- Consultas clasificadas por nivel o temática
- Ejercicios resueltos con su explicación cuando hace falta
- Algún que otro apunte personal para entender mejor la lógica de cada consulta

🧱 Tecnologías y entorno
- PostgresSQL 
- Base de datos Sakila (versión estándar)
- DBeaver

🧠 Tipos de ejercicios
🔹 Consultas básicas
- Selección de columnas
- Filtros con WHERE
- Ordenación
- Límites
🔹 Consultas intermedias
- Joins de todo tipo
- Funciones agregadas
- Agrupaciones con GROUP BY y HAVING
🔹 Consultas avanzadas
- Subconsultas
- Funciones de fecha y texto
- CTEs
- Vistas, procedimientos o cualquier cosa que me apetezca probar

📂 Estructura del repositorio
/sql/
   ├── BBDD_Proyecto_shakila_sinuser
   ├── Diagrama_proyecto
   └── proyecto_SQL
README.md


Cada archivo incluye:
- Enunciado del ejercicio
- Consulta SQL
- Comentarios o explicación breve (cuando lo veo necesario)
Ejemplo:
-- 1. Actores con más películas
SELECT a.actor_id, 
        a.first_name, 
        a.last_name, 
        COUNT(film_Id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY total_peliculas DESC
LIMIT 10;



🎯 Objetivo del proyecto
Practicar SQL de forma constante y tener un repositorio que refleje lo que voy aprendiendo. Nada más y nada menos.

🚀 Cómo usarlo
- Instala la base de datos Sakila.
- Clona este repo.
- Abre las consultas en tu cliente SQL.
- Ejecuta, revisa, rompe cosas si hace falta y vuelve a probar.
