import 'package:flutter/material.dart';
import 'package:twitter_project/ui/shared/widgets/navbar_avatar.dart';
import 'package:twitter_project/ui/shared/widgets/notifications_indicator.dart';
import 'package:twitter_project/ui/shared/widgets/search_text.dart';
import '../../providers/sidemenu_provider.dart';


class Navbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,    
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          
          if ( size.width <= 700 )
            IconButton(
              icon: const Icon( Icons.menu_outlined ), 
              onPressed: () => SideMenuProvider.openMenu()
            ),
          
          const SizedBox( width: 5 ),

          // Search input
          if ( size.width > 390 ) 
            ConstrainedBox(
              constraints: const BoxConstraints( maxWidth: 250 ),
              child: SearchText(),
            ),

          const Spacer(),

          NotificationsIndicator(),
          const SizedBox( width: 10 ),
          NavbarAvatar(),
          const SizedBox( width: 10 )

        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 5
      )
    ]
  );
}