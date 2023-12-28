
  
import 'package:fitness_app/bloc/plan_bloc.dart';
import 'package:fitness_app/bloc/start_bloc.dart';
import 'package:fitness_app/exercise.dart';
import 'package:fitness_app/home_bloc.dart';
import 'package:fitness_app/home_event_state.dart';
import 'package:fitness_app/login_bloc.dart';
import 'package:fitness_app/login_event_state.dart';
import 'package:fitness_app/planWorkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;  // Default index for home page

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _selectedIndex == 0 ? buildHomePage(context) : buildProfilePage(context),
    bottomNavigationBar: Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[900]!, width: 2.0),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFFF2FF00),
        items: [
          
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          
        ],
        
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w200),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w200),
        elevation: 8.0, // Adds a shadow to the bottom navigation bar
      ),
    ),
  );
}



  Widget buildHomePage(BuildContext context) {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, loginState) {
      if (loginState is LoginSuccess) {
        return BlocBuilder<DayBloc, DayState>(
          builder: (context, dayState) {
            String dayInfo = '';
            if (dayState is DaySuccess) {
              dayInfo = dayState.day; // Get day information from DayBloc
            }
            return SingleChildScrollView( // Scrollable
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [Colors.black, Color.fromARGB(255, 9, 10, 22)],
                  ),
                ),
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
                          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white),
                        )),
                      ),
                    ),
                    buildSections(context, loginState.user.id, dayInfo, loginState.user.consist),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Meditation And Yoga', style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white),
                        )),
                      ),
                    ),
                    SizedBox(height: 12),
                    buildHorizontalScrollSection(context),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Cardio And Abs', style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white),
                        )),
                      ),
                    ),
                    SizedBox(height: 12),
                    buildHorizontalScrollSection2(context),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Text('Not logged in', style: TextStyle(color: Colors.white));
      }
    },
  );
}

Widget buildHorizontalScrollSection2(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector( // Using GestureDetector for onTap
                onTap: () async {
                  const url = 'https://www.youtube.com/watch?v=DHD1-2P94DI&t=364s&pp=ygUWYXRobGVhbiB4IGNvcmUgd29ya291dA%3D%3D';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    // Handle the error or show a message
                    print('Could not launch $url');
                 }
      },
      child: SizedBox(
        height: 180,
        width: 230,
        child: buildCardioSections(context, "assets/ABS1.jpg"),
      ),
    ),
  ),
),
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector( // Using GestureDetector for onTap
                onTap: () async {
                  const url = 'https://www.youtube.com/watch?v=J212vz33gU4&pp=ygUPY2FyZGlvIHdvcmtvdXQg';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    // Handle the error or show a message
                    print('Could not launch $url');
                 }
      },
      child: SizedBox(
        height: 180,
        width: 230,
        child: buildCardioSections(context, "assets/ABSmid.jpg"),
      ),
    ),
  ),
),
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector( // Using GestureDetector for onTap
                onTap: () async {
                  const url = 'https://www.youtube.com/watch?v=UhgEocboADQ&pp=ygUMY29yZSB3b3Jrb3V0';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    // Handle the error or show a message
                    print('Could not launch $url');
                 }
                },
                child: SizedBox(
                  height: 180,
                  width: 230,
                  child: buildCardioSections(context, "assets/ABS2.jpg"),
                ),
              ),
            ),
          ),
                ],
              ),
            );
          }

Widget buildHorizontalScrollSection(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 180,
              width: 230,
              child: buildStretchSection(context),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 180,
              width: 230,
              child: buildYogaSection(context),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 180,
              width: 230,
              child: buildMeditationSection(context),
            ),
          ),
        ),
      ],
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
                      color: Colors.grey[900],
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

Widget buildMeditationSection(BuildContext context) {
    return Card(
  color: Color(0xFFbc5f53),
 shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Relaxing Cool Down", style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
              )),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("12MIN", style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildYogaSection(BuildContext context) {
    return Card(
      color: Color(0xFF3e3e3e),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Deep Mindful Yoga", style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
              )),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("40MIN", style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStretchSection(BuildContext context) {
    return Card(
      color: Color(0xFFa37263),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Relieving Stretch", style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
              )),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("15MIN", style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }

    Widget buildCardioSections(BuildContext context, String image) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: [
            SizedBox(height: 130),
            Container(
          padding: const EdgeInsets.only(left: 5),
          color: Colors.grey[900],
          child: Row(
            mainAxisSize: MainAxisSize.min, // Use min to wrap content
            children: [
              Icon(Icons.play_arrow, color: Colors.white), // Play icon
              Text(" WATCH ON YOUTUBE ", style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
              )
              ),
           ],
            ),
            
            ),
          
          ],
        ),
      ),
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

  Widget buildProfilePage(BuildContext context) {
    
    return Text('Profile Page');
  }
}

