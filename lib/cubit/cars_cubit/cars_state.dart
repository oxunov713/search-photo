import 'package:equatable/equatable.dart';

import '../../models/result_model.dart';

abstract class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object?> get props => [];
}

class CarInitial extends CarsState {}

class CarLoading extends CarsState {}

class CarLoaded extends CarsState {
  final List<Result> cars;

  const CarLoaded({required this.cars});

  @override
  List<Object?> get props => [cars];
}

class CarError extends CarsState {
  final String message;

  const CarError({required this.message});

  @override
  List<Object?> get props => [message];
}
