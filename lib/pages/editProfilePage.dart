import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class EditProfilePage extends StatefulWidget {
  final firstName;
  final lastName;
  final country;
  final updateUserProfile;
  final setPageIndex;

  EditProfilePage(this.setPageIndex, this.firstName, this.lastName, this.country, this.updateUserProfile);

  @override
  State<EditProfilePage> createState() {
    return _EditProfilePage(this.setPageIndex, this.firstName, this.lastName, this.country, this.updateUserProfile);
  }

}

class _EditProfilePage extends State<EditProfilePage>{
  var _firstName;
  var _lastName;
  var _country;
  final updateUserProfile;
  final setPageIndex;

   _EditProfilePage(this.setPageIndex, this._firstName, this._lastName, this._country, this.updateUserProfile);
  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    firstNameController.text = this._firstName;
    final TextEditingController lastNameController = TextEditingController();
    lastNameController.text = this._lastName;
    final TextEditingController countryController = TextEditingController();
    countryController.text = this._country;

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            IconButton(
              onPressed: () {
                setPageIndex(constants.profilePage);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            const Text(constants.editProfileTitle, style: TextStyle(fontSize: 30))]),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(constants.firstNameLabel, textAlign: TextAlign.start, style:TextStyle(fontSize: 16) ,),
                const SizedBox(height: 8),
                TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    )
                ),
                onChanged: (text) {
                  this._firstName = text;
                },
              ),
            ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                const Text(constants.lastNameLabel, textAlign: TextAlign.start, style:TextStyle(fontSize: 16) ,),
                const SizedBox(height: 8),
                TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    )
                ),
                onChanged: (text) {
                  this._lastName = text;
                },
              ),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(constants.countryLabel, textAlign: TextAlign.start, style:TextStyle(fontSize: 16) ,),
                const SizedBox(height: 8),
                TextField(
                controller: countryController,
                decoration: InputDecoration(isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    )),
                onChanged: (text) {
                  this._country = text;
                },
              ),
              ]
            ),
          ),
          const SizedBox(height: 40),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(width: 35),
            Container(
              height: 44.0,
              width: 150.0,
              decoration: BoxDecoration(
                  color: const Color(constants.primaryColor),
                  borderRadius: BorderRadius.circular(constants.buttonRadius)),
              child: ElevatedButton(
                onPressed: () async {
                  await updateUserProfile(this._firstName, this._lastName,this._country);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: const Text(constants.save, style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 30),
            Container(
              height: 42.0,
              width: 148.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ElevatedButton(
                onPressed: () async {
                  setPageIndex(constants.profilePage);
                },
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(constants.primaryColor),
                    ),
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(constants.buttonRadius),
                    )),
                child: const Text(constants.cancel),
              ),
            ),
          ]),
          const SizedBox(height: 170),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text('© 2023 Copyright: WSO2.LLC'),
          )
        ]
    );
  }
}
