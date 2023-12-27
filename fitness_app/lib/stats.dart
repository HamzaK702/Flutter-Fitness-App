import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Stats')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // 'Finished' card that takes half the width and specific height
            Expanded(
              child: Align(
  alignment: Alignment.topLeft,
  child: SizedBox(
    width: MediaQuery.of(context).size.width / 2 - 12, // Half the screen width minus half the space between cards
    height: 160, // Height for the 'Finished' card
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Finished', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('12', style: Theme.of(context).textTheme.headline4),
            Text('Completed\n Workouts', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    ),
  ),
),
            ),
            SizedBox(width: 8),
            // Column for the 'In Progress' and 'Time Spent' cards
            Expanded(
              child: Column(
                children: [
                  // 'In Progress' card with specific height
                  SizedBox(
                    height: 75, // Adjusted height for the 'In Progress' card
                    child: Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           
                             
                            Text('Start Workout', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Spacing between the cards
                  // 'Time Spent' card with specific height
                  SizedBox(
                    height: 75, // Adjusted height for the 'Time Spent' card
                    child: Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text('Plan Workouts', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
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