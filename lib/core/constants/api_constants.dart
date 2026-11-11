class ApiConstants {
  ApiConstants._();

  /// Endpoint oficial GraphQL de PokéAPI (especificación v1beta2)
  static const String defaultGraphQLEndpoint = 'https://graphql.pokeapi.co/v1beta2';
  
  /// Clave en SharedPreferences para endpoint dinámico / simulación de caída (PA-08)
  static const String prefCustomGraphQLEndpoint = 'custom_graphql_endpoint';
  static const String prefSimulateApiDown = 'simulate_api_down';

  /// Timeouts explícitos (RNF-RES-01)
  static const Duration requestTimeout = Duration(seconds: 12);
  static const Duration healthCheckTimeout = Duration(seconds: 5);

  /// Backoff exponencial para reintentos (RNF-RES-02)
  static const int maxRetryAttempts = 3;
  static const Duration initialRetryDelay = Duration(seconds: 2);

  /// URLs de imágenes estructuradas y respaldos
  static String officialArtworkUrl(int id) =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  static String officialArtworkShinyUrl(int id) =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/$id.png';

  static String spriteFallbackUrl(int id) =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  static String spriteShinyFallbackUrl(int id) =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/$id.png';

  static const String localPlaceholderAsset = 'assets/images/pokeball_placeholder.png';
}
