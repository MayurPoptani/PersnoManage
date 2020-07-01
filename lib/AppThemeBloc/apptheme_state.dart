import 'package:equatable/equatable.dart';

abstract class AppThemeState extends Equatable {
  const AppThemeState();
}

class InitialAppThemeState extends AppThemeState {
  final bool darkModeOn;
  InitialAppThemeState(this.darkModeOn);
  @override
  List<Object> get props => [darkModeOn];
}

class AppThemeChangedState extends AppThemeState {
  final bool darkModeOn;
  AppThemeChangedState(this.darkModeOn);
  @override
  List<Object> get props => [darkModeOn];
}
