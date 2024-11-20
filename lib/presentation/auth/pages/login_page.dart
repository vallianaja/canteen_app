import 'package:canteen_app/data/dataresource/auth_local_datasource.dart';
import 'package:canteen_app/presentation/auth/blocs/login/login_bloc.dart';
import 'package:canteen_app/presentation/general/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(80.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130.0),
            child: Image.asset(
              Assets.images.logo.path,
              width: 100,
              height: 100,
              color: AppColors.grey,
            ),
          ),
          const SpaceHeight(24.0),
          const Center(
            child: Text(
              "IDN Canteen",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
          const SpaceHeight(3.0),
          const Center(
            child: Text(
              'Healthy Meals for Happy Minds!',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: usernameController,
            hintText: 'Email',
            prefixIcon: Icon(
              Icons.email,
              color: AppColors.grey,
            ),
          ),
          const SpaceHeight(22.0),
          CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            prefixIcon: Icon(
              Icons.lock,
              color: AppColors.grey,
            ),
          ),
          const SpaceHeight(24.0),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                AuthLocalDatasource().saveAuthData(state.authResponseModel);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                );
              }
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Button.filled(
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginButtonPressed(
                        email: usernameController.text,
                        password: passwordController.text));
                  },
                  label: 'Login',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
