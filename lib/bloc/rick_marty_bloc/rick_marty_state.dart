
import 'package:rickmarty/app_status/rick_marty_status.dart';
import 'package:rickmarty/cached_app/cached_app.dart';
import 'package:rickmarty/model/character.dart';

class RickMartyState {

  final CachedApp? cachedApp;
  final List<Character> characterList;
  final RickMartyStatus rickMartyStatus;

  RickMartyState({
    this.cachedApp,
    this.characterList = const <Character>[],
    this.rickMartyStatus = RickMartyStatus.success,
  });

  RickMartyState copyWith({
    CachedApp ? cachedApp,
    List<Character> ? characterList,
    RickMartyStatus ? rickMartyStatus
  }){
    return RickMartyState(
      cachedApp: cachedApp ?? this.cachedApp,
      characterList: characterList ?? this.characterList,
      rickMartyStatus: rickMartyStatus ?? this.rickMartyStatus,
    );
  }
}