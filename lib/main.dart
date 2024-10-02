import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:girman_app/blocs/popupmenu/popup_menu_bloc.dart';
import 'package:girman_app/firebase_options.dart';
import 'package:girman_app/screens/splash_screen.dart';
import 'package:girman_app/upload_users.dart';
import 'package:girman_app/user_list.dart';
import 'blocs/search/search_bloc.dart';
import 'screens/home/home_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  // await uploadUsers();


  // runApp(DevicePreview(builder: (context){
  //   return MyApp();
  // }));

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)
      {
        return PopupMenuBloc();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Girman Technologies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
