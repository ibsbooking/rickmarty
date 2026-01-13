

import 'package:rickmarty/app_status/screens_pagination_status.dart';

class ScreenPaginationState {

  final ScreensPaginationStatus paginationStatus;

  ScreenPaginationState({
    this.paginationStatus = ScreensPaginationStatus.lists
  });

  ScreenPaginationState copyWith({
    ScreensPaginationStatus ? paginationStatus
  }){
    return ScreenPaginationState(
      paginationStatus: paginationStatus ?? this.paginationStatus,
    );
  }
}