-- 1. Crea el esquema de la BBDD.
-- se crea un diagrama llamado Diagrama_Proyecto

-- 2. Muestra los nombres de todas las películas con una clasificación por 
-- edades de ‘Rʼ.
select f.title as Pelicula, f.rating as clasificacion 	-- selecciona las columnas title y rating
from film f 										  	-- de la tabla film
where f.rating = 'R';									-- donde la clasificacion sea 'R'

-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
select a.actor_id,										-- mostrar columna actor_id y 
		concat(a.first_name, ' ', a.last_name ) as nombre_actor  -- hacer una columna donde aparezca nombre y apellido
from actor a 											-- de la tabla actor
where a.actor_id between 30 and 40						-- seleccionar los id de los actores comprendidos entre 30 y 40
order by a.actor_id ;									-- ordenar por id

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select f.title 											-- mostrar el nombre de la pelicula
from film f 											-- de la tabla film			
where f.original_language_id = f.language_id  ;			-- cuando los id de language y original_language sean iguales

-- 5. Ordena las películas por duración de forma ascendente.
select f.title as pelicula, 							-- columnas title y length
		f.length  as duracion
from film f 											-- de la tabla film
order by duracion asc ;									-- se ordena por duración de forma ascendente

-- 6.  Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
select a.first_name as nombre, a.last_name as apellido	-- columnas first_name y last_name
from actor a 											-- de la tabla actor
where a.last_name ='ALLEN' ;							-- mostrar solo los que contengan el apellido ALLEN

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla 
-- “filmˮ y muestra la clasificación junto con el recuento.
select f.rating as clasificacion, 						-- columna rating
	count(f.film_id )									-- se crea columna para contar peliculas
from film f												-- de la tabla film
group by clasificacion ;								-- se agrupa por clasificacion

-- 8.  Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una 
-- duración mayor a 3 horas en la tabla film
select f.title as pelicula, f.rating , f.length 		-- columna title
from film f 											-- de la tabla film
where f.rating = 'PG-13' or f.length  > 180 ;			-- selecciona solo las peliculas de clasificacion PG-13 o de duracion de mas de 3 horas

-- 9.  Encuentra la variabilidad de lo que costaría reemplazar las películas.
select stddev(f.replacement_cost) as variabilidad		-- calculo de la desviacion estandar de la variable replacement_cost
from film f ;											-- de la tabla film

-- 10.  Encuentra la mayor y menor duración de una película de nuestra BBDD.
select MAX(f.length) as mayor_duracion, 				-- duración mayor de una pelicula
		MIN(f.length) as menor_duracion					-- duración menor de una pelicula
from film f ;											-- de la tabla film

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select round(p.amount, 2) as coste						-- coste redondeado a 2 decimales	
from rental r 											-- de la tabla rental con sus metricas de la tabla payment  
left join payment p 
on p.rental_id = r.rental_id 
order by r.rental_date desc nulls last					-- ordenar fecha descendente colocando los nulos al final		
offset 2 												-- descartar los 2 primeros para mostrar el tercero
limit 1;

-- 12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17'
--  ni ‘Gʼ en cuanto a su clasificación.
select f.title as pelicula, f.rating 					-- titulo pelicula y clasificación
from film f 											-- de la tabla film
where f.rating not in ('NC-17','G')	;					-- la clasificación no sea NC-17 ni G

-- 13. Encuentra el promedio de duración de las películas para cada 
-- clasificación de la tabla film y muestra la clasificación junto con el 
-- promedio de duración.
select f.rating as clasificacion, 						-- columna de clasificacion y su promedio de duracion
		AVG(f.length ) as promedio_duracion
from film f 											-- de la tabla film
group by clasificacion ;								-- agrupar por clasificacion

-- 14.  Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select f.title as pelicula, f.length as duracion		-- columnas title y length
from film f 											-- de la tabla film
where f.length > 180  ;									-- muestra las peliculas con una duracion superior a 180 min

-- 15.  ¿Cuánto dinero ha generado en total la empresa?
select SUM(p.amount) as total_generado					-- suma del total facturado por la empresa
from payment p ;										-- de la tabla payment

-- 16. Muestra los 10 clientes con mayor valor de id.
select c.customer_id 									-- columna Id cliente
from customer c 										-- de la tabla customer
order by c.customer_id desc  							-- ordenar id clientes descendente
limit 10  ;												-- mostrar los 10 primeros

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
select a.first_name as nombre, 							-- nombre, apellido de los actores		
		a.last_name as apellido, 
		f.title as pelicula								-- mostrar pelicula para verificar que la query funciona bien
