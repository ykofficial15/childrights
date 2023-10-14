import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:childrights/App_Components/Bottom_Navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'App_Components/Home.dart';
import 'Provider_Models/CounterModel.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Fir ebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => CounterModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset(
          'images/splash.png',
        ),
        splashIconSize: 300,
        nextScreen: BottomNavigation(),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
