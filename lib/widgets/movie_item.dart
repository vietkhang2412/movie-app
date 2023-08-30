import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class WidgetMovieItem extends StatelessWidget {
  const WidgetMovieItem({
    super.key,
    required this.movie,
  });
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    List<String> parts = movie.releaseDate.split("-");
    String year = parts[0];
    String vote = movie.voteAverage.toString();
    List<String> partScore = vote.split(".");
    String num1 = partScore[0];
    String num2 = partScore[1];
    String urlImage = "https://image.tmdb.org/t/p/w500${movie.posterPath}";
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 5,
            color: Colors.grey.withOpacity(1),
            blurStyle: BlurStyle.normal)
      ]),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.deepOrange[400],
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepOrange[200]!,
                      Colors.deepOrange[300]!,
                      Colors.deepOrange[800]!,
                      Colors.deepOrange[900]!,
                    ],
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    num1,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ".$num2",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(year,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 224, 224, 224),
                      shadows: [
                        Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )
                      ])),
              Container(
                width: 200,
                alignment: Alignment.centerLeft,
                child: Text(
                  movie.title.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 2),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )
                      ]),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
