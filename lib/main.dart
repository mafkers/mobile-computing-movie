import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/favorite_bloc.dart';
import 'blocs/movie_bloc.dart';
import 'repositories/movie_repository.dart';
import 'screens/movie_catalog_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(MovieRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Catalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const MovieCatalogPage(),
      ),
    );
  }
}
