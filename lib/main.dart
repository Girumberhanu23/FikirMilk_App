import 'package:fikir_milk/auth/signin/bloc/login_bloc.dart';
import 'package:fikir_milk/auth/signin/data/loginDataSource.dart';
import 'package:fikir_milk/auth/signin/data/loginRepo.dart';
import 'package:fikir_milk/auth/signin/login.dart';
import 'package:fikir_milk/auth/signup/bloc/signup_bloc.dart';
import 'package:fikir_milk/auth/signup/data/signupDataSource.dart';
import 'package:fikir_milk/auth/signup/data/signupRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// // void main() {
// //   final loginRepository = LoginRepository(LoginDataSource());

// //   runApp(MyApp(loginRepository: loginRepository));
// // }

// // class MyApp extends StatelessWidget {
// //   final LoginRepository loginRepository;

// //   const MyApp({Key? key, required this.loginRepository}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider<LoginBloc>(
// //       create: (context) => LoginBloc(loginRepository),
// //       child: MaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         theme: ThemeData(fontFamily: 'Poppins'),
// //         home: LoginScreen(),
// //       ),
// //     );
// //   }
// // }
// void main() {
//   final signUpRepository = SignUpRepository(SignUpDataSource());

//   runApp(MyApp(signUpRepository: signUpRepository));
// }

// class MyApp extends StatelessWidget {
//   final SignUpRepository signUpRepository;

//   const MyApp({Key? key, required this.signUpRepository}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<SignUpBloc>(
//       create: (context) => SignUpBloc(signUpRepository),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(fontFamily: 'Poppins'),
//         home: SignUpScreen(),
//       ),
//     );
//   }
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final signUpRepository = SignUpRepository(SignUpDataSource());
  final loginRepository = LoginRepository(LoginDataSource());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignUpBloc(signUpRepository)),
        BlocProvider(create: (_) => LoginBloc(loginRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fikir Milk',
        theme: ThemeData(fontFamily: 'Poppins'),
        home: LoginScreen(),
      ),
    );
  }
}
