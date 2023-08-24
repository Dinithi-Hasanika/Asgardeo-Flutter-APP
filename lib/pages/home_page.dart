import 'package:asgardeo_flutter_app/utils/auth_client.dart';
import 'package:asgardeo_flutter_app/utils/api_client.dart';
import 'package:asgardeo_flutter_app/utils/util.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Text("${constants.welcome} ${Util().getUsername(context)}!", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 100),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: const Color(constants.primaryColor),
                borderRadius: BorderRadius.circular(constants.buttonRadius)),
            child: ElevatedButton(
              onPressed: () async {
                await APIClient().getUserProfileData(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(constants.viewProfile, style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
               color: const Color(constants.primaryColor),
                borderRadius: BorderRadius.circular(constants.buttonRadius)),
            child: ElevatedButton(
              onPressed: () async {
                await APIClient().callExternalAPIFunction(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(constants.callExternalAPI, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 43.0,
            width: 170.0,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ElevatedButton(
              onPressed: () async {
                await AuthClient().logOutUser(context);
              },
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Color(constants.primaryColor),
                  ),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(constants.buttonRadius),
                  )),
              child: const Text(constants.logOut, style: TextStyle(fontWeight: FontWeight.bold, color: Color(constants.primaryColor))),
            ),
          ),
          const SizedBox(height: 165),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(constants.license),
          )
        ],
      ),
    );
  }
}
