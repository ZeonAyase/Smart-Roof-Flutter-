import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_roof/route/router.dart' as router;
import 'package:smart_roof/route/routing_constants.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_){
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: splashPageRoute,
    );  
  }
}
