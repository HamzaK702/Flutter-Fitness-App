
import 'package:fitness_app/home_event_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<UpdateConsistRequested>(_onUpdateConsistRequested);
    on<UpdateDetailsRequested>(_onUpdateDetailsRequested);
     // New event
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      print("it is calling the API: ${event.email} and ${event.password}");
      final response = await http.post(
        Uri.parse('http://localhost:3001/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': event.email,
          'password': event.password,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final user = User.fromJson(responseData['user']);
        final token = responseData['token'];
        emit(LoginSuccess(user: user, token: token));
        print("Login successful");
        print("User: ${user} and token: ${token}");
      } else {
        emit(LoginFailure('Login Failed'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }



    Future<void> _onUpdateDetailsRequested(UpdateDetailsRequested event, Emitter<LoginState> emit) async {
    final loginState = state;
    if (loginState is LoginSuccess) {
      final updatedUser = User(
        id: loginState.user.id,
        firstName: event.firstName,
        lastName: event.lastName,
        email: loginState.user.email,
        height: event.height,
        weight: loginState.user.weight,
        consist: loginState.user.consist, // Increment consist by 1
      );

      // Update the user's consist value in the state
     

      // Make the API call
      await _makeUpdateApiCall( 
        userId: updatedUser.id,
        firstName: updatedUser.firstName,
        lastName: updatedUser.lastName,
        email: updatedUser.email,
        height: updatedUser.height,
        weight: updatedUser.weight,
        consist: updatedUser.consist,);
      
      final updatedLoginState = LoginSuccess(user: updatedUser, token: loginState.token);
      emit(updatedLoginState);
    }
  }


 Future<void> _makeUpdateApiCall({
  required String userId,
  required String firstName,
  required String lastName,
  required String email,
  required String height,
  required int weight,
  required int consist,
}) async {
  final String apiUrl = 'http://localhost:3001/auth/update/$userId'; // Replace with your actual backend URL

  try {
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'height': height,
        'weight': weight,
        'consist': consist,
      }),
    );

    if (response.statusCode == 200) {
      print("User information updated successfully");
    } else {
      print("Failed to update user information: ${response.body}");
    }
  } catch (e) {
    print("Error making API Call: $e");
  }
}


  // New event handler to update user's consist value
  Future<void> _onUpdateConsistRequested(UpdateConsistRequested event, Emitter<LoginState> emit) async {
    final loginState = state;
    if (loginState is LoginSuccess) {
      final updatedUser = User(
        id: loginState.user.id,
        firstName: loginState.user.firstName,
        lastName: loginState.user.lastName,
        email: loginState.user.email,
        height: loginState.user.height,
        weight: loginState.user.weight,
        consist: loginState.user.consist + 1, // Increment consist by 1
      );

      // Update the user's consist value in the state
      final updatedLoginState = LoginSuccess(user: updatedUser, token: loginState.token);
      emit(updatedLoginState);

      // Make the API call
      await _makeApiCall(updatedUser.id);
       
    }
  }

  Future<void> _makeApiCall(String userId) async {
    final String apiUrl = 'http://localhost:3001/plan/finishWorkout';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
        }),
      );

      if (response.statusCode == 200) {
        print("API Call successful");
      } else {
        print("API Call failed: ${response.body}");
      }
    } catch (e) {
      print("Error making API Call: $e");
    }
  }
}


  
   



