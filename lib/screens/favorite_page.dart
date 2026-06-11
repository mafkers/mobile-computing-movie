import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_page.dart';

class FavoritePage extends StatefulWidget {
  final Set<String> favoriteTitles;
  final Function(String) onToggleFavorite;

  const FavoritePage({
    super.key,
    required this.favoriteTitles,
    required this.onToggleFavorite,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final favMovies = dummyMovies.where((m) => widget.favoriteTitles.contains(m.title)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: favMovies.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.heart_broken, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada film favorit nih!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yuk, balik ke halaman utama\ndan tambahkan film favoritmu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: favMovies.length,
              itemBuilder: (context, index) {
                final movie = favMovies[index];
                return MovieCard(
                  movie: movie,
                  // Parameter isFavorite tidak dikirim agar icon heart disembunyikan
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movie: movie,
                          initialFavorite: widget.favoriteTitles.contains(movie.title),
                          onToggleFavorite: (title) {
                            widget.onToggleFavorite(title);
                            // Refresh state layar ini saat list di-unfavorite dari dalam layar detail
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
