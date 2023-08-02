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
          Row(children: [
            IconButton(
              onPressed: () {
                pageIndex(constants.homePage);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            const Text(constants.viewProfileTitle, style: TextStyle(fontSize: 30))
          ]),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(constants.firstNameLabel, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(constants.lastNameLabel, style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(constants.dOBLabel, style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(constants.mobileLabel, style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(constants.countryLabel, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$firstName',
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$LastName',
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$dateOdBirth',
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$mobile',
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$country',
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
              onPressed: () {
                pageIndex(constants.editProfilePage);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
              ),
              child: const Text(constants.editProfile, style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 100),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text('© 2023 Copyright: WSO2.LLC'),
          )
        ],
      ),
    );
  }
}
