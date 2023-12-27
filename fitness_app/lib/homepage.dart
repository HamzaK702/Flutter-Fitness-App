import 'package:fitness_app/bloc/plan_bloc.dart';
import 'package:fitness_app/bloc/start_bloc.dart';
import 'package:fitness_app/exercise.dart';
import 'package:fitness_app/home_bloc.dart';
import 'package:fitness_app/planWorkout.dart';
import 'package:fitness_app/startWorkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness_app/login_bloc.dart';
import 'login_event_state.dart';
import 'home_event_state.dart'; // Import DayState

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, loginState) {
          if (loginState is LoginSuccess) {
            return BlocBuilder<DayBloc, DayState>(
              builder: (context, dayState) {
                String dayInfo = '';
                if (dayState is DaySuccess) {
                  dayInfo = dayState.day; // Get day information from DayBloc
                }
                return Container(
                  color: Colors.black,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Hi, ${loginState.user.firstName} 👋', style: GoogleFonts.roboto(
                            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                          )),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Let's check your activity", style: GoogleFonts.roboto(
                            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white),
                          )),
                        ),
                      ),
                     buildSections(context, loginState.user.id, dayInfo, loginState.user.consist),
                      SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: <Widget>[
                          
                          // _buildCard('Start Workout', 'assets/start.jpg', context, dayInfo, loginState.user.id),
                          // _buildCard('Plan Workout', 'assets/plan.jpg', context,  dayInfo, loginState.user.id),
                          // _buildCard('Gym Stats', 'assets/gym.png', context,  dayInfo, loginState.user.id),
                          // _buildCard('Progress', 'assets/progress.png', context,  dayInfo, loginState.user.id),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Text('Not logged in', style: TextStyle(color: Colors.white));
          }
        },
      ),
    );
  }
   
@override
  Widget buildSections(BuildContext context, ID, dayInfo, consistency) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Row(
          children: [
            // 'Finished' card that takes half the width and specific height
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 12, // Half the screen width minus half the space between cards
                height: 160, // Height for the 'Finished' card
                 child: InkWell(
                  onTap: () {
                    // Add your onTap functionality here
                    print('Finished Card Tapped');
                  },
                        child: Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0), // Rounded borders
                  ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Consistency 👊", style: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[600]),
          )),
          SizedBox(height: 8),
          Text("$consistency", style: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 56, fontWeight: FontWeight.w800, color: Colors.white),
          )),
          Text('Completed Workouts', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.grey[600])),
        ],
      ),
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
                  InkWell(
                    onTap: () {
                      context.read<StartBloc>().add(WorkoutRequested(Day: dayInfo));
                     Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                      print("Start workout Tapped");
                    },
                    child: SizedBox(
                      height: 75, // Adjusted height for the 'In Progress' card
                      child: Card(
                        color: Color(0xFFF2FF00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), // Rounded borders
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Start Workout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Spacing between the cards
                  // 'Time Spent' card with specific height
                  InkWell(
                  onTap: () {
                    print("Weekly Plan Tapped");
                     context.read<PlanBloc>().add(PlanRequested(id: ID));
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => WorkoutPlanPage(userId: ID), // Replace 'yourUserId' with actual ID
                    ),
                  );
                  },
                  child: SizedBox(
                    height: 75, // Adjusted height for the 'Time Spent' card
                    child: Card(
                      color: Color(0xFF317773),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0), // Rounded borders
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Weekly Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                                ],
              ),
            ),
          ],
        ),
      );
      
    
  }


   Widget buildFinishedCard(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Consistency 👊", style: GoogleFonts.roboto(
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[600]),
            )),
            SizedBox(height: 8),
            Text("12", style: GoogleFonts.roboto(
              textStyle: TextStyle(fontSize: 56, fontWeight: FontWeight.w800, color: Colors.white),
            )),
            Text('Completed Workouts', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }


   Widget buildInProgressCard() {
    return SizedBox(
      height: 75,
      child: Card(
        color: Color(0xFFF2FF00),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Start Workout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }


   Widget buildTimeSpentCard() {
    return SizedBox(
      height: 75,
      child: Card(
        color: Color(0xFF317773),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Weekly Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

}
  


