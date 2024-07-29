import 'package:bloc/bloc.dart';

import '../../controller/main_controller.dart';
import '../../models/result_model.dart';
import 'nature_state.dart';

class NatureCubit extends Cubit<NatureState> {
  final MainController controller;
  final List<Result> natures = [];
  int pageNumber = 1;

  NatureCubit(this.controller) : super(NatureInitial());

  void fetchNatures() async {
    emit(NatureLoading());
    try {
      final response = await controller.getPhoto(
        title: 'natures',
        page: pageNumber.toString(),
      );
      final newResults = response?.results ?? [];
      if (newResults.isNotEmpty) {

          natures.addAll(newResults);
          pageNumber++;
          emit(NatureLoaded(natures: List.unmodifiable(natures)));
        } else {
          emit(NatureError(message: 'No more results.'));
        }
      } catch (e) {
      emit(NatureError(message: 'Failed to fetch buildings'));
    }
  }

  void loadMore() {
    fetchNatures();
  }
}
