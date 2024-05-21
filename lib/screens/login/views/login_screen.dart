import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inventory_manager/reusable_widgets/neomorphic/neomorphic_container.dart';
import 'package:inventory_manager/screens/home/views/home_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../reusable_widgets/neomorphic/neomorphic_button.dart';
import '../../../reusable_widgets/neomorphic/neomorphic_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
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
                    child: Wrap(direction: Axis.vertical, alignment: WrapAlignment.start, crossAxisAlignment: WrapCrossAlignment.start, children: [
                      Text(
                        "InventoHub",
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
                      ).animate().fadeIn().slide(begin: Offset(-.5, 0), end: Offset(0, 0), duration: Duration(milliseconds: 500)).blurXY(begin: 10, end: 0),
                      Text(
                        "Empower Your Inventory. Simplify Your Business",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                      ).animate().fadeIn().slide(begin: Offset(-.5, 0), end: Offset(0, 0), duration: Duration(milliseconds: 500)).blurXY(begin: 10, end: 0),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Stack(fit: StackFit.expand, children: [
                Container(
                  child: LottieBuilder.asset(
                    "assets/lottiefiles/background.json",
                    fit: BoxFit.fill,
                  ),
                ).animate().blurXY(begin: 100, end: 100),
                Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: Center(
                    child: neomorphic_container(
                      isGlass: true,
                      padding: 64,
                      backgroundColor: Theme.of(context).primaryColor,
                      shadowColor1: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.black12,
                      shadowColor2: Colors.white10,
                      borderRadius: 50,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 24,
                        runSpacing: 64,
                        children: [
                          Text(
                            "Welcome!",
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
                          ).animate().fadeIn(),
                          TextFormField(
                            decoration: InputDecoration(labelText: "User ID", isDense: true),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "PIN", isDense: true),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                        EdgeInsets.all(32),
                                      ),
                                      backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)))),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ));
                                  },
                                  child: Text("LOGIN"),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text("Don't have an account?", style: Theme.of(context).textTheme.bodyMedium!),
                              GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Sign Up",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}

//  neomorphic_TextFormField(
//                             backgroundColor: Theme.of(context).primaryColor,
//                             shadowColor1: Colors.black54,
//                             shadowColor2: Colors.white10,
//                             borderRadius: 24,
//                             label: "User ID",
//                           ),
//                           neomorphic_TextFormField(
//                             backgroundColor: Theme.of(context).primaryColor,
//                             shadowColor1: Colors.black54,
//                             shadowColor2: Colors.white10,
//                             borderRadius: 24,
//                             label: "PIN",
//                           ),
//                           neomorphic_Button(
//                             backgroundColor: Theme.of(context).primaryColor,
//                             shadowColor1: Colors.black54,
//                             shadowColor2: Colors.white10,
//                             borderRadius: 24,
//                             buttonText: "Login",
//                             onbuttonPressed: () {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => HomeScreen(),
//                                   ));
//                             },
//                           )