import 'package:asgardeo_flutter_app/constants/strings.dart';
import 'package:asgardeo_flutter_app/pages/sign_up_page.dart';
import 'package:asgardeo_flutter_app/pages/view_source_code.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as constants;
import '../utils/auth_client.dart';

class LogInPage extends StatelessWidget {

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset(constants.flutterLogo,
                height: 100,
                width: 100,
              ),
            const SizedBox(height: 30),
            const Text(Strings.firstPageTitle, style: TextStyle(fontSize: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(Strings.firstPageSubTitle, style: TextStyle(fontSize: 25)),
                Image.asset(constants.asgardeoLogo,
                  height: 100,
                  width: 120,
                ),
              ],
            ),
            const SizedBox(height: 80),
            Container(
            height: 44.0,
            width: 180.0,
            decoration: BoxDecoration(
                color: const Color(constants.primaryColor),
                borderRadius: BorderRadius.circular(constants.buttonRadius)),
            child: ElevatedButton(
              onPressed: () async {
                await AuthClient().loginFunction(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(Strings.signInButton, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ),
            const SizedBox(height: 20),
            Container(
              height: 42.0,
              width: 178.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUpWebView()));
                },
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(constants.primaryColor),
                    ),
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(constants.buttonRadius),
                    )),
                child: const Text(Strings.signUpButton, style: TextStyle(fontWeight: FontWeight.bold, color: Color(constants.primaryColor))),
              ),
            ),
            const SizedBox(height: 60),
            InkWell(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ViewSourceCode()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(constants.gitHubLogo,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 5),
                  const Text(Strings.viewSource, style: TextStyle( fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const SizedBox(height: 120),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(Strings.license),
            )
          ]
      ),
    );
  }
}
