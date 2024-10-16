// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse()
      ..code = (json['code'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..statusCode = (json['StatusCode'] as num?)?.toInt()
      ..moreInfo = json['moreInfo'] as String?;

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'StatusCode': instance.statusCode,
      'moreInfo': instance.moreInfo,
    };

GetPostListResponse _$GetPostListResponseFromJson(Map<String, dynamic> json) =>
    GetPostListResponse()
      ..pageSize = (json['pageSize'] as num?)?.toInt() ?? 0
      ..postList = (json['data'] as List<dynamic>?)
              ?.map((e) => PokemonModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

Map<String, dynamic> _$GetPostListResponseToJson(GetPostListResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pageSize', instance.pageSize);
  val['data'] = instance.postList;
  return val;
}
