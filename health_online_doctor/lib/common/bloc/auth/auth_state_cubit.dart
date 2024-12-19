import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/common/bloc/auth/user_entity.dart';

import '../../../core/usecase.dart';

import '../../../core/user_storage.dart';
import 'auth_state.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AuthLoading());

  Future<void> execute({dynamic params, required UseCase useCase}) async {
    try {
      Either returnedData = await useCase.call(params: params);

      returnedData.fold((error) {
        emit(AuthFailure(errorMessage: error));
      }, (data) async {
        await UserStorage.setEmail(data.email);
        await UserStorage.setFullName(data.name);
        await UserStorage.setDescription(data.description);
        await UserStorage.setSpecialization(data.specialized);
        await UserStorage.setIsLogged(true);
        emit(AuthSuccess(user: data));
      });
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = UserStorage.getIsLogged() ?? false;
    try {
      if (isLoggedIn) {
        emit(AuthSuccess(
            user: UserEntity(
          email: UserStorage.getEmail()!,
          name: UserStorage.getFullName()!,
          description: UserStorage.getDescription()!,
          specialized: UserStorage.getSpecialization()!,
        )));
      } else {
        emit(AuthLoading());
      }
    } catch (e) {
      emit(AuthFailure(errorMessage: "Đăng nhập không thành công"));
    }
  }

  Future<void> logOut() async {
    UserStorage.setIsLogged(false);
    emit(AuthLoading());
  }
}
