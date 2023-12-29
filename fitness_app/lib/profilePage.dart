import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc.dart'; // Replace with your actual login_bloc.dart import
import 'login_event_state.dart'; // Replace with your actual login_event_state.dart import

class DarkProfileForm extends StatefulWidget {
  @override
  _DarkProfileFormState createState() => _DarkProfileFormState();
}

class _DarkProfileFormState extends State<DarkProfileForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  bool isFormChanged = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        if (loginState is LoginSuccess) {
          final user = loginState.user;

          if (!isFormChanged) {
            _firstNameController.text = user.firstName;
            _lastNameController.text = user.lastName;
            _heightController.text = user.height;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DarkTextField(
                label: 'First Name',
                controller: _firstNameController,
                onChanged: (value) => _onFieldChanged(),
              ),
              DarkTextField(
                label: 'Last Name',
                controller: _lastNameController,
                onChanged: (value) => _onFieldChanged(),
              ),
              DarkTextField(
                label: 'Height',
                controller: _heightController,
                onChanged: (value) => _onFieldChanged(),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: isFormChanged,
                child: ElevatedButton(
                  onPressed: _updateUserDetails(user.id),
                  child: Text('Update Details'),
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _onFieldChanged() {
    setState(() {
      isFormChanged = true;
    });
  }

   _updateUserDetails(id) {
    if (isFormChanged) {
      final updateDetailsEvent = UpdateDetailsRequested(
        id: id,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        height: _heightController.text, 
      );

      BlocProvider.of<LoginBloc>(context).add(updateDetailsEvent);
    }
  }
}


class DarkTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  DarkTextField({
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: onChanged,
    );
  }
}