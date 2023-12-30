part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final WorkoutHistory workoutHistory;

  HistorySuccess(this.workoutHistory);

  @override
  List<Object?> get props => [workoutHistory];
}

class HistoryFailure extends HistoryState {
  final String message;

  HistoryFailure(this.message);

  @override
  List<Object?> get props => [message];
}
