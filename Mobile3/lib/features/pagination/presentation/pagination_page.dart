import 'package:flutter/material.dart';
import 'package:mobile3/core/network/dio_client.dart';
import 'package:mobile3/features/pagination/data/pagination_repository.dart';
import 'package:mobile3/features/pagination/domain/get_paginated_posts_usecase.dart';
import 'package:mobile3/features/pagination/domain/pagination_entity.dart';
import 'pagination_view_model.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({super.key});

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  late final PaginationViewModel viewModel;
  final ScrollController _controller = ScrollController();
  List<PostEntity> items = [];
  int page = 1;
  final int limit = 10;
  bool isLoading = false;
  bool hasMoreData = true; // Флаг для проверки, есть ли еще данные для загрузки

  @override
  void initState() {
    super.initState();
    final dioClient = DioClient();
    final repository = PaginationRepository(dioClient);
    final useCase = GetPaginatedPostsUseCase(repository);
    viewModel = PaginationViewModel(useCase);
    fetchData();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          !isLoading &&
          hasMoreData) {
        fetchData();
      }
    });
  }

  Future<void> fetchData() async {
    if (isLoading || !hasMoreData)
      return; // Если уже загружается или данных нет, не отправляем запрос

    setState(() => isLoading = true);

    try {
      final newItems = await viewModel.fetchPosts(page, limit);
      if (newItems.isEmpty) {
        setState(() {
          hasMoreData = false; // Нет данных для загрузки
          isLoading = false;
        });
        return;
      }
      setState(() {
        page++;
        items.addAll(newItems);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Логирование ошибки или показывание уведомления
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination')),
      body: ListView.builder(
        controller: _controller,
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            return ListTile(
              title: Text(items[index].title),
              subtitle: Text(items[index].body),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
