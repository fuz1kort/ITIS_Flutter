import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/home_page/bloc/home_bloc.dart';
import '../pages/home_page/bloc/home_bloc_event.dart';
import '../pages/home_page/bloc/home_bloc_state.dart';
import '../pages/home_page/widgets/list_with_loading_widget.dart';
import 'my_app_button.dart';

class MyHomeView extends StatelessWidget {
  const MyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeBlocState>(
      builder: (context, state) {
        return switch (state) {
          Loading() => const Center(child: CircularProgressIndicator()),
          Error(errorMessage: final message) => Center(child: Text(message)),
          Loaded(homeMapModel: final mapModel) => Column(
            children: [
              ListWithLoadingWidget(
                isLoading: mapModel.isLoading1,
                data: mapModel.data1,
              ),
              MyAppButton(
                buttonText: 'Click 1',
                onClick: () {
                  context.read<HomeBloc>().add(const Load1());
                },
              ),
              ListWithLoadingWidget(
                isLoading: mapModel.isLoading2,
                data: mapModel.data2,
              ),
              MyAppButton(
                buttonText: 'Click 2',
                onClick: () {
                  context.read<HomeBloc>().add(const Load2());
                },
              ),
            ],
          ),
          // TODO: Handle this case.
          HomeBlocState() => throw UnimplementedError(),
        };
      },
    );
  }
}
