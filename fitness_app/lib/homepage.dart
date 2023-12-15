import 'package:fitness_app/login_bloc.dart';
import 'package:fitness_app/login_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2FF00),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Open drawer or perform another action
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Perform action on notification icon tap
            },
          ),
        ],
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
  builder: (context, state) {
    return Container(
      color: Colors.black,
      child: state is LoginSuccess ? Column(
        children: <Widget>[
          Text('Welcome, ${state.user.firstName}', style: TextStyle(color: Colors.white)),
          // Grid of cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: <Widget>[
              _buildCard('Start Workout', 'assets/start.jpg', context),
              _buildCard('Plan Workout', 'assets/plan.jpg', context),
              _buildCard('Gym Stats', 'assets/gym.png', context),
              _buildCard('Progress', 'assets/progress.png', context),
            ],
          ),
        ],
      ) : Text('Not logged in', style: TextStyle(color: Colors.white)),
    );
  },
),
    );
  }

  Widget _buildCard(String title, String imagePath, BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
