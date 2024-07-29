import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/main_controller.dart';
import '../../cubit/cars_cubit/cars_cubit.dart';
import '../../cubit/cars_cubit/cars_state.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/if_offline.dart';

class Cars extends StatefulWidget {
  Cars({super.key, required this.controller});

  final MainController controller;

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  void initState() {
    super.initState();
    context.read<CarsCubit>().fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: BlocBuilder<CarsCubit, CarsState>(
        builder: (context, state) {
          if (state is CarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarLoaded) {
            return GridView.builder(
              itemCount: state.cars.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                final url = state.cars[index].urls?.small;
                final result = state.cars[index].altDescription;
                final imageUrl = state.cars[index].links?.download;

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
                                const Center(child: Icon(Icons.error)),
                          )
                        : const Center(child: Icon(Icons.error)),
                  ),
                );
              },
            );
          } else if (state is CarError) {
            return Center(child: Text(state.message));
          }
          return const IfOffline(assetImage: "assets/images/buildings.jpg");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CarsCubit>().loadMore();
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
