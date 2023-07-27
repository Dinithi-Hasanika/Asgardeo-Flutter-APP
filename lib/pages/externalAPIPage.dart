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
            Row(children: [
              IconButton(
                onPressed: () {
                setPageIndex(constants.homePage);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              const Text(constants.externalAPIPageTitle, style: TextStyle(fontSize: 30))
            ]
            ),
            const SizedBox(height: 40),
            Padding(padding: const EdgeInsets.only(left:35, bottom: 0, right: 10, top:0), child: Text(bodyResponse)),
          ]
      ),
    );
  }
}
