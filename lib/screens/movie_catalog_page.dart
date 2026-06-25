import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../repositories/movie_repository.dart';
import '../blocs/favorite_bloc.dart';
import '../blocs/favorite_event.dart';
import '../blocs/favorite_state.dart';
import 'movie_detail_page.dart';
import 'favorite_page.dart';

class MovieCatalogPage extends StatefulWidget {
  const MovieCatalogPage({super.key});

  @override
  State<MovieCatalogPage> createState() => _MovieCatalogPageState();
}

class _MovieCatalogPageState extends State<MovieCatalogPage> {
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future in initState so it doesn't refetch on rebuild
    _moviesFuture = MovieRepository().getMovies();
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies found.'));
          }

          final movies = snapshot.data!;

          return BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final isFavorite = state.favoriteTitles.contains(movie.title);

                  return MovieCard(
                    movie: movie,
                    isFavorite: isFavorite,
                    onFavoriteTap: () {
                      context.read<FavoriteBloc>().add(ToggleFavoriteEvent(movie.title));
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                            movie: movie,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
