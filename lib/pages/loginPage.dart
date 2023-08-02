import 'package:asgardeo_flutter_app/pages/signUpPage.dart';
import 'package:asgardeo_flutter_app/pages/viewSourceCode.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class LogInPage extends StatelessWidget {
  final loginFunction;

  const LogInPage(this.loginFunction);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset(constants.asgardeoLogo,
                height: 100,
                width: 160,
              ),
                const SizedBox(width: 10,),
              const Text('+',style: TextStyle(fontSize: 25)),
              Image.asset(constants.flutterLogo,
                height: 100,
                width: 100,
              ),
            ],),
            const Text(constants.startPack, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 120),
            Container(
            height: 44.0,
            width: 180.0,
            decoration: BoxDecoration(
                color: const Color(constants.primaryColor),
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
            const SizedBox(height: 60),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
              ),
              child: Container(
                  height: 120,
                  width: 260,
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(children:[
                        Text('Github Repository', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),),
                        const SizedBox(height: 5),
                        Text('Lets go through the application codebase'),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => viewSourceCode()));
                          },
                          child: Text('View Source', style: TextStyle( fontWeight: FontWeight.w400,color: Colors.blue)),
                        )
                      ]
                      )
                  )
              ),
            ),
            const SizedBox(height: 90),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(constants.license),
            )
          ]
      ),
    );
  }
}
