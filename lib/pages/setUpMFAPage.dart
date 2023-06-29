import 'package:flutter/material.dart';

class SetUpMFAPage extends StatefulWidget{
  final setPageIndex;

  SetUpMFAPage(this.setPageIndex);
  @override
  State<SetUpMFAPage> createState() {
    // TODO: implement createState
    return _SetUpMFAPage(this.setPageIndex);
  }

}

class _SetUpMFAPage extends State<SetUpMFAPage>{
  final setPageIndex;

  _SetUpMFAPage(this.setPageIndex);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: Column(
        children: [Text('Set Up MFA Page'),
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