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

  // Untuk parsing dari JSON API (TVMaze)
  factory Movie.fromJson(Map<String, dynamic> json) {
    final show = json.containsKey('show') ? json['show'] : json;
    
    int parsedYear = 0;
    if (show['premiered'] != null && show['premiered'].toString().length >= 4) {
      parsedYear = int.tryParse(show['premiered'].toString().substring(0, 4)) ?? 0;
    }

    String parsedGenre = '';
    if (show['genres'] != null && (show['genres'] as List).isNotEmpty) {
      parsedGenre = (show['genres'] as List).join(', ');
    }

    double parsedRating = 0.0;
    if (show['rating'] != null && show['rating']['average'] != null) {
      parsedRating = (show['rating']['average'] as num).toDouble();
    }

    String parsedImage = 'https://via.placeholder.com/500x750.png?text=No+Image';
    if (show['image'] != null && show['image']['medium'] != null) {
      parsedImage = show['image']['medium'];
    }

    String parsedDesc = show['summary'] ?? 'No description available.';
    parsedDesc = parsedDesc.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');

    return Movie(
      title: show['name'] ?? 'Unknown',
      year: parsedYear,
      genre: parsedGenre,
      rating: parsedRating,
      posterUrl: parsedImage,
      description: parsedDesc,
    );
  }

  // Untuk menyimpan ke SQLite Local Storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'year': year,
      'genre': genre,
      'rating': rating,
      'posterUrl': posterUrl,
      'description': description,
    };
  }

  // Untuk membaca dari SQLite Local Storage
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      year: map['year'] ?? 0,
      genre: map['genre'] ?? '',
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : 0.0,
      posterUrl: map['posterUrl'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

final List<Movie> dummyMovies = [
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
