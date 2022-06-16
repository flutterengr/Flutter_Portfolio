
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:twitter_project/router/router.dart';
import 'package:twitter_project/ui/views/icons_view.dart';

import '../providers/auth_provider.dart';
import '../providers/sidemenu_provider.dart';
import '../ui/views/blank_view.dart';
import '../ui/views/dashboard_view.dart';
import '../ui/views/login_view.dart';


import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';


class DashboardHandlers {

  static Handler dashboard = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);

      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.dashboardRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const DashboardView();
      } else {
        return LoginView();
      }

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return DashboardView();
      else 
        return LoginView();

    }
  );



  static Handler icons = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.iconsRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return IconsView();
      } else {
        return LoginView();
      }
    }
  );


  static Handler blank = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.blankRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return BlankView();
      } else {
        return LoginView();
      }
    }
  );




}

