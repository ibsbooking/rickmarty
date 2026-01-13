
import 'package:rickmarty/app_status/favorite_status.dart';
import 'package:rickmarty/model/favorite.dart';

class FavoriteState {

  final List<Favorite> searchFavorite;
  final FavoriteStatus favoriteStatus;

  FavoriteState({
    this.searchFavorite = const <Favorite>[],
    this.favoriteStatus = FavoriteStatus.empty,
  });

  FavoriteState copyWith({
    List<Favorite> ? searchFavorite,
    FavoriteStatus ? favoriteStatus
  }){
    return FavoriteState(
      searchFavorite: searchFavorite ?? this.searchFavorite,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
    );
  }
}