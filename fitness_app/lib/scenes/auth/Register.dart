
import 'package:fitness_app/scenes/auth/login.dart';
import 'package:fitness_app/widgets/customTextButtonWidget.dart';
import 'package:fitness_app/widgets/customTextFieldWidget.dart';
import 'package:fitness_app/widgets/emailFieldWidget.dart';
import 'package:fitness_app/widgets/passwordFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
 

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  // Add other state variables if necessary

void _trySubmit() async {
  final isValid = _formKey.currentState!.validate();
  FocusScope.of(context).unfocus(); // to close the keyboard

  if (isValid) {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    
    final response = await http.post(
      Uri.parse('http://localhost:3001/auth/register'), // Change to your server's IP when running on a real device
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'firstName':_firstName.trim(),
        'lastName': _lastName.trim(),
        'email': _email.trim(),
        'password': _password.trim(),
      }),
    );
    
    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200 ) {
      print('Registered successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

    } else {
      print('Registration failed');
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
                CustomTextField(
                                key: ValueKey('firstName'),
                                onSaved: (value) {
                                  _firstName = value!;
                                },
                                hintText: 'First Name',
                                icon: Icons.person,
                              ),
                SizedBox(height: 12),
                CustomTextField(
                              key: ValueKey('lastName'),
                              onSaved: (value) {
                                _lastName = value!;
                              },
                              hintText: 'Last Name',
                              icon: Icons.person,
                            ),
                SizedBox(height: 12),
                EmailField(
                            key: ValueKey('email'),
                            initialValue: 'hmzkhan@gmail.com',
                            onSaved: (value) {
                              _email = value!;
                            },
                            ),
                SizedBox(height: 12),
                PasswordField(
                            key: ValueKey('password'),
                            initialValue: "hamza123",
                            onSaved: (value) {
                              _password = value!;
                            },
                    ),
                SizedBox(height: 20),
                if (_isLoading) CircularProgressIndicator(),
                if (!_isLoading) 
                 ElevatedButton(
                    child: Text('Register', style: GoogleFonts.notoSans(
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
                SizedBox(height: 20),
                if (!_isLoading) 
                  CustomTextButton(
                              text: "Already have an account?",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                );
                              },
                       
                            )

              ],
            ),
          ),
        ),
      ),
    );
  }
                 
                    } 

                   
   

 
