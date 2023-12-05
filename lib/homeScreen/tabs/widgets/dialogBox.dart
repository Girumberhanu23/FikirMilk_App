import 'dart:io';

import 'package:fikir_milk/auth/widgets/textfield.dart';
import 'package:fikir_milk/homeScreen/blocs/home_bloc.dart';
import 'package:fikir_milk/homeScreen/data/models/createSupplier.dart';
import 'package:fikir_milk/homeScreen/tabs/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  File? _selectedImage;
  TextEditingController _supNameController = TextEditingController();
  TextEditingController _supPhoneController = TextEditingController();
  TextEditingController _supAddressController = TextEditingController();
  // TextEditingController _testerController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String? contentType;
  File? _pickedImage;
  Uint8List selectedWebImage = Uint8List(8);

  String _imagePath = "";

  @override
  void dispose() {
    _supNameController.dispose();
    _supPhoneController.dispose();
    _supAddressController.dispose();
    // _testerController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateSupplierBloc, CreateSupplierState>(
      builder: (context, state) {
        return buildInitialInput();
      },
      listener: (context, state) {
        print(state);
        if (state is CreateSupplierLoading) {
          const Center(child: CircularProgressIndicator());
        } else if (state is CreateSupplierSuccess) {
          Navigator.of(context).pop();
        } else if (state is CreateSupplierFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed')));
        }
      },
    );
  }

  Widget buildInitialInput() {
    return AlertDialog(
      backgroundColor: Colors.purple[200],
      content: Container(
          height: 450,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyTextField(
                  controller: _supNameController,
                  hintText: 'Supplier Name',
                  obscureText: false,
                  suffixIcon: Icons.person,
                  textType: TextInputType.name,
                  autoFocus: false,
                  onInteraction: () {
                    setState(() {});
                  },
                ),
                PhoneInputField(
                  controller: _supPhoneController,
                  hintText: 'Supplier Phone Number',
                  obscureText: false,
                  suffixIcon: Icons.phone,
                  textType: TextInputType.phone,
                  autoFocus: false,
                  onInteraction: () {
                    setState(() {});
                  },
                ),
                MyTextField(
                  controller: _supAddressController,
                  hintText: 'Supplier Address',
                  obscureText: false,
                  suffixIcon: Icons.pin_drop,
                  textType: TextInputType.streetAddress,
                  autoFocus: false,
                  onInteraction: () {
                    setState(() {});
                  },
                ),
                // MyTextField(
                //   controller: _testerController,
                //   hintText: 'Tester',
                //   obscureText: false,
                //   suffixIcon: Icons.person,
                //   textType: TextInputType.name,
                //   autoFocus: false,
                //   onInteraction: () {
                //     setState(() {});
                //   },
                // ),
                MyTextField(
                  controller: _amountController,
                  hintText: 'Amount',
                  obscureText: false,
                  suffixIcon: Icons.list,
                  textType: TextInputType.number,
                  autoFocus: false,
                  onInteraction: () {
                    setState(() {});
                  },
                ),
                MyTextField(
                  controller: _priceController,
                  hintText: 'Price',
                  obscureText: false,
                  suffixIcon: Icons.money,
                  textType: TextInputType.number,
                  autoFocus: false,
                  onInteraction: () {
                    setState(() {});
                  },
                ),
                MaterialButton(
                  child: Icon(Icons.camera),
                  onPressed: () {
                    _pickImage();
                  },
                ),
                ElevatedButton(
                  onPressed: () {

                    final addSupplier =
                        BlocProvider.of<CreateSupplierBloc>(context);
                    addSupplier.add(PostSupplierEvent(CreateSupplier(
                        sup_name: _supNameController.text,
                        sup_phone: _supPhoneController.text,
                        sup_address: _supAddressController.text,
                        amount: _amountController.text,
                        price: _priceController.text,
                        picture: _imagePath)));
                    // Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
                    'Add Supplier',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> _pickImage() async {

    try{
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
      }
    } catch(e){
      print(e);
    }

  }
}