from film f 											-- de la tabla fil
inner join film_actor fa 								-- union con las tablas film_actor y actor
on f.film_id = fa.film_id 
inner join actor a 
on a.actor_id =fa.actor_id 
where f.title ='EGG IGBY' ;								-- filtrar por titulo 'EGG IGBY'

-- 18.  Selecciona todos los nombres de las películas únicos.
select f.title 											-- columna title
from film f 											-- de la tabla film	
group by f.title ;										-- agrupar por title para eliminar dubplicados

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
select f.title as pelicula, 							-- columnas pelicula, categoria y duracion
		c."name" as categoria, 
		f.length as duracion
from film f 											-- union de la tablas film, film_category y category
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on c.category_id =fc.category_id 
where c."name" ='Comedy' and f.length > 180 ;			-- filtrar por categoria Comedia y duracion de mas de 180 min

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos 
-- y muestra el nombre de la categoría junto con el promedio de duración.
select c."name"  as cartegoria , 						-- columna categoria
		AVG(f.length ) as promedio_duracion				-- se crea una columna para calcular el promedio de la duración
from category c 										-- union de las tablas category, film_category y film
inner join film_category fc 
on c.category_id = fc.category_id
inner join film f 
on fc.film_id = f.film_id
group by cartegoria 									-- agrupar por categoria
having AVG(f.length ) > 110 ;							-- filtrar las categorias que el promedio de la duración sea superior a 110 min

-- 21.  ¿Cuál es la media de duración del alquiler de las películas?
select AVG(f.rental_duration) as duracion_media_alquiler -- se crea una columna para calcular la media
from film f ;											-- de la tabla film

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(a.first_name, ' ', a.last_name ) as nombre_apellido  -- se crea una columna que contiene nombre y apellido
from actor a ;											-- de la tabla actor

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select r.rental_date, 									-- columna renta_date
		count(r.rental_id) numero_alquiler				-- contar numero de peliculas de alquiler
from rental r 											-- de la tabla rental
group by r.rental_date 									-- agrupar por rental_date
order by numero_alquiler desc ;							-- ordenar por numero de peliculas de alquiler de forma descendente

-- 24. Encuentra las películas con una duración superior al promedio.
with promedio_duracion as (								-- cte para calcular la media de duracion
select AVG(f.length ) as duracion_media
from film f )

select f.title as pelicula, 
		f.length as duracion							-- mostrar pelicula y duracion
from film f 											-- de la tabla film
where f.length  > (select "duracion_media" from promedio_duracion); -- filtrar por peliculas que sean superior a la media de duración

-- 25. Averigua el número de alquileres registrados por mes.
select extract (month from r."rental_date") as mes,		-- extraer mes de la fecha de rental_date
		count(r.rental_id) as total_alquileres			-- contar el numero de alquileres aprupado por mes
from rental r 
group by extract (month from r."rental_date")
order by mes ;											-- ordenar por mes ascendente

-- 26.  Encuentra el promedio, la desviación estándar y varianza del total pagado.
select AVG(p.amount) as promedio_total, 				-- tres columnas para el calculo de la media, la desviacion estandar y la varianza
		stddev(p.amount) as desviacion_estandar_total,	-- del total facturado 
		variance(p.amount) as varianza_total
from payment p ;										-- de la tabla payment

-- 27. ¿Qué películas se alquilan por encima del precio medio?
with calculo_precio_medio as (							-- cte para calcular el precio medio de las peliculas
select AVG(f.rental_rate) as precio_medio
from film f )

select f.title as pelicula, 							-- mostrar pelicula y su precio
		f.rental_rate as precio
from film f 											-- de la tabla film
where f.rental_rate > (select precio_medio from calculo_precio_medio); -- filtrar por las peliculas cuyo precio es superior al medio

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select a.actor_id,
	count(f.film_id) as numero_peliculas				-- mostrar id actores y el numero de peliculas que han participado
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id 
inner join film f 
on f.film_id = fa.film_id 								-- unir las tablas actor, film_actor y film
group by a.actor_id 									-- agrupar por id actor
having count(f.film_id) > 40 ;							-- filtrar id actor que haya participado en mas de 40 peliculas

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select f.title as pelicula, 							-- mostrar pelicula
count(i.inventory_id) 									-- contar que cantidad de peliculas hay en el inventario
from film f 											-- union de las tablas film, inventory y rental
left join inventory i 
on f.film_id =i.film_id 
left join rental r 
on i.inventory_id = r.inventory_id
	and r.return_date is null 							-- une solo los alquileres activos
where r.rental_id is null								-- filtrar por las que no estan alquiladas, estan disponibles												
group by f.film_id , f.title 							-- agrupar por pelicula
order by f.title ;							

