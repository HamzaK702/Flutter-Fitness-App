import 'package:fitness_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'Register.dart'; 
import 'dart:convert';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;



  void _trySubmit() async {
  final isValid = _formKey.currentState!.validate();
  FocusScope.of(context).unfocus(); // to close the keyboard

  if (isValid) {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    
    final response = await http.post(
      Uri.parse('http://localhost:3001/auth/login'), // Change to your server's IP when running on a real device
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _email.trim(),
        'password': _password.trim(),
      }),
    );
    
    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      print('Login successful');
      print(response.body);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

    } else {
      // Handle error
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to dark
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
    );
  }
}



