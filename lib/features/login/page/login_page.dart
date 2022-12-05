import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_application/features/login/cubit/login_cubit.dart';
import 'package:test_application/features/login/page/widget/custom_toast.dart';

import '../../dashboard/page/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final toast = FToast();

  @override
  void initState() {
    toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginInProgress) {
          showDialog(
              context: context,
              builder: (_) => Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 7.5,
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor))));
        } else if (state is LoginFailure) {
          Navigator.of(context).pop();
          toast.showToast(
              gravity: ToastGravity.CENTER,
              child: CustomToast(message: state.message));
        } else if (state is LoginSuccess) {
          Navigator.of(context)
            ..pop()
            ..pushReplacement(MaterialPageRoute(
                builder: (context) => DashboardPage(name: state.user.name)));
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.r, vertical: 20.r),
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      SvgPicture.asset(
                        'assets/Mobile login-amico.svg',
                        width: 322.w,
                        height: 384.h,
                      ),
                      Text('My APPS',
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(.3),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Username',
                        labelStyle: const TextStyle(color: Color(0xFF006778))),
                    // style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(height: 13.h),
                  BlocSelector<LoginCubit, LoginState, bool>(
                    selector: (state) =>
                        state is LoginVisibility ? state.value : false,
                    builder: (context, value) {
                      return TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !value,
                          textInputAction: TextInputAction.done,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).primaryColor.withOpacity(.3),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Password',
                            labelStyle:
                                const TextStyle(color: Color(0xFF006778)),
                            suffixIcon: IconButton(
                              icon: value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              color: const Color(0xFF006778),
                              onPressed: () =>
                                  context.read<LoginCubit>().change(!value),
                            ),
                          ));
                    },
                  ),
                  SizedBox(height: 45.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        fixedSize: Size(322.r, 56.r)),
                    child: const Text('LOGIN'),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context
                          .read<LoginCubit>()
                          .login(emailController.text, passwordController.text);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
