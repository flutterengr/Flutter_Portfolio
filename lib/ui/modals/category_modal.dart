import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http/category.dart';
import '../../providers/categories_provider.dart';
import '../../services/notifications_service.dart';
import '../buttons/custom_outlined_button.dart';
import '../inputs/custom_inputs.dart';
import '../labels/custom_labels.dart';



class CategoryModal extends StatefulWidget {

  final Categoria? categoria;

  const CategoryModal({
    Key? key, 
    this.categoria
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoryModalState createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {

  String nombre = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id     = widget.categoria?.id;
    nombre = widget.categoria?.nombre ?? '';

  }


  @override
  Widget build(BuildContext context) {

    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300, // expanded
      decoration: buildBoxDecoration(),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( widget.categoria?.nombre ?? 'Nueva categoría', style: CustomLabels.h1.copyWith( color: Colors.white )),
              IconButton(
                icon: const Icon( Icons.close, color: Colors.white, ), 
                onPressed: () => Navigator.of(context).pop()
              )
            ],
          ),

          Divider( color: Colors.white.withOpacity(0.3 )),

          const SizedBox(height: 20 ),

          TextFormField(
            initialValue: widget.categoria?.nombre ?? '',
            onChanged: ( value ) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Nombre de la categoría', 
              label: 'Categoría', 
              icon: Icons.new_releases_outlined
            ),
            style: const TextStyle( color: Colors.white ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async{
                
                try {
                  if( id == null ) {
                    // Crear
                    await categoryProvider.newCategory(nombre);
                    NotificationsService.showSnackbar('$nombre creado!');

                  } else {
                    // Actualizar
                    await categoryProvider.updateCategory( id!, nombre );
                    NotificationsService.showSnackbar('$nombre Actualizado!');
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();

                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError('No se pudo guardar la categoría');
                }
                
          
                

              },
              text: 'Guardar',
              color: Colors.white,
            ),
          )

        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only( topLeft:  Radius.circular(20), topRight: Radius.circular(20) ),
    color: Color(0xff0F2041),
    boxShadow: [
      BoxShadow(
        color: Colors.black26
      )
    ]
  );
}



