import 'package:equatable/equatable.dart';

import '../../models/result_model.dart';

abstract class NatureState extends Equatable {
  const NatureState();

  @override
  List<Object?> get props => [];
}

class NatureInitial extends NatureState {}

class NatureLoading extends NatureState {}

class NatureLoaded extends NatureState {
  final List<Result> natures;

  const NatureLoaded({required this.natures});

  @override
  List<Object?> get props => [natures];
}

class NatureError extends NatureState {
  final String message;

  const NatureError({required this.message});

  @override
  List<Object?> get props => [message];
}
