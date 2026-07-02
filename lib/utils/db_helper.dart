import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE movies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  year INTEGER,
  genre TEXT,
  rating REAL,
  posterUrl TEXT,
  description TEXT
)
''');
  }

  Future<void> cacheMovies(List<Movie> movies) async {
    final db = await instance.database;
    // Clear old cache
    await db.delete('movies');
    
    // Insert new movies
    for (var movie in movies) {
      await db.insert('movies', movie.toMap());
    }
  }

  Future<List<Movie>> getCachedMovies() async {
    final db = await instance.database;
    final result = await db.query('movies');
    
    return result.map((json) => Movie.fromMap(json)).toList();
  }
}
