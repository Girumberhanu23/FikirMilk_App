import 'package:fikir_milk/auth/widgets/textfield.dart';
import 'package:fikir_milk/const.dart';
import 'package:fikir_milk/homeScreen/blocs/home_bloc.dart';
import 'package:fikir_milk/homeScreen/data/models/updateSupplier.dart';
import 'package:fikir_milk/sp_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _sup_phoneController = TextEditingController();
  TextEditingController _cobController = TextEditingController();
  TextEditingController _organoLepticController = TextEditingController();
  TextEditingController _gerberController = TextEditingController();

  final prefs = PrefService();

  @override
  void dispose() {
    _sup_phoneController.dispose();
    _cobController.dispose();
    _organoLepticController.dispose();
    _gerberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suppliers'),
        backgroundColor: btn_color4,
        elevation: 4.0,
      ),
      body: BlocConsumer<UpdateSupplierBloc, UpdateSupplierState>(
          builder: (_, state) {
        return buildInitialInput();
      }, listener: (_, state) async {
        print(state);
        if (state is UpdateSupplierLoading) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: CircularProgressIndicator(),
                  ));
        } else if (state is UpdateSupplierSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UpdateScreen()));
        } else if (state is UpdateSupplierFailure) {
          print('Failed to update supplier: ${state.error}');
          // Handle the failure state appropriately (e.g., show error message to the user)
        }
      }),
    );
  }

  Widget buildInitialInput() {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          MyTextField(
              controller: _sup_phoneController,
              hintText: "Enter Phone Number",
              obscureText: false,
              suffixIcon: Icons.phone,
              textType: TextInputType.phone,
              autoFocus: false,
              onInteraction: () {}),
          MyTextField(
              controller: _cobController,
              hintText: "Cob",
              obscureText: false,
              suffixIcon: Icons.person,
              textType: TextInputType.text,
              autoFocus: false,
              onInteraction: () {}),
          MyTextField(
              controller: _organoLepticController,
              hintText: "Organo Leptic",
              obscureText: false,
              suffixIcon: Icons.person,
              textType: TextInputType.text,
              autoFocus: false,
              onInteraction: () {}),
          MyTextField(
              controller: _gerberController,
              hintText: "Gerber",
              obscureText: false,
              suffixIcon: Icons.person,
              textType: TextInputType.text,
              autoFocus: false,
              onInteraction: () {}),
          ElevatedButton(
            onPressed: () {
              final updateSupplier =
                  BlocProvider.of<UpdateSupplierBloc>(context);
              updateSupplier.add(PatchSupplierEvent(UpdateSupplier(
                  sup_phone: _sup_phoneController.text,
                  tests: Tests(
                      cob: _cobController.text,
                      organo_leptic: _organoLepticController.text,
                      gerber: _gerberController.text))));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[100],
                padding: EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: const Text(
              'Update',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
