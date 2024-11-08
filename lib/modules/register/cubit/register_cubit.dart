import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/models/register_model.dart';
import 'package:gradua_project/modules/register/cubit/register_states.dart';
import 'package:gradua_project/shared/components/components.dart';

import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_off_outlined;
  bool isPass = true;

  void changePasswordVisibility() {
    isPass = !isPass;
    suffix = isPass ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(RegisterPasswordVisibilityState());
  }

  RegisterModel? registerModel;

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    await DioHelper.postData(url: SIGNUP, data: {
      "username": name,
      "email": email,
      "password": password,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel!.message.toString());
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      showToast(
          msg: "Invalid Email,and Check Your Internet",
          state: ToastStates.ERROR);
      print(error.toString());
      emit(RegisterErrorState());
    });
  }
}
