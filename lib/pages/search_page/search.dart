import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/main_controller.dart';
import '../../cubit/search_cubit/search_cubit.dart';
import '../../cubit/search_cubit/search_state.dart';
import '../widgets/custom_dialog.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, required this.controller});

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.deepOrangeAccent,
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: SearchBar(
                    leading: const Icon(Icons.search),
                    hintText: "Search your favourite pictures",
                    onChanged: (value) =>
                        context.read<SearchCubit>().search(value),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SearchLoaded) {
                        return GridView.builder(
                          itemCount: state.searched.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            final url = state.searched[index].urls?.small;
                            final result = state.searched[index].altDescription;
                            final imageUrl =
                                state.searched[index].links?.download;

                            return GestureDetector(
                              onTap: () => ShowDialog().showDownloadDialog(
                                  context, result!, imageUrl!),
                              child: Card(
                                child: url != null
                                    ? Image.network(
                                        url,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                                    child: Icon(Icons.error)),
                                      )
                                    : const Center(child: Icon(Icons.error)),
                              ),
                            );
                          },
                        );
                      } else if (state is SearchError) {
                        return Center(child: Text(state.message));
                      }
                      return Container(); // Handle empty or default state
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<SearchCubit>().refresh();
              },
              backgroundColor: Colors.deepOrange,
              child: const Icon(Icons.refresh),
            ),
          ),
        );
      },
    );
  }
}
