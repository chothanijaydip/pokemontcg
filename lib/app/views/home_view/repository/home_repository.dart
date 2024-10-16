import '../../../data/client/api/responses.dart';
import '../../../data/client/client.dart';

class HomeRepository {
  Future<GetPostListResponse> getPostListCall({
    required String page,
  }) async {
    var result = await StreamApiClient().getPostListCall(
      filter: {"page": page, "pageSize": "10"},
    );
    return result;
  }
   Future<GetPostListResponse> getPostSearchCall({
    required String query,
  }) async {
    var result = await StreamApiClient().getPostListSearchCall(
      filter: {"q": "set.name:$query",},
    );
    return result;
  }
}
