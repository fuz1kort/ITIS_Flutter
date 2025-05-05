import 'package:mobile3/features/pagination/data/pagination_repository.dart';
import 'package:mobile3/features/pagination/domain/pagination_entity.dart';

class GetPaginatedPostsUseCase {
  final PaginationRepository repository;

  GetPaginatedPostsUseCase(this.repository);

  Future<List<PostEntity>> call(int page, int limit) {
    return repository.getPosts(page, limit);
  }
}
