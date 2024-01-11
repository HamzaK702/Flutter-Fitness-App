
  
import 'package:fitness_app/bloc/history/history_bloc.dart';
import 'package:fitness_app/bloc/home/home_bloc.dart';
import 'package:fitness_app/bloc/home/home_event_state.dart';
import 'package:fitness_app/bloc/login/login_bloc.dart';
import 'package:fitness_app/bloc/login/login_event_state.dart';
import 'package:fitness_app/bloc/plan/plan_bloc.dart';
import 'package:fitness_app/bloc/start/start_bloc.dart';
import 'package:fitness_app/bloc/yoga/yoga_bloc.dart';
import 'package:fitness_app/scenes/history/consistency.dart';
import 'package:fitness_app/scenes/workouts/exercise.dart';
import 'package:fitness_app/scenes/plan/planWorkout.dart';
import 'package:fitness_app/scenes/main/profilePage.dart';
import 'package:fitness_app/scenes/workouts/yoga.dart';
import 'package:fitness_app/widgets/BottomNavBarWidget.dart';
import 'package:fitness_app/widgets/CustomCardWidget.dart';
import 'package:fitness_app/widgets/clickableImageWidget.dart';
import 'package:fitness_app/widgets/functionalityCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

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
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
        ClickableImageWithLink(
          imageUrl: "assets/ABS1.jpg",
          linkUrl: 'https://www.youtube.com/watch?v=DHD1-2P94DI&t=364s&pp=ygUWYXRobGVhbiB4IGNvcmUgd29ya291dA%3D%3D',
        ),
        ClickableImageWithLink(
          imageUrl: "assets/ABSmid.jpg",
          linkUrl: 'https://www.youtube.com/watch?v=J212vz33gU4&pp=ygUPY2FyZGlvIHdvcmtvdXQg',
        ),
        ClickableImageWithLink(
          imageUrl: "assets/ABS2.jpg",
          linkUrl: 'https://www.youtube.com/watch?v=UhgEocboADQ&pp=ygUMY29yZSB3b3Jrb3V0',
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
            child: InkWell(
              onTap: () {
                print("Stretch tapped");
                context.read<YogaBloc>().add(YogaRequested(Day: 'Stretch'));
                     Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => YogaPage()),
                      );
              },
              child: SizedBox(
                height: 180,
                width: 230,
                child: buildStretchSection(context),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                print("yoga tapped");
                context.read<YogaBloc>().add(YogaRequested(Day: 'Yoga'));
                     Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => YogaPage()),
                      );
                
              },
              child: SizedBox(
                height: 180,
                width: 230,
                child: buildYogaSection(context),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                print("cooldown tapped");
                context.read<YogaBloc>().add(YogaRequested(Day: 'Cooldown'));
                     Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => YogaPage()),
                      );
              },
              child: SizedBox(
                height: 180,
                width: 230,
                child: buildMeditationSection(context),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
   
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
                    print('Consistency Card Tapped');
                    context.read<HistoryBloc>().add(HistoryRequested(userId: ID));
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkoutHistoryPage()),
                   );
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
            Expanded(
  child: Column(
    children: [
      CustomCard(
        color: Color(0xFFF2FF00),
         textcolor: Color.fromARGB(255, 0, 0, 0),
        text: 'Start Workout',
        onTap: () {
          context.read<StartBloc>().add(WorkoutRequested(Day: dayInfo));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
          print("Start workout Tapped");
        },
      ),
      SizedBox(height: 8),
      CustomCard(
        color: Color(0xFF212121),
        textcolor: Color.fromARGB(255, 255, 255, 255),
        text: 'Weekly Plan',
        onTap: () {
          print("Weekly Plan Tapped");
          context.read<PlanBloc>().add(PlanRequested(id: ID));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutPlanPage(userId: ID),
            ),
          );
        },
      ),
    ],
  ),
)
          ],
        ),
      );
       }

Widget buildMeditationSection(BuildContext context) {
  return SectionCard(
    backgroundColor: Color(0xFFbc5f53),
    title: "Relaxing Cool Down",
    duration: "12MIN",
  );
}

Widget buildYogaSection(BuildContext context) {
  return SectionCard(
    backgroundColor: Color(0xFF3e3e3e),
    title: "Deep Mindful Yoga",
    duration: "40MIN",
  );
}

Widget buildStretchSection(BuildContext context) {
  return SectionCard(
    backgroundColor: Color(0xFFa37263),
    title: "Relieving Stretch",
    duration: "15MIN",
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
      return Scaffold(
      backgroundColor: Colors.black, // Scaffold background color set to black
      body: Padding(
      padding: EdgeInsets.all(16.0),
      child: DarkProfileForm(), // Replace with your custom form widget
      ),
    );
    }
    }
