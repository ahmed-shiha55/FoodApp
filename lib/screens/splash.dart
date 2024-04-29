import 'package:flutter/material.dart';
import 'package:foodapp/widget/bottomnav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNAv()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 139, 28),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/download1.png'),
          ),
          Text(
            "Food App",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationColor: Colors.white,
              decorationThickness: 2,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade100,
              letterSpacing: 2,
              fontFamily: "Pacifico",
            ),
          ),
        ],
      )),
    );
  }
}
