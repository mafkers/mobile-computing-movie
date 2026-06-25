import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final Set<String> favoriteTitles;

  const FavoriteState({this.favoriteTitles = const {}});

  @override
  List<Object> get props => [favoriteTitles];

  FavoriteState copyWith({Set<String>? favoriteTitles}) {
    return FavoriteState(
      favoriteTitles: favoriteTitles ?? this.favoriteTitles,
    );
  }
}
