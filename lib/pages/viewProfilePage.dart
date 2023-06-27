import 'package:flutter/material.dart';

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
              border: Border.all(color: Colors.blue, width: 3.0),
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
              color: Theme.of(context).colorScheme.surfaceVariant,
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
          ElevatedButton(
            onPressed: () {
              pageIndex(5);
            },
            child: Text('Edit Profile'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              pageIndex(2);
            },
            child: Text('Back to home'),
          ),
        ],
      ),
    );
  }
}
