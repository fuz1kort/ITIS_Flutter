import 'package:mobile3/features/single_json/data/single_json_repository_impl.dart';
import 'package:mobile3/features/single_json/domain/single_json_entity.dart';

class GetSingleJsonUseCase {
  final SingleJsonRepository repository;

  GetSingleJsonUseCase(this.repository);

  Future<SingleJsonEntity> call() => repository.fetchSingleJson();
}
