import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/common/bloc/auth/auth_state_cubit.dart';
import 'package:health_online_doctor/presentation/auth/page/login_page.dart';
import 'package:health_online_doctor/presentation/dashboard/page/dashboard_page.dart';
import 'package:health_online_doctor/service_locator.dart';
import 'common/bloc/auth/auth_state.dart';
import 'core/app_theme.dart';
import 'core/user_storage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await UserStorage.init();
  final authCubit = AuthStateCubit();
  await authCubit.checkLoginStatus();
  runApp(
    BlocProvider(
      create: (context) => authCubit,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.customTheme,
        home: BlocBuilder<AuthStateCubit, AuthState>(
            builder: (BuildContext context, AuthState state) {
              if (state is AuthSuccess) {
                return DashboardPage();
              }
              return LoginPage();
            })
    );
  }
}

