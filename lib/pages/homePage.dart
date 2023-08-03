import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class HomePage extends StatelessWidget {
  final logOutFunction;
  final callExternalAPIFunction;
  final setPageIndex;
  final getUserProfileData;
  final username;

  const HomePage(this.logOutFunction, this.callExternalAPIFunction, this.setPageIndex, this.getUserProfileData, this.username);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Text("${constants.welcome} ${this.username}!", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 100),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: const Color(constants.primaryColor),
                borderRadius: BorderRadius.circular(constants.buttonRadius)),
            child: ElevatedButton(
              onPressed: () async {
                await getUserProfileData();
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
                await callExternalAPIFunction();
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
                await logOutFunction();
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
