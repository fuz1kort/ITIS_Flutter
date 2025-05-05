import 'package:flutter/material.dart';
import 'package:mobile3/core/network/dio_client.dart';
import 'package:mobile3/features/single_json/data/single_json_repository_impl.dart';
import 'package:mobile3/features/single_json/domain/get_single_json_usecase.dart';
import 'single_json_view_model.dart';

class SingleJsonPage extends StatefulWidget {
  const SingleJsonPage({super.key});

  @override
  State<SingleJsonPage> createState() => _SingleJsonPageState();
}

class _SingleJsonPageState extends State<SingleJsonPage> {
  late final SingleJsonViewModel viewModel;
  bool isLoading = true;
  String title = '';
  String body = '';

  @override
  void initState() {
    super.initState();
    final dioClient = DioClient();
    final repository = SingleJsonRepositoryImpl(dioClient);
    final useCase = GetSingleJsonUseCase(repository);
    viewModel = SingleJsonViewModel(useCase);
    loadData();
  }

  Future<void> loadData() async {
    final data = await viewModel.fetchJson();
    setState(() {
      title = data.title;
      body = data.body;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single JSON')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(body),
                  ],
                ),
              ),
    );
  }
}
