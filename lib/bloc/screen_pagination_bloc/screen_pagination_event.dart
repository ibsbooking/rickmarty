
import 'package:equatable/equatable.dart';

class ScreenPaginationEvent extends Equatable{

  @override
  List<Object?> get props => [];
 }

 class ScreenPaginationListChanged extends ScreenPaginationEvent {}

class ScreenPaginationFavoriteChanged extends ScreenPaginationEvent {}