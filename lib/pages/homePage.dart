import 'package:flutter/material.dart';

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
          Text("Welcome ${this.username}!", style: TextStyle(fontSize: 20)),
          SizedBox(height: 100),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
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
              child: Text('View profile', style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
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
              child: Text('Call External API', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
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
              child: Text('Sign out', style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}
