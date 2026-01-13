import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmarty/app_status/rick_marty_status.dart';
import 'package:rickmarty/bloc/rick_marty_bloc/rick_marty_event.dart';
import 'package:rickmarty/bloc/rick_marty_bloc/rick_marty_state.dart';
import 'package:http/http.dart' as http;
import 'package:rickmarty/cached_app/cached_app.dart';
import 'package:rickmarty/model/character.dart';

class RickMartyBloc extends Bloc<RickMartyEvent, RickMartyState> {
  RickMartyBloc() : super(RickMartyState()){
    on<RickMartyFetched>(_rickMartyListOfData);
    on<RickMartRefreshFetched>(_refreshData);
  }

  String rickMartyUrl = "https://rickandmortyapi.com/api/character";
  CachedApp cachedApp = CachedApp();
  List<Character> characterList = [];

  void _refreshData(RickMartRefreshFetched event, Emitter<RickMartyState> emitter) async {
    characterList.clear();
    cachedApp.characterList.clear();
    try {
      var response = await http.get(
        Uri.parse(rickMartyUrl),
      );
      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      final data = jsonResponse['results'];
      for (var item in data) {
        Character character = Character.fromJson(item);
        characterList.add(character);
      }
      await cachedApp.addCharacterToHive(characterList);
      emitter(state.copyWith(rickMartyStatus: RickMartyStatus.success));
    } catch (error) {
      emitter(state.copyWith(rickMartyStatus: RickMartyStatus.fail));
      print('object');
    }
  }

  void _rickMartyListOfData(RickMartyFetched event, Emitter<RickMartyState> emitter) async {
    try {
      var response = await http.get(
        Uri.parse(rickMartyUrl),
      );
      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
       final data = jsonResponse['results'];
       characterList.clear();
       for (var item in data) {
         Character character = Character.fromJson(item);
         characterList.add(character);
       }
       if(cachedApp.characterList.isEmpty){
         await cachedApp.addCharacterToHive(characterList);
       }
       emitter(state.copyWith(rickMartyStatus: RickMartyStatus.success));
    } catch (error) {
      emitter(state.copyWith(rickMartyStatus: RickMartyStatus.fail));
      print('object');
    }
  }
}
