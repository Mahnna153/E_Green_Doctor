import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/modules/login/cubit/login_states.dart';
import 'package:gradua_project/shared/network/end_points.dart';
import 'package:gradua_project/shared/network/remote/dio_helper.dart';
import '../../../models/login_model.dart';
import '../../../shared/components/components.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_off_outlined;
  bool isPass = true;

  void changePasswordVisibility() {
    isPass = !isPass;
    suffix = isPass ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(LoginPasswordVisibilityState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(url: LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.message.toString());
      //print(value.statusMessage);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      showToast(
          msg: "Pls, Enter the correct Login data and Check Your Internet",
          state: ToastStates.ERROR);
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}
