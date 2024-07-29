import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/main_controller.dart';
import '../../cubit/animal_cubit/animals_cubit.dart';
import '../../cubit/animal_cubit/animals_state.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/if_offline.dart';

class Animals extends StatefulWidget {
  Animals({super.key, required this.controller});

  final MainController controller;

  @override
  State<Animals> createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  @override
  void initState() {
    super.initState();
    context.read<AnimalsCubit>().fetchAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: BlocBuilder<AnimalsCubit, AnimalsState>(
        builder: (context, state) {
          if (state is AnimalsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnimalsLoaded) {
            return GridView.builder(
              itemCount: state.animals.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final url = state.animals[index].urls?.small;
                final result = state.animals[index].altDescription;
                final imageUrl = state.animals[index].links?.download;

                return GestureDetector(
                  onTap: () => ShowDialog()
                      .showDownloadDialog(context, result!, imageUrl),
                  child: Card(
                    child: url != null
                        ? Image.network(
                            url,
                            fit: BoxFit.cover,
                            height: 100,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(child: Icon(Icons.error)),
                          )
                        : Center(child: Icon(Icons.error)),
                  ),
                );
              },
            );
          } else if (state is AnimalsError) {
            return Center(child: Text(state.message));
          }
          return const IfOffline(assetImage: "assets/images/buildings.jpg");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AnimalsCubit>().loadMore();
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
