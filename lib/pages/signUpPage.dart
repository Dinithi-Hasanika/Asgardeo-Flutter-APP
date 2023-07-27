import 'package:asgardeo_flutter_app/configs/configs.dart';
import 'package:asgardeo_flutter_app/configs/endPointUrls.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart' as constants;

class signUpWebView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(constants.newAccount),
    ),
    body: WebViewWidget(controller: WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {

            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if(request.url.startsWith(accessURL)){
                Navigator.pop(context);
                return NavigationDecision.navigate;
              }
              return NavigationDecision.navigate;
            },
          )
      )
      ..loadRequest(
        Uri.parse(signUpUrl),
      ))
    );
  }
}
