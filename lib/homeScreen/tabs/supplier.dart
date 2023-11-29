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

import 'package:fikir_milk/homeScreen/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikir_milk/homeScreen/data/homeRepository.dart';

class SupplierScreen extends StatelessWidget {
  final HomeRepository homeRepository;

  const SupplierScreen({Key? key, required this.homeRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SupplierListBloc(homeRepository)..add(GetSupplierListEvent()),
      child: SupplierScreenContent(),
    );
  }
}

class SupplierScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suppliers'),
      ),
      body: BlocBuilder<SupplierListBloc, SupplierListState>(
        builder: (context, state) {
          print(state); // Add this line for debugging

          if (state is SupplierListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SupplierListSuccess) {
            final suppliers = state.supplier;

            return ListView.builder(
              itemCount: suppliers.length,
              itemBuilder: (context, index) {
                final supplier = suppliers[index];
                return ListTile(
                  title: Text(suppliers.sup_name),
                  subtitle: Text(suppliers.sup_phone),
                  // Display other details as needed
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
