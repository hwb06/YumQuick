import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
  @override
  List<Object?> get props => [];
}

class DetailsStarted extends DetailsEvent {
  final String foodId;
  const DetailsStarted(this.foodId);
  @override
  List<Object?> get props => [foodId];
}

class DetailsQtyIncremented extends DetailsEvent {
  const DetailsQtyIncremented();
}

class DetailsQtyDecremented extends DetailsEvent {
  const DetailsQtyDecremented();
}

class DetailsToppingToggled extends DetailsEvent {
  final String toppingId;
  const DetailsToppingToggled(this.toppingId);
  @override
  List<Object?> get props => [toppingId];
}

class DetailsFavoriteToggled extends DetailsEvent {
  const DetailsFavoriteToggled();
}