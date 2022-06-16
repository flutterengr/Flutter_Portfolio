
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datatables/categories_datasource.dart';
import '../../providers/categories_provider.dart';
import '../buttons/custom_icon_button.dart';
import '../labels/custom_labels.dart';
import '../modals/category_modal.dart';




class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);


  @override
  // ignore: library_private_types_in_public_api
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<CategoriesProvider>(context, listen: false).getCategories();

  }


  @override
  Widget build(BuildContext context) {

    final categorias = Provider.of<CategoriesProvider>(context).categorias;

    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Categorías', style: CustomLabels.h1 ),

          const SizedBox( height: 10 ),

          PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Categoría')),
                DataColumn(label: Text('Creado por')),
                DataColumn(label: Text('Acciones')),
              ], 
              source: CategoriesDTS( categorias, context ),
              header: const Text('Categorías disponibles', maxLines: 2 ),
              onRowsPerPageChanged: ( value ) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context, 
                      builder: ( _ ) => const CategoryModal( categoria: null )
                    );
                  }, 
                  text: 'Crear', 
                  icon: Icons.add_outlined,
                )
              ],
            )

        ],
      ),
    );
  }
}