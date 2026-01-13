import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rickmarty/model/character.dart';
import 'package:rickmarty/model/favorite.dart';

class Initialization {

  Box<Favorite> get characterFavorite => Hive.box('favorites');

  Box<Character> get characterStore => Hive.box('character');

  Box<dynamic> get stringStore => Hive.box('store');

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CharacterAdapter());
    Hive.registerAdapter(FavoriteAdapter());
    await Hive.openBox<dynamic>('store');
    await Hive.openBox<Character>('character');
    await Hive.openBox<Favorite>('favorites');
  }
}