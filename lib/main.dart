import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:childrights/App_Components/Bottom_Navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'App_Components/Home.dart';
import 'Login_Signup/Login.dart';
import 'Provider_Models/CounterModel.dart';
import 'Login_Signup/SignUp.dart';
import 'Provider_Models/Users.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: FirebaseOptions(
      apiKey: 'AIzaSyAYLnn-nnUac5Qy3firV26wpm6VI5mgxo0',
      appId: '1:72560227782:android:80a81d24f10b0163642ec7',
      messagingSenderId: 'YOUR_SENDER_ID',
      projectId: 'childrights-b7262',
    ),);

runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterModel>(create: (context) => CounterModel()),
        ChangeNotifierProvider<Authenticate>(
          create: (context) => Authenticate(false), //Pass initial value for _isLoggedIn
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final prefs = snapshot.data as SharedPreferences;
            final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

            return ChangeNotifierProvider(
              create: (context) => Authenticate(isLoggedIn), // Provide the initial login status
              child: AnimatedSplashScreen(
                duration: 3000,
                splash: Image.asset('assets/splash.png'),
                splashIconSize: 300,
                nextScreen: isLoggedIn ? BottomNavigation() : Login(),
                backgroundColor: Colors.purple,
              ),
            );
          } else {
            return Center(child:CircularProgressIndicator(color:Colors.purple));
          }
        },
      ),
    );
  }
}