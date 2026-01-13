import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmarty/app_status/favorite_status.dart';
import 'package:rickmarty/bloc/favorite_bloc/favorite_event.dart';
import 'package:rickmarty/bloc/favorite_bloc/favorite_state.dart';
import 'package:rickmarty/cached_app/cached_app.dart';
import 'package:rickmarty/model/favorite.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState>{
  FavoriteBloc() : super (FavoriteState()){
    on<FavoriteSearchChanged>(_favoriteSearchChanged);
  }

  List<Favorite> searchFavorite = [];
  CachedApp cachedApp = CachedApp();

  void _favoriteSearchChanged(FavoriteSearchChanged event, Emitter<FavoriteState> emitter) {
    searchFavorite.clear();
    final index = cachedApp.favoriteList.indexWhere((element) => element.name.toLowerCase() == event.name.toLowerCase());
    if(index != -1) {
      searchFavorite.add(cachedApp.favoriteList[index]);
      emitter(state.copyWith(favoriteStatus: FavoriteStatus.success, searchFavorite: searchFavorite));
    } else {
      emitter(state.copyWith(favoriteStatus: FavoriteStatus.empty));
    }
  }
}