import 'package:equatable/equatable.dart';

abstract class DayEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DayRequested extends DayEvent {
  final String id;
  

  DayRequested({required this.id});

  @override
  List<Object> get props => [id];
}

abstract class DayState extends Equatable {
  @override
  List<Object> get props => [];
}

class DayInitial extends DayState {}

class DayLoading extends DayState {}

class Split {
  final String day;
  // Add other fields as necessary

  Split({required this.day});

  factory Split.fromJson(Map<String, dynamic> json) {
    return Split(
      day: json['day']
      // Parse other fields
    );
  }

  get split => null;
}

class DaySuccess extends DayState {
  final String day;
  
  DaySuccess({required this.day});

  @override
  List<Object> get props => [day];
}


class DayFailure extends DayState {
  final String error;

  DayFailure(this.error);

  @override
  List<Object> get props => [error];
}
