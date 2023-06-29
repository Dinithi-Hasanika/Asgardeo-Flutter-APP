import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final retriveProfileFunction;
  final logOutFunction;
  final callExternalAPIFunction;
  final setPageIndex;
  final getUserProfileData;
  final username;
  final getPreferredMFA;

  const HomePage(this.retriveProfileFunction, this.logOutFunction, this.callExternalAPIFunction, this.setPageIndex, this.getUserProfileData, this.username, this.getPreferredMFA);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome ${this.username}!", style: TextStyle(fontSize: 20)),
          SizedBox(height: 100),
          ElevatedButton(
            onPressed: () async {
              await getUserProfileData();
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
              await getPreferredMFA();
             setPageIndex(6);
            },
            child: Text('Set Up MFA Option'),
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
