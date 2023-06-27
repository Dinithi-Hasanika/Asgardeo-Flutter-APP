import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final retriveProfileFunction;
  final logOutFunction;
  final callExternalAPIFunction;
  final setPageIndex;
  final getUserProfileData;

  const HomePage(this.retriveProfileFunction, this.logOutFunction, this.callExternalAPIFunction, this.setPageIndex, this.getUserProfileData);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome!", style: TextStyle(fontSize: 35)),
          SizedBox(height: 100),
          ElevatedButton(
            onPressed: () async {
              await retriveProfileFunction();
            },
            child: Text('View profile'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await callExternalAPIFunction();
            },
            child: Text('Call External API'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await logOutFunction();
            },
            child: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
