import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness_app/login_bloc.dart';
import 'package:fitness_app/login_event_state.dart';
import 'package:fitness_app/home_bloc.dart';
import 'package:fitness_app/home_event_state.dart';
import 'Register.dart';
import 'homepage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      context.read<LoginBloc>().add(LoginRequested(_email.trim(), _password.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/LOGO.png'),
    fit: BoxFit.cover,
  ),
),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 2500), 
                  child: 
                  Text(
                    "Login",
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(fontSize: 54, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ),
                  
                  SizedBox(height: 10,),
                  FadeInUp(duration: Duration(milliseconds: 2800), child: 
                  Text(
                    "Sign in to your account",
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    textAlign: TextAlign.center,
                  )
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  
                  padding: EdgeInsets.all(30),
                  child: BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginLoading) {
                        setState(() => _isLoading = true);
                      } else if (state is LoginSuccess) {
                        setState(() => _isLoading = false);
                    context.read<DayBloc>().add(DayRequested(id: state.user.id));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      } else if (state is LoginFailure) {
                        setState(() => _isLoading = false);
                      }
                    },
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          // Email Field
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
                SizedBox(height: 5),
                if (_isLoading) CircularProgressIndicator(),
                if (!_isLoading) 
                          SizedBox(height: 5,),
                         TextButton(
    onPressed: () {
      // TODO: Implement forgot password functionality
    },
    child: Text(
      "Forgot Password?",
      style: TextStyle(color: Colors.grey),
    ),
  ),

                        SizedBox(height: 10,),
                         MaterialButton(
                          onPressed: _trySubmit,
                          height: 50,
                          // margin: EdgeInsets.symmetric(horizontal: 50),
                          color:  Color(0xFFF2FF00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          ),
                          // decoration: BoxDecoration(
                          // ),
                          child: Center(
                            child: Text("LOGIN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(height: 100,),
                         TextButton(
                   child:  Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                    ), 
                   onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },

                  ), 
                                     // Additional UI elements can be added here
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
