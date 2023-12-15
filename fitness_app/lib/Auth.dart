import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness_app/login_bloc.dart';
import 'package:fitness_app/login_event_state.dart';
import 'package:fitness_app/home_bloc.dart';
import 'package:fitness_app/home_event_state.dart';
import 'Register.dart'; 
import 'homepage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); // to close the keyboard

    if (isValid) {
      _formKey.currentState!.save();
      // Dispatching LoginRequested event to LoginBloc
      context.read<LoginBloc>().add(LoginRequested(_email.trim(), _password.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/LOGO.png'), // Ensure this path is correct
            fit: BoxFit.cover,
          ),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              setState(() => _isLoading = true);
            } else if (state is LoginSuccess) {
              setState(() => _isLoading = false);
              context.read<DayBloc>().add(DayRequested(id: state.user.id));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())); // Assuming HomeScreen exists
            } else if (state is LoginFailure) {
              setState(() => _isLoading = false);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     SizedBox(height: 350),
                     Align(
                      alignment: Alignment.centerLeft,
                      child:  Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0), // Left and right padding
                          child: Text(
                            "SIGN IN",
                            style: GoogleFonts.notoSans(
                              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                     ),
         
                    SizedBox(height: 12),
                    TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'Email Address',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white70,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: false,
                ),
                SizedBox(height: 12),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white70,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                if (_isLoading) CircularProgressIndicator(),
                if (!_isLoading) 
                 ElevatedButton(
                    child: Text('Login', style: GoogleFonts.notoSans(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),), 
                  onPressed: () {
                       if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _trySubmit();
                        // Perform login logic here
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF2FF00), // Button color
                      onPrimary: Colors.white, // Text color
                      minimumSize: Size(200, 50), // Button size
                    ),
            ),
                 
                if (!_isLoading) 
                  TextButton(
                   child: Text('Create new account', style: GoogleFonts.notoSans(
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
              ),), 
                   onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },

                  ),
              ],
                  
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:fitness_app/home_bloc.dart';
// import 'package:fitness_app/home_event_state.dart';
// import 'package:fitness_app/homepage.dart';
// import 'package:fitness_app/login_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'Register.dart'; 


// import 'login_event_state.dart';

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _email = '';
//   String _password = '';
//   bool _isLoading = false;



//   void _trySubmit() {
//   final isValid = _formKey.currentState!.validate();
//   FocusScope.of(context).unfocus(); // to close the keyboard

//   if (isValid) {
//     _formKey.currentState!.save();
//     // Dispatching LoginRequested event to LoginBloc
//     context.read<LoginBloc>().add(LoginRequested(_email.trim(), _password.trim()));
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, // Set the background color to dark
//       body: BlocListener<LoginBloc, LoginState>(
//         listener: (context, state) {
//           if (state is LoginLoading) {
//             print("button pressed");
//             setState(() => _isLoading = true);
//           } else if (state is LoginSuccess) {
//             print("Login done");
//             setState(() => _isLoading = false);
            
//             context.read<DayBloc>().add(DayRequested(id: state.user.id));
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())); // Assuming HomeScreen exists
//           } else if (state is LoginFailure) {
//             setState(() => _isLoading = false);
//             print("some error");
//           }
//         },
//         child:Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
               
//             ),
//           ),
//         ),
//       ),
//     )
//     );
//   }
// }



