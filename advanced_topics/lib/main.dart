import 'dart:html';

import 'package:advanced_topics/utils/routes_.dart';
import 'package:flutter/material.dart';

void main() => runApp(SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.signUpPageRoute: (context) => SignUpScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class WelocomeScreen extends StatelessWidget {
  const WelocomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
          child: Text(
        "Welcome",
        style: Theme.of(context).textTheme.headline2,
      )),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // ! textField Controller
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _fromProgress = 0.0;

  void _updateFormProgress() {
    var _progress = 0.0;

    final _controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController,
    ];

    // ? for loop
    for (final controller in _controllers) {
      if (controller.value.text.isNotEmpty) {
        _progress += 1 / _controllers.length;
      }
    }

    /// out of [for looop]
    setState(() {
      _fromProgress = _progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _fromProgress),
        ],
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatelessWidget {
  final value;

  const AnimatedProgressIndicator({Key key, this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}
