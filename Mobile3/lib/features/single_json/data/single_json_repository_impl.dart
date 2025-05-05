import '../../../core/network/dio_client.dart';
import '../domain/single_json_entity.dart';

abstract class SingleJsonRepository {
  Future<SingleJsonEntity> fetchSingleJson();
}

class SingleJsonRepositoryImpl implements SingleJsonRepository {
  final DioClient dioClient;

  SingleJsonRepositoryImpl(this.dioClient);

  @override
  Future<SingleJsonEntity> fetchSingleJson() async {
    final response = await dioClient.dio.get('/posts/1');
    final data = response.data;
    return SingleJsonEntity(
      id: data['id'],
      title: data['title'],
      body: data['body'],
    );
  }
}
