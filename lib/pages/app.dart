import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/main_controller.dart';
import '../cubit/animal_cubit/animals_cubit.dart';
import '../cubit/cars_cubit/cars_cubit.dart';
import '../cubit/connection/connection_cubit.dart';
import '../cubit/nature_cubit/nature_cubit.dart';
import '../cubit/search_cubit/search_cubit.dart';
import '../data/photo_repos.dart';
import 'home_page/home.dart';

class App extends StatelessWidget {
  App({super.key});

  final MainController _mainController =
      MainController(photoRepository: PhotoRepository());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CarsCubit(_mainController),
        ),
        BlocProvider(
          create: (_) => AnimalsCubit(_mainController),
        ),

        BlocProvider(
          create: (_) => NatureCubit(_mainController),
        ),
        BlocProvider(
          create: (_) => ConnectionCubit(),
        ),
        BlocProvider(
          create: (_) => SearchCubit(_mainController),
        ),
        // Add other providers here if needed
      ],
      child: const MaterialApp(
        home: HomePage(),
        title: "Homeworks",
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
