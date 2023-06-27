import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  final loginFunction;

  const LogInPage(this.loginFunction);

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(
            onPressed: () async {
              await loginFunction();
              // appState.userLogin();
            },
            child: Text('Sign In'),
          ),
            SizedBox(width: 50),
            ElevatedButton(
              onPressed: () async {
                await loginFunction();
                // appState.userLogin();
              },
              child: Text('Sign Up'),
            ),
          ]
      ),
    );
  }
}