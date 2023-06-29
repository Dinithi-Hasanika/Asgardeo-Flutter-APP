import 'package:flutter/material.dart';

const List<String> itemList = <String>['DEFAULT','TOTP', 'Email', 'SMS'];

class SetUpMFAPage extends StatefulWidget{
  final setPageIndex;
  final preferredMFAOption;

  SetUpMFAPage(this.setPageIndex, this.preferredMFAOption);
  @override
  State<SetUpMFAPage> createState() {
    return _SetUpMFAPage(this.setPageIndex, this.preferredMFAOption);
  }

}

class _SetUpMFAPage extends State<SetUpMFAPage>{
  final setPageIndex;
  String dropDownValue;

  _SetUpMFAPage(this.setPageIndex, this.dropDownValue);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Set Up MFA', style: TextStyle(fontSize: 25)),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Preferred MFA Option', style: TextStyle(fontSize: 18)),
              SizedBox(width: 25,),
              DropdownButton(
                value: this.dropDownValue,
                underline: Container(
                  height: 2,
                  color: Colors.orange,
                ),
                items: itemList.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
                onChanged: (String? value) {
              print(value);
              setState(() {
                this.dropDownValue = value!;
              });
                }),
          ],),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setPageIndex(2);
            },
            child: Text('Save'),
          ),
          SizedBox(height: 20),
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