import 'package:mobile3/core/network/dio_client.dart';
import 'package:mobile3/features/pagination/domain/pagination_entity.dart';

class PaginationRepository {
  final DioClient dioClient;

  PaginationRepository(this.dioClient);

  Future<List<PostEntity>> getPosts(int page, int limit) async {
    final response = await dioClient.dio.get(
      '/posts',
      queryParameters: {'_page': page, '_per_page': limit},
    );
    return (response.data as List)
        .map((item) => PostEntity.fromJson(item))
        .toList();
  }
}
