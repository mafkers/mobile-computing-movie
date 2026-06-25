import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/favorite_bloc.dart';
import 'screens/movie_catalog_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(),
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
