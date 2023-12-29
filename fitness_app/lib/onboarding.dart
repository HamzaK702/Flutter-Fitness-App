//import 'package:fitness_app/Auth.dart';
import 'package:fitness_app/AuthScreen.dart';
import 'package:fitness_app/widgets/customButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  late Future<void> _loadImagesFuture;

  @override
  void initState() {
    super.initState();
    _loadImagesFuture = _precacheImages();
  }

  Future<Future<List<void>>> _precacheImages() async {
    return Future.wait([
      precacheImage(AssetImage('assets/runningMan.png'), context),
      precacheImage(AssetImage('assets/runningGirl.png'), context),
      precacheImage(AssetImage('assets/runningManRight.png'), context),
      precacheImage(AssetImage('assets/bodyBuilder.png'), context),
      precacheImage(AssetImage('assets/LOGO.png'), context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadImagesFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                PageView(
                  controller: _controller,
                  children: <Widget>[
                    buildPage('Start Your Fitness Journey', 'assets/runningMan.png'),
                    buildPage('Plan your workouts', 'assets/runningGirl.png'),
                    buildPage('Your Personal Fitness Tracker', 'assets/runningManRight.png'),
                    buildPage('Volume up your body goals', 'assets/bodyBuilder.png'),
                  ],
                ),
                Positioned(
                  bottom: 100,
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                      dotWidth: 8.0,
                      dotHeight: 8.0,
                      activeDotColor: Colors.white,
                      dotColor: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: CustomElevatedButton(
                    buttonText: 'GET STARTED',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    
                  )
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildPage(String text, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
     child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Left and right padding
              child: Text(
                text.toUpperCase(),
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
    );
  }
}