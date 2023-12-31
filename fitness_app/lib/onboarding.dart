import 'package:fitness_app/Auth.dart';
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
                    buildPage('Achieve Your Physique Goals', 'assets/bodyBuilder.png'),
                  ],
                ),
                Positioned(
                  bottom: 80,
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
                  child: ElevatedButton(
                    child: Text('Get Started', style: GoogleFonts.notoSans(
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF2FF00),
                      onPrimary: Colors.white,
                      minimumSize: Size(200, 50),
                    ),
                  ),
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
          Text(
            text,
            style: GoogleFonts.notoSans(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white),
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
