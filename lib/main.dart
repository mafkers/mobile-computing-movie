import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MovieCatalogPage(),
    );
  }
}

class Movie {
  final String title;
  final int year;
  final String genre;
  final double rating;
  final String posterUrl;

  const Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.posterUrl,
  });
}

class MovieCatalogPage extends StatelessWidget {
  const MovieCatalogPage({super.key});

  // Data film dalam bentuk array (List)
  static final List<Movie> movies = [
    const Movie(
      title: 'Forrest Gump',
      year: 1994,
      genre: 'Drama, Romance',
      rating: 8.8,
      posterUrl: 'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
    ),
    const Movie(
      title: 'The Matrix',
      year: 1999,
      genre: 'Action, Sci-Fi',
      rating: 8.7,
      posterUrl: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
    ),
    const Movie(
      title: 'Goodfellas',
      year: 1990,
      genre: 'Biography, Crime, Drama',
      rating: 8.7,
      posterUrl: 'https://image.tmdb.org/t/p/w500/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg',
    ),
    const Movie(
      title: 'The Lord of the Rings: The Return of the King',
      year: 2003,
      genre: 'Action, Adventure, Drama',
      rating: 9.0,
      posterUrl: 'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg',
    ),
    const Movie(
      title: 'Toy Story',
      year: 1995,
      genre: 'Animation, Adventure, Comedy',
      rating: 8.3,
      posterUrl: 'https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg',
    ),
    const Movie(
      title: 'The Lion King',
      year: 1994,
      genre: 'Animation, Adventure, Drama',
      rating: 8.5,
      posterUrl: 'https://image.tmdb.org/t/p/w500/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg',
    ),
    const Movie(
      title: 'Parasite',
      year: 2019,
      genre: 'Comedy, Drama, Thriller',
      rating: 8.5,
      posterUrl: 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
    ),
    const Movie(
      title: 'Jurassic Park',
      year: 1993,
      genre: 'Action, Adventure, Sci-Fi',
      rating: 8.2,
      posterUrl: 'https://image.tmdb.org/t/p/w500/b6qUu00iIIkXX13szFy7d0CyNcg.jpg',
    ),
  ];

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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _buildMovieCard(context, movie);
        },
      ),
    );
  }

  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Image.network(
            movie.posterUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 150,
                color: Colors.grey.shade300,
                child: const Icon(Icons.movie, size: 40, color: Colors.grey),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${movie.year} • ${movie.genre}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
