import 'package:mobile3/features/single_json/domain/get_single_json_usecase.dart';
import 'package:mobile3/features/single_json/domain/single_json_entity.dart';

class SingleJsonViewModel {
  final GetSingleJsonUseCase useCase;

  SingleJsonViewModel(this.useCase);

  Future<SingleJsonEntity> fetchJson() => useCase.call();
}
