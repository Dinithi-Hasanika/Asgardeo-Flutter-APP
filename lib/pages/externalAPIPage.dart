import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class ExternalAPIDataPage extends StatelessWidget{
  final setPageIndex;
  final String bodyResponse;

  const ExternalAPIDataPage(this.setPageIndex, this.bodyResponse);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(constants.externalAPIPageTitle, style: TextStyle(fontSize: 30)),
            const SizedBox(height: 40),
            Padding(padding: const EdgeInsets.only(left:35, bottom: 0, right: 10, top:0), child: Text('$bodyResponse')),
            const SizedBox(height: 40),
            Container(
              height: 44.0,
              width: 170.0,
              child: ElevatedButton(
                onPressed: () {
                  setPageIndex(constants.homePage);
                },
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(constants.primaryColor),
                    ),
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                ),
                child: const Text(constants.back, style: TextStyle(color: Color(constants.primaryColor) , fontWeight: FontWeight.bold)),
              ),
            ),
          ]
      ),
    );
  }

}
