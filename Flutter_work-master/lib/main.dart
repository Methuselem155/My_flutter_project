import 'package:flutter/material.dart';
import 'package:flutter_work/pages/help_page.dart';
import 'package:provider/provider.dart';

import 'package:flutter_work/pages/sign_up_page.dart'; 
import 'pages/about_page.dart';
import 'pages/data_model.dart';
import 'pages/data_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataModel(), 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/data': (context) => DataPage(),
        '/help': (context) => HelpPage(),
        '/signup': (context) => SignUpPage(), 
      },
    );
  }
}
