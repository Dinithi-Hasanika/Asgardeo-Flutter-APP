import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class ProfilePage extends StatelessWidget {
  final firstName;
  final LastName;
  final dateOdBirth;
  final country;
  final mobile;
  final photo;
  final pageIndex;

  const ProfilePage(this.firstName, this.LastName, this.dateOdBirth, this.country,
      this.mobile, this.photo, this.pageIndex);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile Information", style: TextStyle(fontSize: 30)),
          SizedBox(height: 50),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffeb4f63), width: 2.0),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(
                    photo ??
                        ''),
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Text('First Name: $firstName',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Last Name: $LastName',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Date of Birth: $dateOdBirth', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Mobile: $mobile', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Country: $country', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                  ],
                ),
              )),
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
              onPressed: () {
                pageIndex(constants.editProfilePage);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: Text('Edit Profile', style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: Color(0xffe0e1e2),
                borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                pageIndex(constants.homePage);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: Text('Back to home', style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
