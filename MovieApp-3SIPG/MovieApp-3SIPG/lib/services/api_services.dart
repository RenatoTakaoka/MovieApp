import 'dart:convert';

import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  
  Future<Result> getTopRatedMovies() async {
    const endpoint = 'movie/top_rated';
    final url = Uri.parse("$baseUrl$endpoint$key");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Result.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }

  Future<Result> getNowPlaying() async {
    const endpoint = 'movie/now_playing';
    final url = Uri.parse("$baseUrl$endpoint$key");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Result.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }

  Future<Result> getPopular() async {
    const endpoint = 'movie/popular';
    final url = Uri.parse("$baseUrl$endpoint$key");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Result.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }
  
  Future<Result> getUpcoming() async {
    const endpoint = 'movie/upcoming';
    final url = Uri.parse("$baseUrl$endpoint$key");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Result.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }
  

  Future<List<Movie>> getFutureMovies() async {
    await Future.delayed(const Duration(seconds: 5));

    final movie1 = Movie(
      adult: false,
      backdropPath: "/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg",
      genreIds: [28, 35, 878],
      id: 533535,
      originalLanguage: "en",
      originalTitle: "Deadpool VS Wolverine",
      overview: "Deadpool & Wolverine",
      popularity: 13902.556,
      posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
      releaseDate: DateTime.parse("2024-07-24"),
      title: "Deadpool VS Wolverine",
      video: false,
      voteAverage: 7.858,
      voteCount: 1721,
    );

    final movie2 = Movie(
      adult: false,
      backdropPath: "/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg",
      genreIds: [28, 35, 878],
      id: 533535,
      originalLanguage: "en",
      originalTitle: "Despicable Me 4",
      overview: "Despicable Me 4",
      popularity: 13902.556,
      posterPath: "/wWba3TaojhK7NdycRhoQpsG0FaH.jpg",
      releaseDate: DateTime.parse("2024-07-24"),
      title: "Despicable Me 4",
      video: false,
      voteAverage: 7.858,
      voteCount: 1721,
    );

    final movie3 = Movie(
      adult: false,
      backdropPath: "/stKGOm8UyhuLPR9sZLjs5AkmncA.jpg",
      genreIds: [28, 35, 878],
      id: 533535,
      originalLanguage: "en",
      originalTitle: "Inside Out 2",
      overview: "Inside Out 2e",
      popularity: 13902.556,
      posterPath: "/stKGOm8UyhuLPR9sZLjs5AkmncA.jpg",
      releaseDate: DateTime.parse("2024-07-24"),
      title: "Inside Out 2",
      video: false,
      voteAverage: 7.858,
      voteCount: 1721,
    );

    List<Movie> movies = [
      movie1,
      movie2,
      movie3,
      movie1,
      movie2,
      movie3,
      movie1,
      movie2,
      movie3
    ];
    return movies;
  }
}
