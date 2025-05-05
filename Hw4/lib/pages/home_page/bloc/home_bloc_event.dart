import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bloc_event.freezed.dart';

@freezed
class HomeBlocEvent with _$HomeBlocEvent {
  const factory HomeBlocEvent.initialLoading() = InitialLoading;
  const factory HomeBlocEvent.load1() = Load1;
  const factory HomeBlocEvent.load2() = Load2;
}
