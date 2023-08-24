import 'package:asgardeo_flutter_app/providers/page.dart';
import 'package:asgardeo_flutter_app/providers/user.dart';
import 'package:asgardeo_flutter_app/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'pages/my_asgardeo_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => UserSession()),
        ChangeNotifierProvider(create: (_) => CurrentPage()),
      ],
      child: const MyApp(),
    ),
  );
}
