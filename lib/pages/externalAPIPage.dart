import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class ExternalAPIDataPage extends StatelessWidget{
  final setPageIndex;
  final String bodyResponse;

  const ExternalAPIDataPage(this.setPageIndex, this.bodyResponse);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('External API Data', style: TextStyle(fontSize: 30)),
            SizedBox(height: 40),
            Padding(padding: EdgeInsets.only(left:35, bottom: 0, right: 10, top:0), child: Text('$bodyResponse')),
            SizedBox(height: 40),
            Container(
              height: 44.0,
              width: 170.0,
              decoration: BoxDecoration(
                  color: Color(0xffe0e1e2),
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  setPageIndex(constants.homePage);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Text('Back to home', style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),
              ),
            ),
          ]
      ),
    );
  }

}
