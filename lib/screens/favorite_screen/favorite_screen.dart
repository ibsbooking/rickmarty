import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rickmarty/app_items/favorite_item.dart';
import 'package:rickmarty/app_status/favorite_status.dart';
import 'package:rickmarty/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:rickmarty/bloc/favorite_bloc/favorite_state.dart';
import 'package:rickmarty/cached_app/cached_app.dart';
import '../../bloc/favorite_bloc/favorite_event.dart';
import '../../model/favorite.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FavoriteSearchWithName(),
        Expanded(child: FavoriteListsForm()),
      ],
    );
  }
}

class FavoriteSearchWithName extends StatelessWidget {
  const FavoriteSearchWithName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (name)  => context.read<FavoriteBloc>()
                  .add(FavoriteSearchChanged(name)),
              decoration: InputDecoration(
                hintText: 'Search with name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black,)
              ),
            ),
          );
        }
    );
  }
}


class FavoriteListsForm extends StatelessWidget {
  const FavoriteListsForm({super.key});

  @override
  Widget build(BuildContext context) {
    CachedApp cachedApp = CachedApp();
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          switch (state.favoriteStatus){
            case FavoriteStatus.empty:
              return ValueListenableBuilder(
                  valueListenable: Hive.box<Favorite>('favorites').listenable(),
                  builder: (context, Box<Favorite> box, _){
                    if (box.isEmpty) {
                      return Center(child: Text('There is no favorites'),);
                    }
                    final favorite = box.values.toList();
                    return ListView.builder(
                        itemCount: box.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return FavoriteItem(
                            favorite: favorite[index],
                            press: () {
                              final index1 = cachedApp.characterList.indexWhere((element) => element.id == favorite[index].id);
                              cachedApp.characterList[index1].isFavorite = false;
                              cachedApp.characterList[index1].save();
                              favorite[index].delete();
                              favorite[index].save();
                            },
                          );
                        }
                    );
                  }
              );
            case FavoriteStatus.success:
              return ListView.builder(
                  itemCount: state.searchFavorite.length,
                  itemBuilder: (context, index) {
                    return FavoriteItem(
                        favorite: state.searchFavorite[index],
                        press: (){}
                    );
                  }
              );
          }
        }
    );
  }
}

