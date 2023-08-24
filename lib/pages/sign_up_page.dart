import 'package:asgardeo_flutter_app/configs/configs.dart';
import 'package:asgardeo_flutter_app/configs/end_point_urls.dart';
import 'package:asgardeo_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart' as constants;

class SignUpWebView extends StatelessWidget{
  const SignUpWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(Strings.newAccount),
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
