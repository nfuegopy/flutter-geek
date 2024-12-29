# Mega Friki API - Flutter Application

## Descripción

Mega Friki API es una aplicación móvil desarrollada en Flutter que integra múltiples API para ofrecer contenido relacionado con el anime, incluyendo información sobre Dragon Ball y Pokémon. La aplicación organiza las funcionalidades en módulos como personajes, planetas y una Pokédex.

Cada módulo está diseñado para consumir datos desde APIs externas, mostrar listas interactivas y proporcionar detalles enriquecidos a través de una interfaz visual atractiva y funcional.

## Características principales

- **Interfaz modular:** Pantallas separadas para cada funcionalidad (Dragon Ball, Pokédex, etc.).
- **Consumo de APIs:** Integración con APIs públicas como PokéAPI y Dragon Ball API.
- **Navegación fluida:** Uso de `Navigator` para moverse entre pantallas.
- **Temas personalizables:** Implementación de temas claros y oscuros.
- **Componentes reutilizables:** Widgets como tarjetas, listas y vistas detalladas para datos específicos.

---

## Requisitos

- Flutter SDK 3.0 o superior.
- Dart SDK 2.17 o superior.
- Conexión a internet para consumir APIs.
- Herramientas de desarrollo compatibles con Flutter (VS Code, Android Studio, etc.).

---

## Instalación y configuración

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/tu-usuario/mega-friki-api.git
   cd mega-friki-api
   ```

2. **Instalar las dependencias:**

   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación:**

   ```bash
   flutter run
   ```

4. **(Opcional) Configurar APIs externas:**
   - Verifica las constantes en el archivo `constants.dart`.
   ```dart
   const String baseUrl = 'https://dragonball-api.com/api';
   const String charactersEndpoint = '$baseUrl/characters';
   const String planetsEndpoint = '$baseUrl/planets';
   ```

---

## Estructura del proyecto

El proyecto utiliza una estructura limpia y modular:

```
lib/
├── main.dart              # Punto de entrada principal
├── constants.dart         # Configuraciones globales
├── app_theme.dart         # Temas claros y oscuros
├── views/
│   ├── home.dart          # Pantalla principal
│   ├── anime/
│   │   ├── anime_home.dart       # Módulo Anime
│   │   ├── dragonball_home.dart  # Submódulo Dragon Ball
│   │   └── pokedex_list.dart     # Submódulo Pokédex
│   ├── planets/
│   │   ├── planet_list.dart      # Lista de planetas
│   │   └── planet_detail.dart    # Detalles del planeta
│   ├── characters/
│   │   ├── character_list.dart   # Lista de personajes
│   │   └── character_detail.dart # Detalles del personaje
│   └── widgets/
│       ├── pokemon_card.dart     # Widget para Pokémon
│       └── planet_card.dart      # Widget para planetas
└── services/
    ├── api_pokedex_service.dart  # Servicio para PokéAPI
    └── api_dragon_ball_service.dart # Servicio para Dragon Ball API
```

---

## Descripción técnica

### 1. **Pantalla principal (`home.dart`)**

La pantalla principal organiza las secciones en un formato de cuadrícula utilizando `GridView.count`. Cada tarjeta lleva a módulos individuales, como el módulo de anime.

### 2. **Módulo de Anime (`anime_home.dart`)**

- Se conecta con dos submódulos: Dragon Ball y Pokédex.
- Cada submódulo muestra contenido relacionado.

### 3. **Pokédex (`pokedex_list.dart`)**

- **API utilizada:** [PokéAPI](https://pokeapi.co/).
- Implementación de paginación para mostrar los primeros 151 Pokémon.
- Detalles de cada Pokémon se muestran en `pokemon_detail.dart`.

### 4. **Dragon Ball (`dragonball_home.dart`)**

- **Submódulos:**
  - **Personajes:** Mostrados en `character_list.dart`, detalles en `character_detail.dart`.
  - **Planetas:** Mostrados en `planet_list.dart`, detalles en `planet_detail.dart`.

### 5. **Servicios de API (`services/`)**

- **PokéAPI:** `api_pokedex_service.dart` maneja solicitudes con la librería `Dio`.
- **Dragon Ball API:** `api_dragon_ball_service.dart` maneja solicitudes incluyendo manejo de SSL personalizado.

### 6. **Modelos de datos (`models/`)**

- **Pokemon:** Modelo que incluye sprites, movimientos y tipos.
- **Character:** Modelo que incluye atributos como raza, género y nivel de Ki.
- **Planet:** Modelo con nombre, descripción y estado (activo o destruido).

---

## Cómo replicar

1. **Cambiar el tema:** Edita `app_theme.dart` para personalizar colores y fuentes.
2. **Agregar nuevos módulos:**
   - Crea un nuevo directorio en `views/`.
   - Implementa pantallas similares con navegación usando `Navigator.push`.
3. **Extender servicios de API:**
   - Agrega nuevos métodos en `services/api_xxx_service.dart`.
   - Define modelos adicionales en `models/`.

---

## Próximos pasos

- Integrar autenticación para funcionalidades exclusivas.
- Soporte offline para listas de personajes y planetas.
- Mejorar la gestión de estados con Riverpod o Bloc.

---

## Créditos

- **Desarrollador:** [Nfuego Developer]([https://github.com/tu-usuario](https://github.com/nfuegopy))
- **Fuentes:** [PokéAPI](https://pokeapi.co/), [Dragon Ball API](https://dragonball-api.com/)

---

## Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.
