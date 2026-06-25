import '../models/movie.dart';

class MovieRepository {
  /// Simulate a network request to fetch a list of movies
  Future<List<Movie>> getMovies() async {
    // Simulate network delay using Future.delayed
    await Future.delayed(const Duration(seconds: 2));
    
    // Return dummy data from movie.dart
    return dummyMovies;
  }
}
