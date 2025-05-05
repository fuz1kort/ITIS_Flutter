import 'package:mobile3/features/pagination/domain/get_paginated_posts_usecase.dart';
import 'package:mobile3/features/pagination/domain/pagination_entity.dart';

class PaginationViewModel {
  final GetPaginatedPostsUseCase useCase;

  PaginationViewModel(this.useCase);

  Future<List<PostEntity>> fetchPosts(int page, int limit) {
    return useCase(page, limit);
  }
}
