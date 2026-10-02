import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/network/api_client.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiClient _api;

  HomeBloc(this._api) : super(const HomeState()) {
    on<HomeStarted>(_load);
    on<HomeRefreshed>(_load);
  }

  Future<void> _load(HomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final data = await _api.fetchHome();
      emit(state.copyWith(status: HomeStatus.success, data: data));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, error: e.toString()));
    }
  }
}