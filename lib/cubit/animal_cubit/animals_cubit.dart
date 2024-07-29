import 'package:bloc/bloc.dart';
import '../../controller/main_controller.dart';
import 'animals_state.dart';

class AnimalsCubit extends Cubit<AnimalsState> {
  final MainController controller;
  int _pageNumber = 1;
  final List _animals = [];

  AnimalsCubit(this.controller) : super(AnimalsInitial());

  Future<void> fetchAnimals() async {
    emit(AnimalsLoading());
    try {
      final response = await controller.getPhoto(
        title: 'animals',
        page: _pageNumber.toString(),
      );
      final newResults = response?.results ?? [];
      if (newResults.isNotEmpty) {
        _animals.addAll(newResults);
        _pageNumber++;

        emit(AnimalsLoaded(animals: List.unmodifiable(_animals)));
      } else {
        emit(AnimalsError(message: 'No more results.'));
      }
    } catch (e) {
      emit(AnimalsError(message: 'Failed to fetch buildings'));
    }
  }

  void loadMore() {
    fetchAnimals();
  }
}