-- 30. Obtener los actores y el número de películas en las que ha actuado.
select concat(a.first_name, ' ', a.last_name ) as actor, -- mostrar actor y numero de peliculas en las que ha actuado
count(f.film_id ) as Numero_peliculas
from actor a 											-- union de las tabla actor, film_actor y film
inner join film_actor fa 
on a.actor_id = fa.actor_id 
inner join film f 
on f.film_id = fa.film_id 
group by actor	;										-- agrupar por actor

-- 31. Obtener todas las películas y mostrar los actores que han actuado en 
--     ellas, incluso si algunas películas no tienen actores asociados.
select f.title as pelicula, 							-- mostrar pelicula y actor asociado
		concat(a.first_name, ' ', a.last_name ) as actor
from film f 											-- unir la tablas film, film_actor y actor 
left join film_actor fa 								-- uso de left join para que la pelicula aparezca aunque no tenga actor asociado
on f.film_id = fa.film_id
left join actor a 
on a.actor_id = fa.actor_id ;

-- 32. Obtener todos los actores y mostrar las películas en las que han 
	-- actuado, incluso si algunos actores no han actuado en ninguna película.
select concat(a.first_name, ' ', a.last_name ) as actor ,		-- mostrar actor y pelicula asociada
		f.title as pelicula
from actor a											-- unir la tablas film, film_actor y actor 
left join film_actor fa 								-- uso de left join para que el actor aparezca aunque no tenga pelicula asociada
on fa.actor_id= a.actor_id 
left join film f  
on f.film_id = fa.film_id ; 

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title as pelicula, 							-- mostrar todas las peliculas y todos los registros de alquiler
		r.rental_id as registro_alquiler
from film f 
left join inventory i 
on f.film_id = i.film_id 
full join rental r 
on i.inventory_id = r.inventory_id ;

-- 34.  Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select concat(c.first_name, ' ', c.last_name) as cliente,-- mostrar clientes y sus gastos totales
		SUM(p.amount) as total_gastado
from customer c 										-- unir las tablas customer, rental y payment 
inner join rental r 									-- para poder calcular el total gastado de cada cliente
on c.customer_id =r.customer_id 
inner join payment p 
on p.rental_id = r.rental_id 
group by  cliente 										-- agrupar por clientes
order by total_gastado desc 							-- ordenar descendente para colocar arriba de la tabla los que mas han gastado
limit 5 ;												-- mostrar solo los 5 primeros

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select a.first_name as nombre, a.last_name as apellido	-- columnas nombre y apellido
from actor a 											-- de la tabla actor
where a.first_name = 'JOHNNY';							-- mostrar solo nombre JOHNNY

-- 36.  Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
select a.first_name as Nombre, 
		a.last_name as Apellido
from actor a ;

-- 37.  Encuentra el ID del actor más bajo y más alto en la tabla actor.
select MAX(actor_id) as Id_alto, 
		MIN(actor_id) as Id_bajo
from actor ;

-- 38. Cuenta cuántos actores hay en la tabla “actorˮ.
select count(a.actor_id ) as numero_actores				-- contar numero de actores
from actor a ;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select a.first_name as nombre, 
		a.last_name as apellido
from actor a 
order by a.last_name asc

-- 40. Selecciona las primeras 5 películas de la tabla “filmˮ.
select f.title as pelicula
from film f 
limit 5 ;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el 
-- mismo nombre. ¿Cuál es el nombre más repetido?
select a.first_name as nombre , 						-- mostrar nombre y numero de actores
		count(a.first_name) as numero_actores 
from actor a 											-- de la tabla actores
group by a.first_name 									-- agrupar por nombre del actor
order by numero_actores desc							-- ordenar descendente para que aparezca el mas repetido primero
limit 1 ;												-- mostrar solo el mas repetido

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id , 
		concat(c.first_name, ' ', c.last_name ) as cliente
from rental r
left join customer c 
on c.customer_id = r.customer_id ;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select concat (c.first_name, ' ', c.last_name) as cliente, 
		r.rental_id 
from customer c 
left join rental r 
on c.customer_id = r.customer_id ;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor 
-- esta consulta? ¿Por qué? Deja después de la consulta la contestación
select *
from film f 
cross join film_category fc 
cross join category c ;
-- esta consulta no aporta ningún valor ya que relaciona todas las filas de la tabla film, con todas las filas de la tabla film_category,
-- con todas las filas de category sin ningún tipo de criterio.

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'
select concat(a.first_name, ' ', a.last_name ) as actor, 		-- mostrar nombre y apellido del actor y si cotegoria
		c."name"  as categoria
