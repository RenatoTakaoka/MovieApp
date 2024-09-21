import 'dart:convert';

class ReviewResult {
  int id;
  int page;
  List<Review> reviews;
  int totalPages;
  int totalResults;

  ReviewResult({
    required this.id,
    required this.page,
    required this.reviews,
    required this.totalPages,
    required this.totalResults,
  });

  factory ReviewResult.fromRawJson(String str) => ReviewResult.fromJson(json.decode(str));

  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
        id: json["id"],
        page: json["page"],
        reviews: List<Review>.from(json["results"].map((x) => Review.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Review {
  String author;
  AuthorDetails authorDetails;
  String content;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  String url;

  Review({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        author: json["author"],
        authorDetails: AuthorDetails.fromJson(json["author_details"]),
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
      );
}

class AuthorDetails {
  String name;
  String username;
  String avatarPath;
  int? rating;

  AuthorDetails({
    required this.name,
    required this.username,
    required this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromRawJson(String str) => AuthorDetails.fromJson(json.decode(str));

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"] ?? '',
        username: json["username"] ?? '',
        avatarPath: json["avatar_path"] ?? '',
        rating: json["rating"] != null ? json["rating"].toInt() : null,
      );
}