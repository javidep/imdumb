#imdumb

Gestión Source reto

#Resumen del proyecto. App que lista categorías de películas, cada categoría tiene un listado de películas, al ingresar al detalle de la película se muestra los datos de la película como (titulo, descripción, calificación, imágenes, actores). También se cuenta con el botón de recomendar.

#Arquitectura usada Clean Arquitecture + TDD con Bloc

Presentación: Widgets, Logica presentación, Bloc

Dominio: Use cases, entidades

Data: Repositorios, data sources, APIs

#Tech stack y dependencias Mac: 

MacOS 15.2 o superior 

Version Flutter: 3.38.6 

Version Xcode: 16.2 

IntelliJ IDEA: 2024.2.4 (opcional recomendado, se puede usar otros como visual code)


#Cómo correr el proyecto

1. Tener instalado Flutter version 3.38.6 (también se puede ejecutar con versiones 3.x, aunque no esta probado)

2. Tener instalado el SDK para iOS (Xcode version 16.2)
   
3. Usar de preferencia IntelliJ IDEA (version 2024.2.4) como interfaz de desarrollo (no debe haber problema con otros IDs como visual code, siempre que tenga experiencia en el manejo del mismo)
   
4. Clonar el proyecto del repositorio publico (https://github.com/javidep/imdumb.git)
   
5. De ser necesario configurar en Settings > languages & frameworks (Flutter, Dart) para que lea las rutas de Flutter y Dart para que el main.dart pueda ejecutarse
   
6. Ejecutar el proyecto, ejecutar "flutter pub get" para instalar las dependencias, luego ejecutar "flutter run" o directamente desde la interfaz de desarrollo


#Configuración de Firebase: No es necesario todo esta configurado y listo para usarse


#Endpoint(s) utilizados: 
Primero se realizo el modelado en la base de datos de firebase (firestore), luego se desarrolló las siguientes APIs
https://dev-api-42989598603.us-central1.run.app/dev/get-movie-category (api que lista las categorías de películas)
https://dev-api-42989598603.us-central1.run.app/dev/get-movies/CAT00001 (api que lista las películas por categoría seleccionada)

#principios SOLID
1. Single Responsibility Principle (SRP), Una clase debe tener una sola razón para cambiar. En la arquitectura del proyecto dentro de directorio "features" > "movies", existen 3 capas (presentación, dominio, data), cada capa tiene una función o responsabilidad única.
2. Open / Closed Principle (OCP), Las entidades de software deben estar abiertas para extensión, pero cerradas para modificación. En la capa de dominio (movies_repository.dart) esta clase es abstracta para permitir nuevas implementaciones sin modificar el código existente.
3. Dependency Inversion Principle (DIP), Los módulos de alto nivel no deben depender de módulos de bajo nivel, sino de abstracciones. En la capa de presentación los widgets dependen de abstracciones, no de implementaciones concretas.

#Capturas de pantalla
Se adjunta imagenes y video de la app (https://drive.google.com/drive/folders/1K4c32zt6h-w8c-sx5vlZG0D3s9ed1IFy?usp=share_link)
