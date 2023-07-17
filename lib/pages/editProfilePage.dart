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
    final TextEditingController _firstNameController = new TextEditingController();
    _firstNameController.text = this._firstName;
    final TextEditingController _lastNameController = new TextEditingController();
    _lastNameController.text = this._lastName;
    final TextEditingController _countryController = new TextEditingController();
    _countryController.text = this._country;

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Edit User Profile', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: "First Name", labelStyle: TextStyle(fontSize: 20)),
                  onChanged: (text) {
                    this._firstName = text;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: "Last Name", labelStyle: TextStyle(fontSize: 20)),
                  onChanged: (text) {
                    this._lastName = text;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: "Country", labelStyle: TextStyle(fontSize: 20)),
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
                    child: const Text('Save', style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
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
                    child: const Text('Cancel'),
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
                  child: const Text('Back to home', style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),
                ),
              ),
            ]
        )
    );
  }
}