import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom/resources/auth_method.dart';
import 'package:zoom/screen/home_screen.dart';
import 'package:zoom/screen/login_screen.dart';
import 'package:zoom/screen/vide_call_screen.dart';
import 'package:zoom/utils/colors.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Zoom Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: backgroundColor
        ), routes: {

          '/login' : (context) => const LoginScreen(),
          '/home' : (context) => const HomeScreen(),
          '/video-call' : (context) => const VideoCallScreen(),
      },
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
                child: CircularProgressIndicator()
            );
          }

          if(snapshot.hasData){
            return const HomeScreen();
          }

          return const LoginScreen();
        }
      ),
    );

  }
}
