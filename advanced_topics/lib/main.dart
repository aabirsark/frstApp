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
    var progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _fromProgress = progress;
    });
  }

  void _showWelcomePage() {
    Navigator.pushNamed(context, MyRoutes.welcomePageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedProgressIndicator(value: _fromProgress),
          Text(
            "Sign Up Form",
            style: Theme.of(context).textTheme.headline3,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: InputDecoration(hintText: "First name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: InputDecoration(hintText: "Last name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: InputDecoration(hintText: "Username"),
            ),
          ),
          TextButton(
            onPressed: _fromProgress == 1 ? _showWelcomePage : null,
            child: Text("Submit"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) =>
                  states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white),
              backgroundColor: MaterialStateProperty.resolveWith((states) =>
                  states.contains(MaterialState.disabled) ? null : Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({Key key, this.value}) : super(key: key);

  @override
  _AnimatedProgressIndicatorState createState() =>
      _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  // ? animation variable
  AnimationController _controller;
  Animation<Color> _colorAnim;
  Animation<double> _doubleAnimation;

  // init state
  @override
  void initState() {
    super.initState();

    // ? Animation Controller
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));

    // ? color tween squence
    final colorTween = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: Colors.red, end: Colors.orange), weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Colors.orange, end: Colors.yellow), weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Colors.yellow, end: Colors.green), weight: 1),
    ]);

    // ? initializing Value

    _colorAnim = _controller.drive(colorTween);
    _doubleAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return LinearProgressIndicator(
          value: _doubleAnimation.value,
          valueColor: _colorAnim,
          backgroundColor: _colorAnim.value.withOpacity(0.3),
        );
      },
    );
  }
}


