import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/main_controller.dart';
import '../../cubit/nature_cubit/nature_cubit.dart';
import '../../cubit/nature_cubit/nature_state.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/if_offline.dart';

class Natures extends StatefulWidget {
  Natures({super.key, required this.controller});

  final MainController controller;


  @override
  State<Natures> createState() => _NaturesState();
}

class _NaturesState extends State<Natures> {
  @override
  void initState() {
    super.initState();
    context.read<NatureCubit>().fetchNatures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: BlocBuilder<NatureCubit, NatureState>(
        builder: (context, state) {
          if (state is NatureLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NatureLoaded) {
            return GridView.builder(
              itemCount: state.natures.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final url = state.natures[index].urls?.small;
                final result = state.natures[index].altDescription;
                final imageUrl = state.natures[index].links?.download;
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
          } else if (state is NatureError) {
            return Center(child: Text(state.message));
          }
          return const IfOffline(assetImage: "assets/images/buildings.jpg");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NatureCubit>().loadMore();
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
