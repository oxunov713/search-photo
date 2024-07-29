import 'package:bloc/bloc.dart';
import '../../controller/main_controller.dart';
import '../../models/result_model.dart';
import '../../util/throtling.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MainController controller;
  int _pageNumber = 1;
  String _currentQuery = '';
  final List<Result> _searchedList = [];
  final Throttling _throttling = Throttling(const Duration(seconds: 1));

  SearchCubit(this.controller) : super(SearchInitial());

  void search(String query) async {
    _throttling(() async {
      _currentQuery = query;
      emit(SearchLoading());

      try {
        final response = await controller.getPhoto(
            title: query, page: _pageNumber.toString());
        final newResults = response?.results ?? [];

        if (newResults.isNotEmpty) {
          _searchedList.addAll(newResults);
          emit(SearchLoaded(searched: _searchedList)); // Emit the complete list
        } else if (_searchedList.isEmpty) {
          emit(SearchError('No results found.'));
        } else {
          emit(SearchError('No more results.'));
        }
      } catch (e) {
        emit(SearchError('Failed to search: $e'));
      }
    });
  }

  void refresh() {
    _pageNumber++;
    try {
      search(_currentQuery);
    } catch (e) {
      emit(SearchError('Failed to load more results: $e'));
    }
  }
}
