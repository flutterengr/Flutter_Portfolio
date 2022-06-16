import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:twitter_project/router/router.dart';
import 'package:twitter_project/ui/views/icons_view.dart';

import '../providers/auth_provider.dart';
import '../providers/sidemenu_provider.dart';
import '../ui/views/blank_view.dart';
import '../ui/views/categories_view.dart';
import '../ui/views/dashboard_view.dart';
import '../ui/views/login_view.dart';


class DashboardHandlers {

  static Handler dashboard = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.dashboardRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const DashboardView();
      } else {
        return const LoginView();
      }
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
        return const LoginView();
      }
    }
  );


  static Handler categories = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.categoriesRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated ) {
        return const CategoriesView();
      } else {
        return const LoginView();
      }
    }
  );


}
