import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/main_controller.dart';
import '../../cubit/connection/connection_cubit.dart';
import '../../cubit/connection/connection_state.dart';
import '../../data/photo_repos.dart';
import '../animals/animals.dart';
import '../cars/cars.dart';
import '../nature/nature.dart';
import '../search_page/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MainController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MainController(photoRepository: PhotoRepository());
    context.read<ConnectionCubit>().checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
          title: const Text("Search any photos"),
          backgroundColor: Colors.deepOrange,
          actions: [
            BlocBuilder<ConnectionCubit, ConnectionState1>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  onPressed: () {
                    if (state is ConnectionDone) {
                      if (!state.hasInternet) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Internet unavailable"),
                              content: const Text(
                                  "Please check your internet connection."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchPage(controller: _controller),
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: BlocListener<ConnectionCubit, ConnectionState1>(
          listener: (context, state) {
            if (state is ConnectionDone && !state.hasInternet) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Internet unavailable"),
                    content:
                        const Text("Please check your internet connection."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Stack(
            children: [
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      indicatorColor: Colors.white,
                      tabs: [
                        Tab(
                            icon: Icon(CupertinoIcons.car_detailed),
                            text: "Cars"),
                        Tab(icon: Icon(CupertinoIcons.tree), text: "Nature"),
                        Tab(icon: Icon(Icons.pets), text: "Animals"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Cars(controller: _controller),
                          Natures(controller: _controller),
                          Animals(controller: _controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ConnectionCubit, ConnectionState1>(
                builder: (context, state) {
                  if (state is ConnectionDone && !state.hasInternet) {
                    return Container(
                      color: Colors.black.withOpacity(0.5), // Overlay color
                      child: const Center(
                        child: Text(
                          'No Internet Connection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox
                      .shrink(); // Empty widget if there's internet
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
