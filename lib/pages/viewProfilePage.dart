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
          const Text(constants.viewProfileTitle, style: TextStyle(fontSize: 30)),
          const SizedBox(height: 50),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(constants.primaryColor), width: 2.0),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(
                    photo ??
                        ''),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text('${constants.firstNameLabel}: $firstName',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text('${constants.lastNameLabel}: $LastName',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text('${constants.dOBLabel}: $dateOdBirth', style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text('${constants.mobileLabel}: $mobile', style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text('${constants.countryLabel}: $country', style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                  ],
                ),
              )),

          const SizedBox(height: 20),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: Color(constants.primaryColor),
                borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                pageIndex(constants.editProfilePage);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(constants.editProfile, style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: const Color(0xffe0e1e2),
                borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                pageIndex(constants.homePage);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(constants.back, style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
