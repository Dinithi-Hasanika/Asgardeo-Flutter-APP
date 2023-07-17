import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class LogInPage extends StatelessWidget {
  final loginFunction;
  final signUpFunction;

  const LogInPage(this.loginFunction, this.signUpFunction);

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: <Color>[Color(0xffeb4f63), Color(0xfffa7b3f)]
                ),
                borderRadius: BorderRadius.circular(20)),
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
              height: 44.0,
              width: 185.0,
              decoration: BoxDecoration(
                  color: const Color(0xffe0e1e2),
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  await signUpFunction();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: const Text(constants.signUp, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              ),
            ),
          ]
      ),
    );
  }
}