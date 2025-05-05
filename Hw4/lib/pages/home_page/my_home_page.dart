import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/my_app_bar.dart';
import '../../components/my_home_view.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_bloc_event.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => HomeBloc()..add(const HomeBlocEvent.initialLoading()),
      child: const Scaffold(
        appBar: MyAppBar(appBarText: 'Задание с блоком и freezed'),
        body: MyHomeView(),
      ),
    );
  }
}
