import 'package:logging/logging.dart';

import '../http/stream_http_client.dart';

import 'pokemon_api.dart';

class StreamApi {
  /// Initialize a new stream api
  StreamApi({
    StreamHttpClient? client,
    StreamHttpClientOptions? options,
    Logger? logger,
  }) : _client = client ??
            StreamHttpClient(
              options: options,
              logger: logger,
            );
  final StreamHttpClient _client;

  PokemonApi? _pokemonApi;
  /// Api dedicated to Post operations
  PokemonApi get pokemonApi => _pokemonApi ??= PokemonApi(_client);

}
