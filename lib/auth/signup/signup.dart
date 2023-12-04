import 'package:fikir_milk/auth/signin/login.dart';
import 'package:fikir_milk/auth/signup/bloc/signup_bloc.dart';
import 'package:fikir_milk/auth/signup/data/signupModel.dart';
import 'package:fikir_milk/auth/widgets/button.dart';
import 'package:fikir_milk/homeScreen/tabs/home.dart';
import 'package:fikir_milk/sp_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../const.dart';
import '../widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signupFormKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool fullNameEmpty = false;
  bool phoneEmpty = false;
  bool roleEmpty = false;
  bool emailEmpty = false;
  bool phoneInvalid = false;

  final prefs = PrefService();

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Image.asset("assets/logo_white.png"),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                  ),
                  width: double.infinity,
                  child: BlocConsumer<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      return signUpForm();
                    },
                    listener: (context, state) {
                      isLoading = false;
                      if (state is SignUpLoading) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  content: CircularProgressIndicator(),
                                ));
                        isLoading = true;
                      } else if (state is SignUpSuccess) {
                        isLoading = false;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(selectedIndex: 0)));
                      } else if (state is SignUpFailure) {
                        isLoading = false;
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget signUpForm() {
    return Form(
      key: signupFormKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 71),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  'Add a User',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 27, height: 3),
                  textAlign: TextAlign.start,
                ),
              ),
              Center(
                child: Text(
                  'Please fill out all user information',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      height: 1.5,
                      color: dark_gray),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                controller: _fullNameController,
                obscureText: false,
                hintText: 'Full Name',
                suffixIcon: Icons.person,
                textType: TextInputType.name,
                autoFocus: false,
                onInteraction: () {
                  setState(() {
                    fullNameEmpty = false;
                  });
                },
              ),
              fullNameEmpty
                  ? Text(
                      "Full Name can't be empty",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : SizedBox(),
              MyTextField(
                controller: _phoneController,
                obscureText: false,
                hintText: 'Phone Number',
                suffixIcon: Icons.phone,
                textType: TextInputType.phone,
                autoFocus: false,
                onInteraction: () {
                  setState(() {
                    phoneEmpty = false;
                    phoneInvalid = false;
                  });
                },
              ),
              phoneEmpty
                  ? Text(
                      "Phone Number can't be empty",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 168, 147, 145),
                          fontSize: 16),
                    )
                  : SizedBox(),
              phoneInvalid
                  ? Text(
                      "Invalid Phone Number",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : SizedBox(),
              MyTextField(
                controller: _roleController,
                obscureText: false,
                hintText: 'Role',
                suffixIcon: Icons.person,
                textType: TextInputType.streetAddress,
                autoFocus: false,
                onInteraction: () {
                  setState(() {
                    roleEmpty = false;
                  });
                },
              ),
              roleEmpty
                  ? Text(
                      "Role can't be empty",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : SizedBox(),
              MyTextField(
                controller: _emailController,
                obscureText: false,
                hintText: 'Email Address',
                suffixIcon: Icons.email,
                textType: TextInputType.name,
                autoFocus: false,
                onInteraction: () {
                  setState(() {
                    emailEmpty = false;
                  });
                },
              ),
              emailEmpty
                  ? const Text(
                      "Email can't be empty",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : const SizedBox(),
              Button(
                  onPressed: () {
                    if (signupFormKey.currentState!.validate()) {
                      if (_fullNameController.text.isEmpty) {
                        return setState(() {
                          fullNameEmpty = true;
                        });
                      }
                      if (_emailController.text.isEmpty) {
                        return setState(() {
                          emailEmpty = true;
                        });
                      }
                      if (_phoneController.text.isEmpty) {
                        return setState(() {
                          phoneEmpty = true;
                        });
                      }
                      if (_phoneController.text.length != 10) {
                        return setState(() {
                          phoneInvalid = true;
                        });
                      }
                      if (_roleController.text.isEmpty) {
                        return setState(() {
                          roleEmpty = true;
                        });
                      }

                      final signup = BlocProvider.of<SignUpBloc>(context);
                      signup.add(onSignUpButtonPressed(SignUp(
                          full_name: _fullNameController.text,
                          phone_number: _phoneController.text,
                          role: _roleController.text,
                          email: _emailController.text)));
                    }
                  },
                  text: "Register"),
            ],
          ),
        ),
      ),
    );
  }
}
