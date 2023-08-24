import 'package:flutter/material.dart';
import '../constants.dart' as constants;
import 'package:provider/provider.dart';
import '../providers/page.dart';

class ExternalAPIDataPage extends StatelessWidget{
  final String bodyResponse;

  const ExternalAPIDataPage( this.bodyResponse);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              IconButton(
                onPressed: () {
                  context.read<CurrentPage>().setPageIndex(constants.homePage);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              const Text(constants.externalAPIPageTitle, style: TextStyle(fontSize: 30)),
            ]
            ),
            const SizedBox(height: 40),
            Padding(padding: const EdgeInsets.only(left:35, bottom: 0, right: 10, top:0), child: Text(context.watch<CurrentPage>().apiData)),
          ]
      ),
    );
  }
}
