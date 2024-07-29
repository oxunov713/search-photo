import 'package:equatable/equatable.dart';
import '../../models/result_model.dart';

abstract class AnimalsState extends Equatable {
  const AnimalsState();

  @override
  List<Object?> get props => [];
}

class AnimalsInitial extends AnimalsState {}

class AnimalsLoading extends AnimalsState {}

class AnimalsLoaded extends AnimalsState {
  final List<Result> animals;

  const AnimalsLoaded({required this.animals});

  @override
  List<Object?> get props => [animals];
}

class AnimalsError extends AnimalsState {
  final String message;

  const AnimalsError({required this.message});

  @override
  List<Object?> get props => [message];
}
