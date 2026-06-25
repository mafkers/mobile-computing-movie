import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../blocs/favorite_bloc.dart';
import '../blocs/favorite_event.dart';
import '../blocs/favorite_state.dart';
import '../blocs/movie_bloc.dart';
import '../blocs/movie_event.dart';
import '../blocs/movie_state.dart';
import 'movie_detail_page.dart';
import 'favorite_page.dart';

class MovieCatalogPage extends StatefulWidget {
  const MovieCatalogPage({super.key});

  @override
  State<MovieCatalogPage> createState() => _MovieCatalogPageState();
}

class _MovieCatalogPageState extends State<MovieCatalogPage> {
  final TextEditingController _searchController = TextEditingController();

  // A simple stream that emits the current time every second
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    // Dispatch FetchMoviesEvent to load movies initially
    context.read<MovieBloc>().add(FetchMoviesEvent());
    
    _timeStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    // Dispatch SearchMoviesEvent instead of using setState/Future
    context.read<MovieBloc>().add(SearchMoviesEvent(_searchController.text));
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
      body: Column(
        children: [
          // 1. StreamBuilder Implementation (Real-time clock)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.amber.shade100,
            child: StreamBuilder<DateTime>(
              stream: _timeStream,
              builder: (context, snapshot) {
                final timeText = snapshot.hasData
                    ? "${snapshot.data!.hour.toString().padLeft(2, '0')}:${snapshot.data!.minute.toString().padLeft(2, '0')}:${snapshot.data!.second.toString().padLeft(2, '0')}"
                    : "--:--:--";
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Live Time (StreamBuilder): $timeText',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
          ),
          // 2. Search Field
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search movies...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _onSearch,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          // 3. MovieBloc Implementation
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, movieState) {
                if (movieState is MovieInitial || movieState is MovieLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Fetching from BLoC...'),
                      ],
                    ),
                  );
                } else if (movieState is MovieError) {
                  return Center(child: Text('Error: ${movieState.message}'));
                } else if (movieState is MovieLoaded) {
                  final movies = movieState.movies;

                  if (movies.isEmpty) {
                    return const Center(child: Text('No movies found.'));
                  }

                  return BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, favoriteState) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          final isFavorite = favoriteState.favoriteTitles.contains(movie.title);

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
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
