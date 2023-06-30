import 'package:flutter/material.dart';

const List<String> itemList = <String>['DEFAULT','TOTP', 'Email', 'SMS'];

class SetUpMFAPage extends StatefulWidget{
  final setPageIndex;
  final preferredMFAOption;
  final updatePreferredMFA;

  SetUpMFAPage(this.setPageIndex, this.preferredMFAOption,this.updatePreferredMFA);
  @override
  State<SetUpMFAPage> createState() {
    return _SetUpMFAPage(this.setPageIndex, this.preferredMFAOption, this.updatePreferredMFA);
  }

}

class _SetUpMFAPage extends State<SetUpMFAPage>{
  final setPageIndex;
  String dropDownValue;
  final updatePreferredMFA;

  _SetUpMFAPage(this.setPageIndex, this.dropDownValue, this.updatePreferredMFA);
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
                value: this.dropDownValue != ''? this.dropDownValue : itemList.first ,
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
            onPressed: () async {
              await updatePreferredMFA(this.dropDownValue);
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