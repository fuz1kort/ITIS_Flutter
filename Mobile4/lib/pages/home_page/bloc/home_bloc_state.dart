import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile4/pages/home_page/bloc/state_data/home_map_model.dart';

part 'home_bloc_state.freezed.dart';

@freezed
class HomeBlocState with _$HomeBlocState {
  const factory HomeBlocState.loading() = Loading;
  const factory HomeBlocState.error(String errorMessage) = Error;
  const factory HomeBlocState.loaded(HomeMapModel homeMapModel) = Loaded;
}
