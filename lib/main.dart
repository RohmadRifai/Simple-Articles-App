import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_application/features/dashboard/cubit/article_cubit.dart';
import 'package:test_application/features/login/cubit/login_cubit.dart';
import 'package:test_application/features/login/page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => ArticleCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test',
          theme: ThemeData(
              primaryColor: const Color(0xFF247881),
              errorColor: const Color(0xFFB22727)),
          home: const LoginPage(),
        ),
      ),
    );
  }
}
