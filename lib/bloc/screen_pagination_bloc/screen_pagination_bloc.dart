
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmarty/app_status/screens_pagination_status.dart';
import 'package:rickmarty/bloc/screen_pagination_bloc/screen_pagination_event.dart';
import 'package:rickmarty/bloc/screen_pagination_bloc/screen_pagination_state.dart';

class ScreenPaginationBloc extends Bloc<ScreenPaginationEvent, ScreenPaginationState>{
  ScreenPaginationBloc() : super(ScreenPaginationState()){
    on<ScreenPaginationListChanged>(_screenPaginationListChanged);
    on<ScreenPaginationFavoriteChanged>(_screenPaginationFavoriteChanged);
  }

  void _screenPaginationListChanged(ScreenPaginationListChanged event, Emitter<ScreenPaginationState> emitter) {
    emitter(state.copyWith(paginationStatus: ScreensPaginationStatus.lists));
  }

  void _screenPaginationFavoriteChanged(ScreenPaginationFavoriteChanged event, Emitter<ScreenPaginationState> emitter) {
    emitter(state.copyWith(paginationStatus: ScreensPaginationStatus.favorites));
  }
}