import 'package:flutter/material.dart';
import 'package:store_manager/components/Forms/AddTrans.dart';
import 'package:store_manager/screens/accounts.dart';
import 'package:store_manager/screens/home.dart';
import 'package:store_manager/screens/settings.dart';
import 'package:store_manager/screens/trans.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'store manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // scaffoldBackgroundColor: Color.fromRGBO(2, 48, 71, 1),
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(2, 48, 71, 1),),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/store': (context) => MyStore(),
        '/add-tran': (context) => AddTransact(),
        '/accounts': (context) => Accounts(),
        '/settings' : (context) => Settings(),
      },
    );
  }
}