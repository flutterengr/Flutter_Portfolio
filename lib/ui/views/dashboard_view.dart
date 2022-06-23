import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../cards/white_card.dart';
import '../labels/custom_labels.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context).user!;

    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Dashboard View', style: CustomLabels.h1 ),

        const SizedBox( height: 10 ),

        WhiteCard(
          title: user.nombre,
          child: Text( user.correo )
        )

      ],
    );
  }
}