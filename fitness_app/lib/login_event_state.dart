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
  // Add other fields as necessary

  User({required this.id, required this.firstName, required this.lastName, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      // Parse other fields
    );
  }
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
