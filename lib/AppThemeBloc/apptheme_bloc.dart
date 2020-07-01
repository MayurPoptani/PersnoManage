import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';
import './bloc.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  //ignore: close_sinks
  static final AppThemeBloc _appThemeBlocSingleton = AppThemeBloc._internal();
  
  factory AppThemeBloc() => _appThemeBlocSingleton;

  bool darkModeOn;
  AppThemeBloc._internal() {
    print("Called AppThemeBloc._internal()");
    try {
      darkModeOn = PersnoManageGlobal.isDarkModeOn ?? false;
    } catch(e) {
      print("MY EXCEPTION = "+e.toString());
    }
  }

  @override
  AppThemeState get initialState => InitialAppThemeState(PersnoManageGlobal.isDarkModeOn);

  @override
  Stream<AppThemeState> mapEventToState(
    AppThemeEvent event,
  ) async* {
    darkModeOn = !darkModeOn;
    PersnoManageGlobal.setAppThemeState(darkModeOn);
    yield AppThemeChangedState(darkModeOn);
  }
}
