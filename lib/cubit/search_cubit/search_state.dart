

import 'package:equatable/equatable.dart';

import '../../models/result_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Result> searched;

  SearchLoaded({required this.searched});
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
