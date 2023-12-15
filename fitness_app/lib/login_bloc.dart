import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
  emit(LoginLoading());
  try {
      print("it is calling the api");
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
    } else {
      emit(LoginFailure('Login Failed'));
    }
  } catch (e) {
    emit(LoginFailure(e.toString()));
  }
}
}

  
   



