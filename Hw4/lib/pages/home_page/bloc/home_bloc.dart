import 'package:mobile4/pages/home_page/bloc/home_bloc_event.dart';
import 'package:mobile4/pages/home_page/bloc/home_bloc_state.dart';
import 'package:mobile4/pages/home_page/bloc/state_data/home_map_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBloc() : super(const HomeBlocState.loading()) {
    on<InitialLoading>(_onInitialLoading);
    on<Load1>(_onLoadFirstList);
    on<Load2>(_onLoadSecondList);

    add(const InitialLoading());
  }

  Future<void> _onInitialLoading(
    InitialLoading event,
    Emitter<HomeBlocState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    emit(
      HomeBlocState.loaded(
        HomeMapModel(
          data1: ['Initial data 1', 'Item 2', 'Item 3'],
          isLoading1: false,
          data2: ['Initial data 2'],
          isLoading2: false,
        ),
      ),
    );
  }

  Future<void> _onLoadFirstList(
    Load1 event,
    Emitter<HomeBlocState> emit,
  ) async {
    switch (state) {
      case Loaded(:final homeMapModel):
        // Начало загрузки - устанавливаем флаг
        emit(HomeBlocState.loaded(homeMapModel.copyWith(isLoading1: true)));

        await Future.delayed(const Duration(seconds: 1));

        // Загрузка завершена - обновляем данные
        emit(
          HomeBlocState.loaded(
            homeMapModel.copyWith(
              isLoading1: false,
              data1: [
                ...homeMapModel.data1,
                'New item ${DateTime.now().second}',
              ],
            ),
          ),
        );

      case Loading() || Error():
        // Не обрабатываем другие состояния
        break;
    }
  }

  Future<void> _onLoadSecondList(
    Load2 event,
    Emitter<HomeBlocState> emit,
  ) async {
    switch (state) {
      case Loaded(:final homeMapModel):
        // Начало загрузки
        emit(HomeBlocState.loaded(homeMapModel.copyWith(isLoading2: true)));

        await Future.delayed(const Duration(seconds: 1));

        // Загрузка завершена
        emit(
          HomeBlocState.loaded(
            homeMapModel.copyWith(
              isLoading2: false,
              data2: [
                ...homeMapModel.data2,
                'New item ${DateTime.now().second}',
              ],
            ),
          ),
        );

      case Loading() || Error():
        // Не обрабатываем другие состояния
        break;
    }
  }
}
