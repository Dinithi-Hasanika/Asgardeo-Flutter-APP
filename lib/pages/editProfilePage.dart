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

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(constants.editProfileTitle, style: TextStyle(fontSize: 30)),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText:constants.firstNameLabel, labelStyle: TextStyle(fontSize: 20)),
                  onChanged: (text) {
                    this._firstName = text;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText:constants.lastNameLabel, labelStyle: TextStyle(fontSize: 20)),
                  onChanged: (text) {
                    this._lastName = text;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: constants.countryLabel, labelStyle: TextStyle(fontSize: 20)),
                  onChanged: (text) {
                    this._country = text;
                  },
                ),
              ),
              const SizedBox(height: 40),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(width: 40),
                Container(
                  height: 44.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xffeb4f63), Color(0xfffa7b3f)
                          ]
                      ),
                      borderRadius: BorderRadius.circular(20)),
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
                const SizedBox(width: 40),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ElevatedButton(
                    onPressed: () async {
                      setPageIndex(constants.profilePage);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text(constants.cancel),
                  ),
                ),
              ]),

              const SizedBox(height: 40),
              Container(
                height: 44.0,
                width: 170.0,
                decoration: BoxDecoration(
                    color: const Color(0xffe0e1e2),
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    setPageIndex(constants.homePage);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: const Text(constants.back, style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),
                ),
              ),
            ]
        )
    );
  }
}