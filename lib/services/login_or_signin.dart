import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/signin_screen.dart';

class LogInOrSignin extends StatefulWidget {
  const LogInOrSignin({super.key});

  @override
  State<LogInOrSignin> createState() => _LogInOrSigninState();
}

class _LogInOrSigninState extends State<LogInOrSignin> {
  bool showloginScreen = true;
  void toggleScreens() {
    setState(() {
      showloginScreen = !showloginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginScreen) {
      return LoginPage(onTap: toggleScreens);
    } else {
      return SigninPage(ontap: toggleScreens);
    }
  }
}
