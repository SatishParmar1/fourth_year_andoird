import 'package:flutter/material.dart';
import 'package:fourth_year/login/login.dart';
import 'package:fourth_year/User Deshbord/navigation.dart';
import 'package:provider/provider.dart';
import 'package:fourth_year/Provider/provider_changenotifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountProvider>(create: (_) => CountProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Login(),
      ),
    );
  }
}