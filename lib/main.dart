import 'package:fetch/pages/complexDataFetch.dart';
import 'package:fetch/pages/home.dart';
import 'package:fetch/pages/paginationPage.dart';
import 'package:fetch/providers/complexJsonProvider.dart';
import 'package:fetch/providers/paginationProvider.dart';
import 'package:fetch/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => PaginationProvider()),
        ChangeNotifierProvider(create: (_) => Complex())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FetchingComplexData(),
    );
  }
}
