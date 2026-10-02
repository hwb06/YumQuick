import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/network/api_client.dart';
import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ApiClient _api;

  DetailsBloc(this._api) : super(const DetailsState()) {
    on<DetailsStarted>(_load);
    on<DetailsQtyIncremented>((e, emit) {
      if (state.qty < 20) emit(state.copyWith(qty: state.qty + 1));
    });
    on<DetailsQtyDecremented>((e, emit) {
      if (state.qty > 1) emit(state.copyWith(qty: state.qty - 1));
    });
    on<DetailsToppingToggled>((e, emit) {
      final next = {...state.selectedIds};
      if (!next.remove(e.toppingId)) next.add(e.toppingId);
      emit(state.copyWith(selectedIds: next));
    });
    on<DetailsFavoriteToggled>(
          (e, emit) => emit(state.copyWith(isFavorite: !state.isFavorite)),
    );
  }

  Future<void> _load(DetailsStarted e, Emitter<DetailsState> emit) async {
    emit(state.copyWith(status: DetailsStatus.loading));
    try {
      final food = await _api.fetchFoodDetail(e.foodId);
      emit(state.copyWith(status: DetailsStatus.success, food: food));
    } catch (err) {
      emit(state.copyWith(status: DetailsStatus.failure, error: err.toString()));
    }
  }
}