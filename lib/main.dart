
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_project/providers/auth_provider.dart';
import 'package:twitter_project/providers/sidemenu_provider.dart';
import 'package:twitter_project/router/router.dart';
import 'package:twitter_project/services/local_storage.dart';
import 'package:twitter_project/services/navigation_service.dart';
import 'package:twitter_project/services/notifications_service.dart';
import 'package:twitter_project/ui/layouts/auth/auth_layout.dart';
import 'package:twitter_project/ui/layouts/auth/dashboard/dashboard_layout.dart';
import 'package:twitter_project/ui/layouts/auth/splash/splash_layout.dart';

import 'api/CafeApi.dart';
 
void main() async {

  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  
  Flurorouter.configureRoutes();
  runApp(const AppState());
}
 
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: ( _ ) => AuthProvider()
        ),

        ChangeNotifierProvider(
          lazy: false,
          create: ( _ ) => SideMenuProvider()
        )

      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: ( _ , child ){
        
        final authProvider = Provider.of<AuthProvider>(context);

        if ( authProvider.authStatus == AuthStatus.checking ) {
          return const SplashLayout();
        }

        if( authProvider.authStatus == AuthStatus.authenticated ) {
          return DashboardLayout( child: child! );
        } else {
          return AuthLayout( child: child! );
        }
              

      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5)
          )
        )
      ),
    );
  }
}