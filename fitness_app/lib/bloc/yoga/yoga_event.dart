part of 'yoga_bloc.dart';

@immutable
abstract class YogaEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class YogaRequested extends YogaEvent {
  final String Day;
  

  YogaRequested({required this.Day});

  @override
  List<Object> get props => [Day];
}