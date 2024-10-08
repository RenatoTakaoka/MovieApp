import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';
import 'package:movie_app/pages/home/widgets/nowplaying_list.dart';
import 'package:movie_app/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiServices apiServices = ApiServices();
  
  late Future<Result> nowPlayingMovies;
  late Future<Result> upcomingMovies;
  late Future<Result> popularMovies;

  @override
  void initState() {
    nowPlayingMovies = apiServices.getNowPlaying();
    upcomingMovies = apiServices.getUpcoming();
    popularMovies = apiServices.getPopular();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Now Playing',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder(
                  future: nowPlayingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error!.toString()),
                      );
                    }
                    return NowPlayingList(movies: snapshot.data!.movies);
                  }),
              const SizedBox(
                height: 20,
              ),
              const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ),
            FutureBuilder(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
                  );
                }
                if (snapshot.hasData) {
                  final movies = snapshot.data!.movies;
                  if (movies.isEmpty) {
                    return const Center(
                      child: Text("Nenhum filme encontrado"),
                    );
                  }
                  return MoviesHorizontalList(movies: movies, movieId: movies[0].id);
                }
                return const Center(
                  child: Text("Nenhum dado disponível"),
                );
              },
            ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder(
                future: upcomingMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error!.toString()),
                    );
                  }
                  if (snapshot.hasData) {
                    return MoviesHorizontalList(movies: snapshot.data!.movies, movieId: snapshot.data!.movies[0].id);
                  }
                  return const Text("Banana");
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
