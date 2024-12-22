import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/common/bloc/auth/auth_state_cubit.dart';
import 'package:health_online_doctor/core/app_colors.dart';
import 'package:health_online_doctor/data/auth/models/login_input.dart';

import '../../../common/bloc/auth/auth_state.dart';
import '../../../domain/auth/usecase/login_usecase.dart';
import '../../dashboard/page/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() {
    context.read<AuthStateCubit>().execute(
        useCase: LoginUseCase(),
        params: LoginInput(
            email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return BlocListener<AuthStateCubit, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đăng nhập thành công')));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardPage()));
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                    child: Image.asset(
                  "assets/picture/login.png",
                  width: 500,
                )),
                const SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(right: 50, left: 50, bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Who are you?",
                          style:
                              TextStyle(fontSize: 50, color: AppColors.primary),
                        ),
                        const SizedBox(height: 50),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          obscureText: _obscurePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                child:
                                    Text(_obscurePassword ? "show" : "hide")),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: login,
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
