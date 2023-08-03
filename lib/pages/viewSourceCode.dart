import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart' as constants;

class viewSourceCode extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: WebViewWidget(controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(constants.repoURL),
          ))
    );
  }
}
