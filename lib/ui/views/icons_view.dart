import 'package:flutter/material.dart';
import 'package:twitter_project/ui/cards/white_card.dart';
import 'package:twitter_project/ui/labels/custom_labels.dart';

class IconsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Icons', style: CustomLabels.h1 ),

          const SizedBox( height: 10 ),

          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: const [

              WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center( child: Icon( Icons.ac_unit_outlined) )
              ),

              WhiteCard(
                title: 'access_alarms_outlined',
                width: 170,
                child: Center( child: Icon( Icons.access_alarms_outlined) )
              ),

              WhiteCard(
                title: 'access_time_rounded',
                width: 170,
                child: Center( child: Icon( Icons.access_time_rounded) )
              ),

              WhiteCard(
                title: 'all_inbox_outlined',
                width: 170,
                child: Center( child: Icon( Icons.all_inbox_outlined) )
              ),

              WhiteCard(
                title: 'desktop_mac_sharp',
                width: 170,
                child: Center( child: Icon( Icons.desktop_mac_sharp) )
              ),

              WhiteCard(
                title: 'keyboard_tab_rounded',
                width: 170,
                child: Center( child: Icon( Icons.keyboard_tab_rounded) )
              ),

              WhiteCard(
                title: 'not_listed_location',
                width: 170,
                child: Center( child: Icon( Icons.not_listed_location) )
              ),

            ],
          )


        ],
      ),
    );
  }
}