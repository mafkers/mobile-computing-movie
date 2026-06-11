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
  final String description;

  const Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.posterUrl,
    required this.description,
  });
}

class MovieCatalogPage extends StatefulWidget {
  const MovieCatalogPage({super.key});

  @override
  State<MovieCatalogPage> createState() => _MovieCatalogPageState();
}

class _MovieCatalogPageState extends State<MovieCatalogPage> {
  // Menyimpan daftar judul film yang difavoritkan
  final Set<String> favoriteTitles = {};

  // Data film dalam bentuk array (List)
  static final List<Movie> movies = [
    const Movie(
      title: 'Forrest Gump',
      year: 1994,
      genre: 'Drama, Romance',
      rating: 8.8,
      posterUrl: 'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
      description: 'Perjalanan hidup pria dengan IQ rendah namun memiliki niat murni dan hati yang baik. Secara tidak sengaja, ia ikut terlibat dalam berbagai kejadian penting dalam sejarah Amerika Serikat dari era 1950-an hingga 1980-an.',
    ),
    const Movie(
      title: 'The Matrix',
      year: 1999,
      genre: 'Action, Sci-Fi',
      rating: 8.7,
      posterUrl: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
      description: 'Seorang hacker komputer bernama Neo menyadari bahwa dunia yang ia ketahui selama ini hanyalah simulasi buatan mesin, dan ia harus bergabung dengan para pemberontak untuk menyelamatkan umat manusia.',
    ),
    const Movie(
      title: 'Goodfellas',
      year: 1990,
      genre: 'Biography, Crime, Drama',
      rating: 8.7,
      posterUrl: 'https://image.tmdb.org/t/p/w500/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg',
      description: 'Kisah nyata tentang naik turunnya Henry Hill di dunia mafia Italia-Amerika, mulai dari peran kecil hingga kehidupan mewah dan akhirnya kejatuhannya yang tragis.',
    ),
    const Movie(
      title: 'The Lord of the Rings: The Return of the King',
      year: 2003,
      genre: 'Action, Adventure, Drama',
      rating: 9.0,
      posterUrl: 'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg',
      description: 'Pertempuran terakhir demi Middle-earth dimulai ketika Gandalf dan Aragorn memimpin Pasukan Manusia melawan pasukan Sauron untuk mengalihkan perhatiannya dari Frodo dan Sam yang sedang menuju Gunung Doom.',
    ),
    const Movie(
      title: 'Toy Story',
      year: 1995,
      genre: 'Animation, Adventure, Comedy',
      rating: 8.3,
      posterUrl: 'https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg',
      description: 'Sebuah boneka koboi bernama Woody merasa terancam dan cemburu ketika sebuah figurin astronot baru yang canggih, Buzz Lightyear, merebut hati pemiliknya.',
    ),
    const Movie(
      title: 'The Lion King',
      year: 1994,
      genre: 'Animation, Adventure, Drama',
      rating: 8.5,
      posterUrl: 'https://image.tmdb.org/t/p/w500/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg',
      description: 'Petualangan epik seekor anak singa bernama Simba, yang harus melarikan diri dari kelompoknya setelah pamannya yang jahat membunuh ayahnya untuk merebut tahta.',
    ),
    const Movie(
      title: 'Parasite',
      year: 2019,
      genre: 'Comedy, Drama, Thriller',
      rating: 8.5,
      posterUrl: 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
      description: 'Keserakahan dan diskriminasi kelas mulai memunculkan masalah ketika keluarga miskin Kim perlahan-lahan mulai bekerja di rumah keluarga kaya Park dengan berpura-pura menjadi profesional.',
    ),
    const Movie(
      title: 'Jurassic Park',
      year: 1993,
      genre: 'Action, Adventure, Sci-Fi',
      rating: 8.2,
      posterUrl: 'https://image.tmdb.org/t/p/w500/b6qUu00iIIkXX13szFy7d0CyNcg.jpg',
      description: 'Taman hiburan dinosaurus hasil rekayasa genetika mengalami bencana besar ketika pemadaman listrik menyebabkan dinosaurus-dinosaurus ganas itu lepas dari kandangnya.',
    ),
  ];

  // Fungsi untuk menambah/menghapus film dari daftar favorit
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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isFavorite = favoriteTitles.contains(movie.title);
          return _buildMovieCard(context, movie, isFavorite);
        },
      ),
    );
  }

  Widget _buildMovieCard(BuildContext context, Movie movie, bool isFavorite) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman detail saat list ditekan
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailPage(
                movie: movie,
                initialFavorite: isFavorite,
                onToggleFavorite: _toggleFavorite,
              ),
            ),
          );
        },
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
            // Tombol Favorit di List
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                _toggleFavorite(movie.title);
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

// Halaman Detail
class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final bool initialFavorite;
  final Function(String) onToggleFavorite;

  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.initialFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    // Memanggil fungsi dari parent agar list juga ter-update
    widget.onToggleFavorite(widget.movie.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.movie.posterUrl,
              height: 450,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 450,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.movie, size: 100, color: Colors.grey),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.movie.title,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      // Tombol Favorit di Detail
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 32,
                        ),
                        onPressed: _toggleFavorite,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.movie.year} • ${widget.movie.genre}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 24),
                      const SizedBox(width: 4),
                      Text(
                        widget.movie.rating.toString(),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.movie.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
