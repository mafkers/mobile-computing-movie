import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState()) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  void _onToggleFavorite(ToggleFavoriteEvent event, Emitter<FavoriteState> emit) {
    // Create a new set from the old set
    final updatedFavorites = Set<String>.from(state.favoriteTitles);
    
    // Toggle the favorite
    if (updatedFavorites.contains(event.movieTitle)) {
      updatedFavorites.remove(event.movieTitle);
    } else {
      updatedFavorites.add(event.movieTitle);
    }
    
    // Emit the new state with the updated list
    emit(state.copyWith(favoriteTitles: updatedFavorites));
  }
}
