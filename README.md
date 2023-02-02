# Weather-iOS

## Installation
Run git clone to download proyect

```ruby
git clone https://github.com/luisMan97/Weather-iOS.git
```

#### Third Party Libraries
The project does not use third party libraries. Don't cocoapods, don't cartage, don't worry :)

#### Funcionalidades
- La pantalla principal cuenta con dos principales secciones; el listado de las ciudades de la API publica de weatherapi (https://www.weatherapi.com/docs/) y el listado de ciudades favoritas guardas como favoritas.
- La pantalla principal, tanto la sección de "Ciudades" cómo de "Favoritos" cuentan con una barra de busqueda, la sección de "Ciudades" busca en el API y la sección de "Favoritos" busca localmente.
- Cuando se selecciona una ciudad se va al detalle de la ciudad con su información del clima.
- La pantalla principal, sección de "Favoritos" tiene un botón para editar las ciudades favoritas, más especificamente poderlos eliminar.
- Cada ciudad de los favoritos tiene el gesto nativo de deslizar y eliminar.
- En la pantalla del detalle de la ciudad se visualiza la información del clima además de un botón que deja ver el clima de los próximos 4 días.
- En la pantalla del detalle de la ciudad se tiene un botón para guardar en favoritos la ciudad con su información.

- Se muestra mensaje de error cuando el servicio falla o no hay conexión a internet.
- Hay una modal de loading que se muestra cada vez que se hace una petición al servicio web.

#### Funcionalidades técnicas:
- La aplicación está desarrollada en Swift 5, con SwiftUI, Combine y Async/Await.
- La aplicación tiene cómo arquitectura un tipo de MVVM extendido (CLEAN Architecture).
- La aplicación usa programación reactiva con Combine.
- La aplicación implementa diferentes patrones de diseño (Repository, Factory entre otros).
- La aplicación hace uso de inyección de dependencias.
- La aplicación hace uso de los principios SOLID.
- La aplicación no usa librerías de terceros.
- La aplicación contiene test unitarios de las casos de uso y viewmodels.
- La aplicación usa una capa genérica y extensible con URLSession para hacer los llamados a los servicios.  
- La aplicación usa Codable para el mapeo de JSON a objetos. 
- La aplicación contiene un .gitignore para no subir archivos innecesarios.

#### Arquitectura
Se implementó CLEAN como arquitectura, con las siguientes capas:
1) View: Contiene las View de SwiftUI
2) Presentation: Contiene los ViewModels
3) Interactor/UseCases: Contiene los casos de uso (acciones de la aplicación y lógica de negocios)
4) Entity/Domain: Contiene las entidades
5) Data: Contiene el patrón repository para obtener los datos ya sea de una API o una base de datos local
6) Framework: Contiene la implementación a más detalle de la obtención de datos usando ya la respectiva librería o framework (URLSession, CoreData y etc)
