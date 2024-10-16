import 'dart:developer';


import '../endpoints.dart';
import '../http/stream_http_client.dart';
import 'responses.dart';

/// Defines the api dedicated to Post operations
class PokemonApi {
  PokemonApi(this._client);

  final StreamHttpClient _client;

  ///Get Pokemon  List Response
  Future<GetPostListResponse> getPostList(
      {required Map<String, String> filter}) async {
    
    log(filter.toString());
    final response = await _client.get(
      EndPoints.getPokemonList,
      queryParameters: filter,
      showProgress: true,
    );
    return GetPostListResponse.fromJson(response.data);
  }

  
  ///Get Pokemon  List  Search Response
  Future<GetPostListResponse> getPostListSearch(
      {required Map<String, String> filter}) async {
    log(filter.toString());
    final response = await _client.get(
      EndPoints.getPokemonList,
      queryParameters: filter,
      showProgress: false,
    );
    return GetPostListResponse.fromJson(response.data);
  }

}
