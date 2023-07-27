import 'package:asgardeo_flutter_app/pages/signUpPage.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class LogInPage extends StatelessWidget {
  final loginFunction;

  const LogInPage(this.loginFunction);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset("assets/images/flutter5786.jpg",
           height: 100,
             width: 100,
           ),
            SizedBox(height: 15),
            Text("Quick Start Pack", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text("Flutter and Asgardeo Integration Demo App", style: const TextStyle(fontSize: 16)),
            SizedBox(height: 40),
            Container(
            height: 44.0,
            width: 180.0,
            decoration: BoxDecoration(
                color: Color(constants.primaryColor),
                borderRadius: BorderRadius.circular(constants.buttonRadius)),
            child: ElevatedButton(
              onPressed: () async {
                await loginFunction();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(constants.signIn, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ),
            const SizedBox(height: 20),
            Container(
              height: 42.0,
              width: 178.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ElevatedButton(
                onPressed: () async {
               //   await signUpFunction();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signUpWebView()));
                },
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(constants.primaryColor),
                    ),
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(constants.buttonRadius),
                    )),
                child: const Text(constants.signUp, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ]
      ),
    );
  }
}
