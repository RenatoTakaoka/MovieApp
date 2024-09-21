import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/search/widgets/movie_search.dart';

class MovieSearchList extends StatelessWidget {
  final List<Movie> movies;
  const MovieSearchList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieSearch(movie: movies[index]);
      },
    );
  }
}