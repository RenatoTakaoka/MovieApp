import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/pages/details_pages/movie_review_page.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final ApiServices apiServices = ApiServices();

  late Future<MovieDetail> moviesDetails;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null).then((_) {
      setState(() {
        moviesDetails = apiServices.moviesDetails(widget.movieId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Filme'),
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder<MovieDetail>(
        future: moviesDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}', style: const TextStyle(color: Colors.white)),
            );
          } else if (snapshot.hasData) {
            final movieDetail = snapshot.data!;
            final formattedDate = DateFormat('dd MMMM yyyy', 'pt_BR').format(movieDetail.releaseDate);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (movieDetail.posterPath.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(15),
                      height: 600,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          '$imageUrl${movieDetail.posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieDetail.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Data de Lançamento: $formattedDate',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.language, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Idioma Original: ${movieDetail.originalLanguage}',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.flag, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Países de Origem: ${movieDetail.originCountry.join(', ')}',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Duração: ${movieDetail.runtime} minutos',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Orçamento: \$${movieDetail.budget}',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Receita: \$${movieDetail.revenue}',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.trending_up, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Popularidade: ${movieDetail.popularity}',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Média de Votos: ${movieDetail.voteAverage}',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.how_to_vote, color: Colors.white70),
                            const SizedBox(width: 8),
                            Text(
                              'Contagem de Votos: ${movieDetail.voteCount}',
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Sinopse:',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movieDetail.overview,
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Gêneros:',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: movieDetail.genres
                              .map((genre) => Chip(
                                    label: Text(
                                      genre.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    backgroundColor: Colors.black87,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieReviewsPage(movieId: widget.movieId),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 75, 74, 74),
        child: const Icon(Icons.reviews, color: Colors.white),
      ),
      backgroundColor: Colors.black,
    );
  }
}