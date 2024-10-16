import 'package:json_annotation/json_annotation.dart';

import '../../../model/pokemon_list_model.dart';

part 'responses.g.dart';

class _BaseResponse {}

/// Model response for [StreamChatNetworkError] data
@JsonSerializable()
class ErrorResponse extends _BaseResponse {
  /// The http error code
  int? code;

  /// The message associated to the error code
  String? message;

  /// The backend error code
  @JsonKey(name: 'StatusCode')
  int? statusCode;

  /// A detailed message about the error
  String? moreInfo;

  /// Create a new instance from a json
  static ErrorResponse fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  /// Serialize to json
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @override
  String toString() => 'ErrorResponse(code: $code, '
      'message: $message, '
      'statusCode: $statusCode, '
      'moreInfo: $moreInfo)';
}

/// Get Post List Response
@JsonSerializable()
class GetPostListResponse extends _BaseResponse {
  // @JsonKey(includeIfNull: false, defaultValue: "")
  // String? status;
  @JsonKey(includeIfNull: false, defaultValue: 0)
  int? pageSize;
  @JsonKey(
      includeIfNull: true, name: 'data', defaultValue: <PokemonModel>[])
  List<PokemonModel>? postList;

  /// Create a new instance from a json
  static GetPostListResponse fromJson(Map<String, dynamic> json) =>
      _$GetPostListResponseFromJson(json);
}
