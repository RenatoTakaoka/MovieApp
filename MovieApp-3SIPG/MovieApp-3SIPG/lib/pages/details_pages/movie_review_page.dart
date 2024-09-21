import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/movie_reviews.dart';
import 'package:movie_app/services/api_services.dart';

class MovieReviewsPage extends StatefulWidget {
  final int movieId;

  const MovieReviewsPage({super.key, required this.movieId});

  @override
  State<MovieReviewsPage> createState() => _MovieReviewsPageState();
}

class _MovieReviewsPageState extends State<MovieReviewsPage> {
  final ApiServices apiServices = ApiServices();

  late Future<ReviewResult> reviewResult;

  @override
  void initState() {
    reviewResult = apiServices.getReviews(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews do Filme'),
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder<ReviewResult>(
        future: reviewResult,
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
            final reviews = snapshot.data!.reviews;

            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${review.authorDetails.avatarPath}',
                              ),
                              onBackgroundImageError: (_, __) => const Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              review.author,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          review.content,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rating: ${review.authorDetails.rating ?? '-'}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(review.createdAt),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}