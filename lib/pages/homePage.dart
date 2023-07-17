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
          Text("${constants.welcome} ${this.username}!", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 100),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xffeb4f63), Color(0xfffa7b3f)
                    ]
                ),
                borderRadius: BorderRadius.circular(20)),
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
                gradient: const LinearGradient(
                    colors: <Color>[
                  Color(0xffeb4f63), Color(0xfffa7b3f)
                ]
                ),
                borderRadius: BorderRadius.circular(20)),
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
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xffeb4f63), Color(0xfffa7b3f)
                    ]
                ),
                borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () async {
                await logOutFunction();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(constants.logOut, style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}
