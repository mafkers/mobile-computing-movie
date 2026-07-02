import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/movie.dart';
import '../utils/db_helper.dart';

class MovieRepository {
  final String _baseUrl = 'https://api.tvmaze.com';

  Future<bool> _hasInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult is List) {
      return connectivityResult.any((r) => r != ConnectivityResult.none);
    }
    return connectivityResult != ConnectivityResult.none;
  }

  Future<List<Movie>> getMovies() async {
    final hasInternet = await _hasInternet();
    
    if (hasInternet) {
      try {
        // Fetch popular shows from TVMaze
        final response = await http.get(Uri.parse('$_baseUrl/shows'));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          // Take top 20 shows
          final List<Movie> movies = data.take(20).map((json) => Movie.fromJson(json)).toList();
          
          // Cache them
          await DatabaseHelper.instance.cacheMovies(movies);
          
          return movies;
        }
      } catch (e) {
        print("API Error: $e");
      }
    }
    
    // Fallback to local storage
    print("Falling back to local storage...");
    final localMovies = await DatabaseHelper.instance.getCachedMovies();
    if (localMovies.isEmpty) {
      return dummyMovies; // Fallback to hardcoded dummy if totally empty
    }
    return localMovies;
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) {
      return getMovies();
    }
    
    final hasInternet = await _hasInternet();
    if (hasInternet) {
      try {
        final response = await http.get(Uri.parse('$_baseUrl/search/shows?q=$query'));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          return data.map((json) => Movie.fromJson(json)).toList();
        }
      } catch (e) {
        print("API Search Error: $e");
      }
    }
    
    // Offline search fallback (search in cached local DB)
    final localMovies = await DatabaseHelper.instance.getCachedMovies();
    final results = localMovies
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
        
    return results.isNotEmpty ? results : dummyMovies.where((m) => m.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
