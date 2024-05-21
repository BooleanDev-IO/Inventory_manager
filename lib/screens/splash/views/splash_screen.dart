import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inventory_manager/screens/login/views/login_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../reusable_widgets/neomorphic/neomorphic_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4)).whenComplete(() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        neomorphic_container(
          isGlass: false,
          borderRadius: 50,
          child: LottieBuilder.asset(
            "assets/lottiefiles/logo.json",
            fit: BoxFit.cover,
          ),
          height: 200,
          width: 200,
          backgroundColor: Theme.of(context).primaryColor,
          shadowColor1: Colors.black54,
          shadowColor2: Colors.white10,
        ).animate().fadeIn().slide(begin: Offset(-.5, 0), end: Offset(0, 0), duration: Duration(milliseconds: 500)).blurXY(begin: 10, end: 0),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "InventoHub",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
        ).animate().fadeIn().slide(begin: Offset(-.5, 0), end: Offset(0, 0), duration: Duration(milliseconds: 500)).blurXY(begin: 10, end: 0),
      ],
    )));
  }
}
