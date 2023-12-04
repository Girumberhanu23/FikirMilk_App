import 'package:fikir_milk/auth/signin/bloc/login_bloc.dart';
import 'package:fikir_milk/auth/signin/data/loginModel.dart';
import 'package:fikir_milk/const.dart';
import 'package:fikir_milk/homeScreen/tabs/home.dart';
import 'package:fikir_milk/sp_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool pinEmpty = false;
  bool phoneEmpty = false;
  bool phoneInvalid = false;
  bool pinInvalid = false;

  final loginService = PrefService();

  TextEditingController _email_or_phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, left: 20),
                      child: Image.asset("assets/logo_white.png"),
                    ),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
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
                child: BlocConsumer<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return loginForm();
                  },
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                content: CircularProgressIndicator(),
                              ));
                      isLoading = true;
                    } else if (state is LoginSuccess) {
                      isLoading = false;
                      loginService.login(_passwordController.text);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(selectedIndex: 0)),
                          (route) => false);
                    } else if (state is LoginFailure) {
                      isLoading = false;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: loginFormKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 71, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login to your account',
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 27, height: 3),
                textAlign: TextAlign.start,
              ),
              Text(
                'Welcome back! Effortlessly create and send invitations.',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    height: 1.5,
                    color: dark_gray),
              ),
              const SizedBox(
                height: 60,
              ),
              MyTextField(
                controller: _email_or_phoneController,
                hintText: 'Enter your Email or Phone Number',
                obscureText: false,
                suffixIcon: Icons.person,
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
                      "Phone can't be empty",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : SizedBox(),
              phoneInvalid
                  ? Text(
                      "Please enter a valid phone number",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : SizedBox(),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: _passwordController,
                hintText: 'PIN',
                obscureText: false,
                suffixIcon: Icons.phone,
                textType: TextInputType.visiblePassword,
                autoFocus: false,
                onInteraction: () {
                  setState(() {
                    pinEmpty = false;
                    pinInvalid = false;
                  });
                },
              ),
              pinEmpty
                  ? Text(
                      "PIN can't be empty",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : SizedBox(),
              pinInvalid
                  ? Text(
                      "Please enter a valid pin",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: RichText(
                  text: TextSpan(
                    text: 'Forget Password',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(selectedIndex: 0)));
                      },
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: btn_color), // Specify the color here
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 180),
                  child: ElevatedButton(
                    onPressed: () {
                      if (loginFormKey.currentState!.validate()) {
                        if (_email_or_phoneController.text.isEmpty) {
                          return setState(() {
                            phoneEmpty = true;
                          });
                        }
                        if (_passwordController.text.isEmpty) {
                          return setState(() {
                            pinEmpty = true;
                          });
                        }
                        if (_passwordController.text.length < 4) {
                          return setState(() {
                            pinInvalid = true;
                          });
                        } else {
                          setState(() {
                            pinInvalid = false;
                          });
                        }
                        final login = BlocProvider.of<LoginBloc>(context);
                        login.add(LoginButtonPressed(Login(
                          email_or_phone: _email_or_phoneController.text,
                          password: _passwordController.text,
                        )));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: btn_color,
                        padding: EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      const TextSpan(text: 'Are you new to this app?'),
                      TextSpan(
                        text: ' Create Account',
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
