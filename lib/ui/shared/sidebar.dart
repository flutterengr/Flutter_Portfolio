
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_project/ui/shared/widgets/item_menu.dart';
import 'package:twitter_project/ui/shared/widgets/logo.dart';
import 'package:twitter_project/ui/shared/widgets/text_separator.dart';

import '../../providers/auth_provider.dart';
import '../../providers/sidemenu_provider.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';




class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

 

  void navigateTo( String routeName ) {
    NavigationService.replaceTo( routeName );
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {

    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [

          Logo(),

          const SizedBox( height: 50 ),

          const TextSeparator( text: 'main' ),

          ItemMenu(
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => navigateTo( Flurorouter.dashboardRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          ),

          ItemMenu( text: 'Orders', icon: Icons.shopping_cart_outlined, onPressed: (){}),
          ItemMenu( text: 'Analytic', icon: Icons.show_chart_outlined, onPressed: (){}),
          
          ItemMenu(
            text: 'Categories', 
            icon: Icons.layers_outlined, 
            onPressed: () => navigateTo( Flurorouter.categoriesRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
          ),

          ItemMenu( text: 'Products', icon: Icons.dashboard_outlined, onPressed: (){}),
          ItemMenu( text: 'Discount', icon: Icons.attach_money_outlined, onPressed: (){})
          ,
          ItemMenu( 
            text: 'Users', 
            icon: Icons.people_alt_outlined, 
            onPressed: () => navigateTo( Flurorouter.usersRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
          ),

          const SizedBox( height: 30 ),

          const TextSeparator( text: 'UI Elements' ),
          
          ItemMenu( 
            text: 'Icons', 
            icon: Icons.list_alt_outlined, 
            onPressed: () => navigateTo( Flurorouter.iconsRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
          ),

          ItemMenu( text: 'Marketing', icon: Icons.mark_email_read_outlined, onPressed: (){}),
          ItemMenu( text: 'Campaign', icon: Icons.note_add_outlined, onPressed: (){}),
          ItemMenu( 
            text: 'Black', 
            icon: Icons.post_add_outlined, 
            onPressed: () => navigateTo( Flurorouter.blankRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
          ),

          const SizedBox( height: 50 ),
          const TextSeparator( text: 'Exit' ),
          ItemMenu( 
            text: 'Logout', 
            icon: Icons.exit_to_app_outlined, 
            onPressed: (){
              Provider.of<AuthProvider>(context, listen: false)
                .logout();
            }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color( 0xff092044 ),
        Color( 0xff092042 ),
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10
      )
    ]
  );
}