from actor a 		
inner join film_actor fa										-- unir las tablas actor, film_actor, film, film_category y category 
on a.actor_id = fa.actor_id 									-- para la enlazar los actores con su categoria
inner join film f 
on f.film_id = fa.film_id 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on c.category_id = fc.category_id 
where c."name" = 'Action' ;										-- filtrar categoria Action

-- 46. Encuentra todos los actores que no han participado en películas.
select concat (a.first_name, ' ', a.last_name)	as actor		-- columna de actores
from actor a
left join film_actor fa 
on a.actor_id = fa.actor_id
where fa.film_id is null;										-- mostrar solo los actores que no tienen pelicula asociada

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select concat(a.first_name, ' ', a.last_name ) as actor,		-- columnas de actores y su cantidad de peliculas en las que han participado
	count(fa.film_id ) as numero_peliculas
from actor a 
left join film_actor fa 
    on a.actor_id = fa.actor_id
group by a.actor_id;


-- 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres 
-- de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as 
select concat(a.first_name, ' ', a.last_name ) as actor,		
	count(fa.film_id ) as numero_peliculas
from actor a 
left join film_actor fa 
    on a.actor_id = fa.actor_id
group by a.actor_id;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select concat(c.first_name, ' ', c.last_name ) as cliente,   	-- mostrar nombre y apellido de cada cliente y la cantidad de alquiler realizado
		count(r.rental_id ) as cantidad_alquileres
from customer c 												-- union de las tablas customer y rental
left join rental r 
on c.customer_id =r.customer_id 
group by c.customer_id  ;										-- se agrupa por id del cliente

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select c.name as categoria, 									-- mostrar nombre de la categoria y su cantidad de peliculas
		count(f.film_id) as cantidad_peliculas
from film f 
inner join film_category fc 									-- union de las tablas film, film_categroy
on f.film_id = fc.film_id 
inner join category c 
on c.category_id = fc.category_id 
where c."name" = 'Action'										-- filtrar por categoria Action
group by c."name" ;												-- agrupar por categoria

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para 
-- almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as 				-- se crea la tabla temporal
select concat(c.first_name, ' ', c.last_name ) as cliente,   	-- columa de cliente y su cantidad de alquileres
		count(r.rental_id ) as cantidad_alquileres
from customer c 												
left join rental r 
on c.customer_id =r.customer_id 								-- unión de las tablas customer y rental para enlazar alquileres con clientes
group by c.customer_id  ;										-- agrupar por id del cliente

select cliente, cantidad_alquileres								-- creamos la consulta
from cliente_rentas_temporal ;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las 
-- películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as		 			-- se crea la tabla temporal "peliculas_alquiladas"
select f.title as pelicula, 	
		count(r.rental_id) as veces_alquiladas
from rental r 
inner join inventory i 
on i.inventory_id =r.inventory_id 
inner join film f 
on f.film_id= i.film_id
group by pelicula 
having count(r.rental_id)>10 ;

select pelicula, veces_alquiladas
from peliculas_alquiladas ;


-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente 
--con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena 
--los resultados alfabéticamente por título de película.
select concat(c.first_name, ' ', c.last_name)as cliente,		-- una columna de clientes y otra con las peliculas no devueltas
		f.title as pelicula_no_devuelta
from customer c 												-- union de las tablas customer, rental, inventory y film
inner join rental r 
on c.customer_id = r.customer_id 
inner join inventory i 
on i.inventory_id =r.inventory_id 
inner join film f 
on f.film_id = i.film_id 
where concat(c.first_name, ' ', c.last_name)= 'TAMMY SANDERS'	-- mostrar solo las peliculas no devueltas por Tammy Sanders
	and r.return_date is null
group by c.customer_id, f.title 								-- agrupar por id del cliente y por la pelicula
order by f.title ;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una 
-- película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados 
-- alfabéticamente por apellido.

select a.first_name as nombre, 									-- columnas nombre, apellido y categoria
		a.last_name as apellido, 
		c."name" as categoria
from actor a 													-- union de las tablas actor, film_actor, film, film_category y category
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f 
on fa.film_id = f.film_id 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on c.category_id = fc.category_id 
where c."name" = 'Sci-Fi'										-- mostrar solo la catgoria Sci-Fi
group by a.actor_id, categoria 									-- agrupar por id del actor y categoria
order by apellido  ;											-- ordenar por apellido

-- 55.  Encuentra el nombre y apellido de los actores que han actuado en 
-- películas que se alquilaron después de que la película ‘Spartacus 
-- Cheaperʼ se alquilara por primera vez. Ordena los resultados 
-- alfabéticamente por apellido.
select a.first_name as nombre,			 						-- mostrar nombre y apellido de los actores
		a.last_name asapellido
