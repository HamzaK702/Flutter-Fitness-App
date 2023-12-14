import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color(0xFFF2FF00), // Set the background color of the AppBar
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black), // Menu sidebar icon
          onPressed: () {
            // Open drawer or perform another action
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black), // Notifications icon
            onPressed: () {
              // Perform action on notification icon tap
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          _buildCard('Start Workout', 'assets/start.jpg', context),
          _buildCard('Plan Workout', 'assets/plan.jpg', context),
          _buildCard('Gym Stats', 'assets/gym.png', context),
          _buildCard('Progress', 'assets/progress.png', context),
        ],
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
