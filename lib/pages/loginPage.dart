import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  final loginFunction;
  final signUpFunction;

  const LogInPage(this.loginFunction, this.signUpFunction);

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(
            onPressed: () async {
              await loginFunction();
            },
            child: Text('Sign In'),
          ),
            SizedBox(width: 50),
            ElevatedButton(
              onPressed: () async {
                await signUpFunction();
              },
              child: Text('Sign Up'),
            ),
          ]
      ),
    );
  }
}