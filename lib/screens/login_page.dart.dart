import '../services/auth_service.dart';
import '../widgets/login_button.dart';
import '../widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? passWord;
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  void login() async {
    isLoading = true;
    setState(() {});
    //get the auth method from auth_service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
        email!,
        passWord!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something wrong with you email or password'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
      print(e);
      isLoading = false;
      setState(() {});
      //setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(color: Colors.red),
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
                'Login',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                //ctrl: 'emailController',
                obsc: false,
                hintText: 'Enter your email: ...',
                onChanged: (edata) {
                  email = edata;
                },
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                //ctrl: passwordController,
                obsc: true,
                hintText: 'Enter your password: ...',
                onChanged: (pdata) {
                  passWord = pdata;
                },
              ),
              const SizedBox(height: 10),
              //log in button
              MyButton(
                label: 'Login',
                ontap: login,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: widget.onTap,
                    child: Text(
                      'Signin',
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
