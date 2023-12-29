import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String height;
  final int weight;
  final int consist;
  // Add other fields as necessary

  User({required this.id, required this.firstName, required this.lastName, required this.email, required this.height, required this.weight, required this.consist});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      height: json['height'],
      weight: json['weight'],
      consist: json['consist'],
      // Parse other fields
    );
  }
}
class UpdateConsistRequested extends LoginEvent {
  // You can include any additional data needed for the update here
  // For example, you might need to pass the user's ID or other details
  final String userId;

  UpdateConsistRequested({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateDetailsRequested extends LoginEvent {
  // You can include any additional data needed for the update here
  // For example, you might need to pass the user's ID or other details
  final String id;
  final String firstName;
  final String lastName;
  final String height;
  
  UpdateDetailsRequested({ 
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.height,
    });

  @override
  List<Object> get props => [id, firstName, lastName, height];
}

class UpdateLoginRequested extends LoginEvent {
  final String id;
  final String firstName;
  final String lastName;
  final int consist;
  final int weight;
  final String height;
  final String email;

  UpdateLoginRequested({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.consist,
    required this.weight,
    required this.height,
    required this.email,
  });
}

class LoginSuccess extends LoginState {
  final User user;
  final String token;

  LoginSuccess({required this.user, required this.token});

  @override
  List<Object> get props => [user, token];
}


class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
