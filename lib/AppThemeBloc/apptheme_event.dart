import 'package:equatable/equatable.dart';

abstract class AppThemeEvent extends Equatable {
  const AppThemeEvent();
}

class SwitchAppThemeEvent extends AppThemeEvent{
  @override
  List<Object> get props => null;
}