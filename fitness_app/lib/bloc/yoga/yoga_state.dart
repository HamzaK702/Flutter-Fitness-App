part of 'yoga_bloc.dart';



@immutable
abstract class YogaState {}

class YogaInitial extends YogaState {}

class YogaLoading extends YogaState {}



class YogaLoadedState extends YogaState {
    final Workout data;
    YogaLoadedState({required this.data});
}

class YogaErrorState extends YogaState {
    final String message;
    YogaErrorState(this.message);
}