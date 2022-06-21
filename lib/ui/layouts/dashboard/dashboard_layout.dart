
import 'package:flutter/material.dart';
import 'package:twitter_project/providers/sidemenu_provider.dart';
import 'package:twitter_project/ui/shared/navbar.dart';
import 'package:twitter_project/ui/shared/sidebar.dart';



class DashboardLayout extends StatefulWidget {

  final Widget child;

  const DashboardLayout({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  _DashboardLayoutState createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> with SingleTickerProviderStateMixin {


  @override
  void initState() { 
    super.initState();
    
    SideMenuProvider.menuController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 300) 
    );

  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color( 0xffEDF1F2 ),
      body: Stack(
        children: [
          Row(
            children: [
              
              if ( size.width >= 700 )
                const Sidebar(),

              Expanded(
                child: Column(
                  children: [
                    // Navbar
                    Navbar(),

                    // View 
                    Expanded(
                      child: Container(
                        child: widget.child,
                      )
                    ),
                  ],
                ),
              )
              // Contenedor de nuestro view
            ],
          ),


          if( size.width < 700 )
            AnimatedBuilder(
              animation: SideMenuProvider.menuController, 
              builder: ( context, _ ) => Stack(
                children: [

                  if( SideMenuProvider.isOpen )
                    Opacity(
                      opacity: SideMenuProvider.opacity.value,
                      child: GestureDetector(
                        onTap: () => SideMenuProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),


                  Transform.translate(
                    offset: Offset( SideMenuProvider.movement.value, 0 ),
                    child: const Sidebar(),
                  )
                ],
              )) 
        ],
      )
    );
  }
}