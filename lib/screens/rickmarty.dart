import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rickmarty/app_status/screens_pagination_status.dart';
import 'package:rickmarty/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:rickmarty/bloc/rick_marty_bloc/rick_marty_bloc.dart';
import 'package:rickmarty/bloc/screen_pagination_bloc/screen_pagination_bloc.dart';
import 'package:rickmarty/bloc/screen_pagination_bloc/screen_pagination_event.dart';
import 'package:rickmarty/bloc/screen_pagination_bloc/screen_pagination_state.dart';
import '../bloc/rick_marty_bloc/rick_marty_event.dart';
import 'favorite_screen/favorite_screen.dart';
import 'list_of_character_screen/list_of_character_screen.dart';

class RickMarty extends StatelessWidget {
  const RickMarty({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ScreenPaginationBloc(),
        ),
        BlocProvider(
            create: (_) => RickMartyBloc()..add(RickMartyFetched(context)),
        ),
        BlocProvider(
            create: (_) => FavoriteBloc(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rick and Marty", style: Theme.of(context).textTheme.headlineLarge,),
          actions: [
            AppThemeForm(),
          ],
        ),
        body: RickMartyPaginationForm(),
        bottomNavigationBar: BlocBuilder<ScreenPaginationBloc, ScreenPaginationState>(
            builder: (context, state) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        label: 'Home',
                        icon: Icon(
                            Icons.home, size: state.paginationStatus == ScreensPaginationStatus.lists ? 30 :20,
                        ),
                    ),
                    BottomNavigationBarItem(
                      label: 'favorite',
                      icon: Icon(
                          Icons.favorite, size: state.paginationStatus == ScreensPaginationStatus.favorites ? 30 : 20,
                      ),
                    )
                  ],
                onTap: (item) {
                  switch (item) {
                    case 0:
                      context.read<ScreenPaginationBloc>().add(ScreenPaginationListChanged());
                      break;
                    case 1:
                      context.read<ScreenPaginationBloc>().add(ScreenPaginationFavoriteChanged());
                  }
                },
              );
            }
        ),
      ),
    );
  }
}

class AppThemeForm extends StatelessWidget {
  const AppThemeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('store').listenable(),
        builder: (context, Box box, _) {
          return CupertinoSwitch(
              value: box.get('theme_text', defaultValue: false),
              onChanged: (value){
                box.put('theme_text', value);
              }
          );
        }
    );
  }
}


class RickMartyPaginationForm extends StatelessWidget {
  const RickMartyPaginationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenPaginationBloc, ScreenPaginationState>(
        builder: (context, state){
          switch (state.paginationStatus){
            case ScreensPaginationStatus.lists:
              return ListOfCharacterScreen();
            case ScreensPaginationStatus.favorites:
              return FavoriteScreen();
          }
        }
    );
  }
}
