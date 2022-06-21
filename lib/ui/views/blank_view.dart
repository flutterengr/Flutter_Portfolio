import 'package:flutter/material.dart';
import 'package:twitter_project/ui/cards/white_card.dart';

import '../labels/custom_labels.dart';

class BlankView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Blank View', style: CustomLabels.h1 ),

          const SizedBox( height: 10 ),

          const WhiteCard(
            title: 'Blank Page',
            child: Text('Hola Mundo!!')
          )

        ],
      ),
    );
  }
}