# Movies

# Capas de la aplicación
La aplicación se construyó utilizando la arquitectura modelo, vista, controlador a la cual se le añadió una capa de servicios y una capa de utilidades(helper) como se puede ver en las carpetas del proyecto.

Model
- En la capa model se encuentra la entidad Movie que sirve para representar tanto a las peliculas como a los tv shows. Esto debido a la similtud de sus atributos y practicidad para desarrollar la prueba.

View
- En la capa view se encuentra la celda que va a mostrar la informacion de una pelicula o de un show de tv al usuario

Controller
- En la capa controller se encuentra el archio Intro el cual maneja las animaciones del incio. Despues pasa a Categories que maneja las categorias (popular, top rated, upcoming) para cada tipo (movies, tv shows). El archivo MovieList en lista las peliculas o shows de tv de acuerdo a la categoria seleccionada por el usuario. Y por último está el MovieController el cual muesta la informacion de la pelicual o tv show elegido por el usuario.

Service
- El la capa de servicios se encuentra el archivo Reachability encargado de verificar si hay concexion a internet o no. El archivo NSCache+Singleton es encargado de manejar el cache cuando la aplicación esta offline. El InfoService se encarga de construir la URL para traer la informacion solicitada por el usuario.

Helper
- Capa con enums y extensiones para facilitar el manejo de la información dentro de la aplicacion.

# Preguntas
En qué consiste el principio de responsabilidad única? Cuál es su propósito?
- El principio de responsabilida unica significa que los distintos componenentes de una aplicion, ya sean funciones o clases, deben ser responsables de una única funcionalidad en el sistema. No deben mezclarse las distintas capas en una misma funcion o clase.

Qué características tiene, según su opinión, un “buen” código o código limpio?
- Un código limpio debe ser sencillo de entender y fácil de modificar. No deben haber segmentos de código repetidos y se debe utilizar la identacion para su facil legibilidad. Se deben tener estándares para la declaracion de variables, clases, lenguaje (escrbir código en inglés o en español para prevenir el uso de ambos).

# Aspectos a mejorar
- Las funciones loadOnlineInfo() y loadCachedInfo() deberian pertenecer al InfoService
- La busqueda por el momento funciona con el nombre exacto de la pelicula o show.
- Por el momento para hacer cache de una lista de peliculas o shows es necesario ingresar a cada categoria.
- Organizar el codigo de la funcion cellForRowAt


