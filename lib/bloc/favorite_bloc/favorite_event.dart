
import 'package:equatable/equatable.dart';

class FavoriteEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FavoriteSearchChanged extends FavoriteEvent {

  final String name;

  FavoriteSearchChanged(this.name);
}