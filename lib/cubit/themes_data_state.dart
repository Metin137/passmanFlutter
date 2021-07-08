part of 'themes_data_cubit.dart';

@immutable
abstract class ThemesDataState {}

class ThemesDataInitial extends ThemesDataState {}

class ThemesDataLoaded extends ThemesDataState {
  final Map<String, Color> colors;

  ThemesDataLoaded({this.colors});
}
