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
                          child: Text('Hi, ${loginState.user.firstName}', style: GoogleFonts.roboto(
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
                     
                      SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: <Widget>[
                          _buildCard('Start Workout', 'assets/start.jpg', context, dayInfo, loginState.user.id),
                          _buildCard('Plan Workout', 'assets/plan.jpg', context,  dayInfo, loginState.user.id),
                          _buildCard('Gym Stats', 'assets/gym.png', context,  dayInfo, loginState.user.id),
                          _buildCard('Progress', 'assets/progress.png', context,  dayInfo, loginState.user.id),
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
 



  

  Widget _buildCard(String title, String imagePath, BuildContext context, String dayInfo, String ID) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (title == 'Start Workout') {
            context.read<StartBloc>().add(WorkoutRequested(Day: dayInfo)); 
            context.read<PlanBloc>().add(PlanRequested(id: ID));
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => WorkoutPlanPage()),
            );
            // Navigator.push(
            //   context, 
            //   MaterialPageRoute(builder: (context) => MainPage()),
            // );
          }
          else if (title == 'Plan Your Workout') {
            //context.read<PlanBloc>().add(PlanRequested(id: loginState.user.id));
             Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => WorkoutPlanPage()),
            );
          }
          else if (title == 'Gym Stats') {
            
          }
          else if (title == 'Progress') {
            
          }
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
