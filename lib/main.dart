
import 'package:flutter/material.dart';
import 'package:twitter_project/router/router.dart';
import 'package:twitter_project/ui/layouts/auth/auth_layout.dart';
 
void main(){

  Flurorouter.configureRoutes();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      builder: ( _ , child ){

        return AuthLayout( child: child! );

      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5)
          )
        )
      ),
    );
  }
}