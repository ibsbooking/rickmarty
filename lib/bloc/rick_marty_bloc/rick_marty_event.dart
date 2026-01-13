
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RickMartyEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class RickMartRefreshFetched extends RickMartyEvent {

  final BuildContext context;

  RickMartRefreshFetched(this.context);
}

class RickMartyFetched extends RickMartyEvent {

  final BuildContext context;

  RickMartyFetched(this.context);
}