import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

import 'widgets/movie_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> listMovie = [];

  int currentPage = 1;
  String urlAPI =
      "https://api.themoviedb.org/3/discover/movie?api_key=26763d7bf2e94098192e629eb975dab0&page=";

  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getMovie();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        newMovie();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> newMovie() async {
    try {
      setState(() {
        currentPage++;
      });
      var response = await Dio().get(urlAPI + currentPage.toString());
      if (response.statusCode == 200) {
        final data = response.data["results"] as List;
        setState(() {
          listMovie.addAll(data.map((json) => Movie.fromJson(json)));
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> refresh() async {
    listMovie.clear();
    setState(() {
      currentPage = Random().nextInt(20) + 1;
      print("$currentPage");
    });
    try {
      var response = await Dio().get(urlAPI + currentPage.toString());
      if (response.statusCode == 200) {
        final data = response.data["results"] as List;
        setState(() {
          listMovie.addAll(data.map((json) => Movie.fromJson(json)));
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getMovie() async {
    try {
      var response = await Dio().get(urlAPI + currentPage.toString());
      if (response.statusCode == 200) {
        final data = response.data["results"] as List;
        setState(() {
          listMovie.addAll(data.map((json) => Movie.fromJson(json)));
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => refresh(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                  const Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Popular list",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: (listMovie.isNotEmpty)
                    ? GridView.builder(
                        controller: controller,
                        itemCount: listMovie.length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 2 / 3,
                        ),
                        itemBuilder: (context, index) {
                          if (index < listMovie.length) {
                            return WidgetMovieItem(
                              movie: listMovie[index],
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        })
                    : const Center(
                        child: CircularProgressIndicator(),
                      ))
          ]),
        ),
      ),
    );
  }
}
