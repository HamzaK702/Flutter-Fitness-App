part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HistoryRequested extends HistoryEvent {
  final String userId;

  HistoryRequested({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateHistory extends HistoryEvent {
  final String userId;
  final String workoutName;

  UpdateHistory({required this.userId, required this.workoutName});

  @override
  List<Object> get props => [userId, workoutName];
}
