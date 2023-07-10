import 'package:flutter/material.dart';

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
              Text('Edit User Profile', style: TextStyle(fontSize: 30)),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: "First Name", labelStyle: TextStyle(fontSize: 20)),
                  onChanged: (text){
                    this._firstName = text;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: "Last Name", labelStyle: TextStyle(fontSize: 20)),
                  onChanged: (text){
                    this._lastName = text;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
                child: TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: "Country", labelStyle: TextStyle(fontSize: 20)),
                  onChanged: (text){
                    this._country = text;
                  },
                ),
              ),
              SizedBox(height: 40),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(width: 60),
                ElevatedButton(
                  onPressed: () async {
                    setPageIndex(3);
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () async {
                    await updateUserProfile(this._firstName, this._lastName,this._country);
                  },
                  child: Text('Save'),
                ),
              ]),

              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setPageIndex(2);
                },
                child: Text('Back to home'),
              ),
            ]
        )
    );
  }
}