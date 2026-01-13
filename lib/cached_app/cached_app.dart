
import 'package:rickmarty/initialization/initialization.dart';
import 'package:rickmarty/model/character.dart';
import 'package:rickmarty/model/favorite.dart';

class CachedApp {

  Initialization init = Initialization();

  String themeText = 'theme_text';

  List<Character> get characterList => init.characterStore.values.toList();

  List<Favorite> get favoriteList => init.characterFavorite.values.toList();

  Future<void> addThemeText(bool isTheme) async => await init.stringStore.put(themeText, isTheme);

  Future<void> addCharacterToHive(List<Character> characterList) async => await init.characterStore.addAll(characterList);

  Future<void> addCharacterFavorite(Favorite favorite) async => await init.characterFavorite.add(favorite);

  Future<void> deleteCharacterFromHive() async => await init.characterStore.clear();

  Future<void> deleteFavoriteFromHive(int id) async => await init.characterFavorite.delete(id);
}