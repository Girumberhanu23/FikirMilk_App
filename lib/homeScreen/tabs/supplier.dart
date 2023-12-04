// import 'package:fikir_milk/const.dart';
// import 'package:fikir_milk/homeScreen/blocs/home_bloc.dart';
// import 'package:fikir_milk/sp_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SupplierScreen extends StatefulWidget {
//   const SupplierScreen({super.key});

//   @override
//   State<SupplierScreen> createState() => _SupplierScreenState();
// }

// class _SupplierScreenState extends State<SupplierScreen> {
//   final prefs = PrefService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: btn_color4,
//           elevation: 4.0,
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.add),
//             ),
//             SizedBox(
//               width: 15,
//             )
//           ],
//         ),
//         body: Container(
//           child: BlocConsumer<SupplierListBloc, SupplierListState>(
//             builder: (context, state) {
//               return buildInitial();
//             },
//             listener: (context, state){
//               if(state is SupplierListLoading){
//                 const Center(child: CircularProgressIndicator());

//               }else if(state is SupplierListSuccess){
//                 prefs.
//               }
//             } ,
//           ),
//         ));
//   }

//   Widget buildInitial({required }){
//     return SingleChildScrollView(child: ,);
//   }
// }

import 'package:fikir_milk/const.dart';
import 'package:fikir_milk/homeScreen/blocs/home_bloc.dart';
import 'package:fikir_milk/homeScreen/data/homeDataSource.dart';
import 'package:fikir_milk/homeScreen/data/models/updateSupplier.dart';
import 'package:fikir_milk/homeScreen/tabs/update.dart';
import 'package:fikir_milk/homeScreen/tabs/widgets/dialogBox.dart';
import 'package:fikir_milk/sp_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikir_milk/homeScreen/data/homeRepository.dart';

class SupplierScreen extends StatefulWidget {
  final HomeRepository homeRepository;

  const SupplierScreen({Key? key, required this.homeRepository})
      : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SupplierListBloc(widget.homeRepository)..add(GetSupplierListEvent()),
      child: SupplierScreenContent(),
    );
  }
}

class SupplierScreenContent extends StatelessWidget {
  final prefs = PrefService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suppliers'),
        backgroundColor: btn_color4,
        elevation: 4.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return DialogBox();
              });
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      body: BlocBuilder<SupplierListBloc, SupplierListState>(
        builder: (context, state) {
          if (state is SupplierListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SupplierListSuccess) {
            final suppliers = state.supplier;

            return ListView.builder(
              itemCount: suppliers.length,
              itemBuilder: (context, index) {
                final supplierData = suppliers[index];
                return ListTile(
                  title: Text(supplierData.sup_name),
                  subtitle: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: supplierData.sup_phone + "\n"),
                        TextSpan(text: supplierData.id + "\n"),
                        TextSpan(text: supplierData.sup_address),
                      ],
                    ),
                  ),
                  onTap: () {
                    prefs.addSupplierId(supplierData.id);
                    print(supplierData.sup_name);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateScreen()));
                  },
                  onLongPress: () {
                    prefs.addSupplierId(supplierData.id);
                    print(supplierData.sup_name);
                    AlertDialog(
                      backgroundColor: Colors.purple[300],
                      content: Container(
                        child: Text('Delete'),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is SupplierListFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
