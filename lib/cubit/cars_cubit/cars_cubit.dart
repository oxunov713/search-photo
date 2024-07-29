import 'package:bloc/bloc.dart';
import '../../controller/main_controller.dart';
import 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  final MainController controller;
  int _pageNumber = 1;
  final List cars = [];

  CarsCubit(this.controller) : super(CarInitial());

  Future<void> fetchCars() async {
    emit(CarLoading());
    try {
      final response = await controller.getPhoto(
        title: 'car',
        page: _pageNumber.toString(),
      );
      final newResults = response?.results ?? [];
      if (newResults.isNotEmpty) {
        cars.addAll(newResults);
        _pageNumber++;

        emit(CarLoaded(cars: List.unmodifiable(cars)));
      } else {
        emit(CarError(message: 'No more results.'));
      }
    } catch (e) {
      emit(CarError(message: 'Failed to fetch buildings'));
    }
  }

  void loadMore() {
    fetchCars();
  }
}
