import 'package:equatable/equatable.dart';
import 'category_state.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class CategoryStarted extends CategoryEvent {
  final String categoryId;
  const CategoryStarted(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}

class CategorySelected extends CategoryEvent {
  final String categoryId;
  const CategorySelected(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}

class CategorySortChanged extends CategoryEvent {
  final SortOption sort;
  const CategorySortChanged(this.sort);
  @override
  List<Object?> get props => [sort];
}