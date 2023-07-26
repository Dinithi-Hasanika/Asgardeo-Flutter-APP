import 'package:asgardeo_flutter_app/configs/endPointUrls.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class signUpWebView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Flutter WebView'),
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
              if(request.url.startsWith('wso2.asgardeo.flutterapp://signup')){
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
