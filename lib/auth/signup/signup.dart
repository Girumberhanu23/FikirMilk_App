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
  bool? _isChecked = false;
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
              const Text(
                'Create an account',
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 27, height: 3),
                textAlign: TextAlign.start,
              ),
              Text(
                'Join us, create invitations for your upcoming events, and let\'s invite your guests together.',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    height: 1.5,
                    color: dark_gray),
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
              Row(
                children: [
                  Checkbox(
                      value: _isChecked,
                      activeColor: btn_color,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isChecked = newValue;
                        });
                      }),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        const TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms & Conditions',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await prefs.removeToken();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          style: TextStyle(
                              color: btn_color), // Specify the color here
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy.',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          style: TextStyle(
                              color: btn_color), // Specify the color here
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                  disable: _isChecked,
                  text: "SignUp"),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      const TextSpan(text: 'Already have an account?'),
                      TextSpan(
                        text: ' Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(selectedIndex: 0)));
                          },
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: btn_color), // Specify the color here
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
