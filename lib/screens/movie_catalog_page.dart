import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_page.dart';
import 'favorite_page.dart';

class MovieCatalogPage extends StatefulWidget {
  const MovieCatalogPage({super.key});

  @override
  State<MovieCatalogPage> createState() => _MovieCatalogPageState();
}

class _MovieCatalogPageState extends State<MovieCatalogPage> {
  final Set<String> favoriteTitles = {};

  void _toggleFavorite(String title) {
    setState(() {
      if (favoriteTitles.contains(title)) {
        favoriteTitles.remove(title);
      } else {
        favoriteTitles.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Catalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(
                    favoriteTitles: favoriteTitles,
                    onToggleFavorite: _toggleFavorite,
                  ),
                ),
              );
              // Sinkronisasi icon heart ketika user kembali dari FavoritePage
              setState(() {});
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: dummyMovies.length,
        itemBuilder: (context, index) {
          final movie = dummyMovies[index];
          final isFavorite = favoriteTitles.contains(movie.title);
          
          return MovieCard(
            movie: movie,
            isFavorite: isFavorite,
            onFavoriteTap: () {
              _toggleFavorite(movie.title);
            },
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(
                    movie: movie,
                    initialFavorite: isFavorite,
                    onToggleFavorite: _toggleFavorite,
                  ),
                ),
              );
              // Sinkronisasi icon heart ketika user kembali dari DetailPage
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
