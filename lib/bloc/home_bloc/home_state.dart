import 'package:equatable/equatable.dart';
import '../../../data/models/home_data.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final HomeData? data;
  final String? error;

  const HomeState({this.status = HomeStatus.initial, this.data, this.error});

  HomeState copyWith({HomeStatus? status, HomeData? data, String? error}) => HomeState(
    status: status ?? this.status,
    data: data ?? this.data,
    error: error,
  );

  @override
  List<Object?> get props => [status, data, error];
}