import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/login_button.dart';
import '../widgets/text_field.dart';

class SigninPage extends StatefulWidget {
  final void Function() ontap;
  const SigninPage({super.key, required this.ontap});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String? email;
  String? password;
  String? confirmPassword;
  bool isLoading = false;
  void signin() async {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password don\'t match'),
        ),
      );
    }
    isLoading = true;
    setState(() {});
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      authService.rigesterUser(
        email!,
        password!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Weak password'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already insue'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: Colors.red,
        ),
        //color: Colors.red,
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80, right: 80, left: 80),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('lib/assets/mainlogo.jpg'),
                ),
              ),
              const SizedBox(height: 65),
              Text(
                'Chat with people anytime ...',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 65),
              Text(
                'Signin',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                //ctrl: emailController,
                obsc: false,
                hintText: 'Enter your email: ...',
                onChanged: (eData) {
                  email = eData;
                },
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                //ctrl: passwordController,
                obsc: true,
                hintText: 'Enter your password: ...',
                onChanged: (pData) {
                  password = pData;
                },
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                //ctrl: confirmPasswordController,
                obsc: true,
                hintText: 'Confirm your password: ...',
                onChanged: (pcData) {
                  confirmPassword = pcData;
                },
              ),
              const SizedBox(height: 10),
              //log in button
              MyButton(
                label: 'Signin',
                ontap: signin,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: widget.ontap,
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
