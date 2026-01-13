import 'dart:math' as math;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rickmarty/bloc/rick_marty_bloc/rick_marty_bloc.dart';
import 'package:rickmarty/bloc/rick_marty_bloc/rick_marty_state.dart';
import 'package:rickmarty/cached_app/cached_app.dart';
import 'package:rickmarty/initialization/initialization.dart';
import 'package:rickmarty/model/character.dart';
import 'package:rickmarty/model/favorite.dart';
import '../../app_items/rick_marty_item.dart';
import '../../bloc/rick_marty_bloc/rick_marty_event.dart';

class ListOfCharacterScreen extends StatefulWidget {
  const ListOfCharacterScreen({super.key});

  @override
  State<ListOfCharacterScreen> createState() => _ListOfCharacterScreenState();
}

class _ListOfCharacterScreenState extends State<ListOfCharacterScreen> {

  Future refreshData() async {
    context.read<RickMartyBloc>().add(RickMartRefreshFetched(context));
  }

  @override
  Widget build(BuildContetext) {
    CachedApp cachedApp = CachedApp();
    Initialization init = Initialization();
    return BlocBuilder<RickMartyBloc, RickMartyState>(
      builder: (context, state) {
        return CustomMaterialIndicator(
          onRefresh: refreshData,
          indicatorBuilder: (context, controller) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: CircularProgressIndicator(
                color: Colors.redAccent,
                value: controller.state.isLoading ? null : math.min(controller.value, 1.0),
              ),
            );
          },
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Character>('character').listenable(),
            builder: (context, Box<Character> box, _) {
              if (box.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              final character = box.values.toList();
              return ListView.builder(
                itemCount: character.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RickMartyItem(
                      press: () async {
                        if(character[index].isFavorite == false) {
                          character[index].isFavorite = !character[index].isFavorite;
                          Favorite favorite = Favorite(id: character[index].id, name: character[index].name, status: character[index].status, species: character[index].species, type: character[index].type, gender: character[index].gender, image: character[index].image, originName: character[index].originName, locationName: character[index].locationName, episode: character[index].episode, isFavorite: true);
                          await cachedApp.addCharacterFavorite(favorite);;
                          await character[index].save();
                        } else {
                          final key = init.characterFavorite.keys.firstWhere((key) => init.characterFavorite.get(key)?.id == character[index].id);
                          await init.characterFavorite.delete(key);
                          character[index].isFavorite = false;
                          await character[index].save();
                        }
                      },
                      character: character[index],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