from actor a													-- union de las tablas actor, film_actor, film, inventory y rental
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f 
ON fa.film_id = f.film_id
inner join inventory i 
on f.film_id = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
where r.rental_date > (											-- subconsulta para buscar la primera fecha que se alquiló SPARTACUS CHEAPER
    select MIN(r2.rental_date)
    from film f2
    inner join inventory i2 
    on f2.film_id = i2.film_id
    inner join rental r2 
    on i2.inventory_id = r2.inventory_id
    where f2.title = 'SPARTACUS CHEAPER'
)
order by a.last_name;											-- ordenar por apellido

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en 
-- ninguna película de la categoría ‘Musicʼ.
select concat(a.first_name, ' ', a.last_name) AS actor			-- mostrar actores
from actor a													-- unir tablas para enlazar categoria con actores
where not exists (												-- subconsulta para descartar la categoria Music
    select *
    from film_actor fa
    inner join film_category fc
    on fa.film_id = fc.film_id
    inner join category c
    on c.category_id = fc.category_id
    where fa.actor_id = a.actor_id
      and c.name = 'Music'
);

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select f.title as pelicula, 
		extract (day from(r.return_date - r.rental_date )) as dias_alquiladas -- extraemos los dias de las fechas para poder filtrar por mas de 8 dias
from rental r 
inner join inventory i 														-- union de las tablas rental, inventory y film
on i.inventory_id = r.inventory_id 
inner join film f 
on f.film_id = i.film_id 
where extract (day from (r.return_date - r.rental_date)) > 8 ;				-- filtramos por mas de 8 dias

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

select f.title as pelicula 									-- pelicula
from category c 
inner join film_category fc 
on c.category_id = fc.category_id 
inner join film f 
on f.film_id =fc.film_id 
where c."name" = 'Animation';									-- filtrar por categoria 'Animation'

-- 59.  Encuentra los nombres de las películas que tienen la misma duración 
-- que la película con el título ‘Dancing Feverʼ. Ordena los resultados 
-- alfabéticamente por título de película.
select f.title AS pelicula										-- pelicula
from film f														-- tabla film
where f.length = (												-- subcolsulta par encontrar la duracion de la pelicula Dancing Fever
    select f2.length
    from film f2
    where f2.title = 'DANCING FEVER'
)
order by f.title ;

-- 60.  Encuentra los nombres de los clientes que han alquilado al menos 7 
-- películas distintas. Ordena los resultados alfabéticamente por apellido.
select    c.first_name AS nombre,								-- nombre y apellido
    c.last_name AS apellido
from customer c													-- union de las tablas customer, rental, inventory y film
inner join rental r 
on c.customer_id = r.customer_id
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
group by c.customer_id, c.first_name, c.last_name				-- agrupar por id del cliente
having count(f.film_id) >= 7									-- filtrar por los clientes que han alquilado 7 o mas peliculas
order by apellido ;												-- ordenar por apellido

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y 
-- muestra el nombre de la categoría junto con el recuento de alquileres.
select c."name" as categoria, 									-- categoria y el numero de alquileres
		count(r.rental_id) as recuento_alquileres
from rental r 													-- unión de las tablas rental, inventory, film, film_category y category
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on f.film_id =i.film_id 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on c.category_id = fc.category_id 
group by c."name" ;												-- agrupar por categoria

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select c."name" as categoria, 									-- categoria y su numero de peliculas
		count(f.film_id ) as numero_peliculas
from category c 												-- unión de las tablas category, film_category y film
inner join film_category fc 
on c.category_id = fc.category_id 
inner join film f 
on fc.film_id = f.film_id
where f.release_year =2006										-- filtrar por peliculas estrenadas en 2006
group by categoria  ;											-- agrupar por categoria

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select concat(s.first_name, ' ', s.last_name ) as trabajador,	-- trabajador, su id de la tienda y sy dirección
		s2.store_id,
		s2.address_id 
from staff s 
cross join store s2	;											-- combinar trabajadores con las id de las tiendas

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y 
-- muestra el ID del cliente, su nombre y apellido junto con la cantidad de 
-- películas alquiladas.
select c.customer_id,											-- id, nombre y apellido del cliente con la cantidad de peliculas alquiladas
		c.first_name as nombre,
		c.last_name as apellido,
		count(f.film_id) as cantidad_peliculas_alquiladas
from customer c 												-- unión de las tablas customer, rental, inventory y film
inner join rental r 
on c.customer_id = r.customer_id 
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
group by c.customer_id ;										-- agrupar por id del cliente


