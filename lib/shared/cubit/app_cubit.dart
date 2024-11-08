import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradua_project/shared/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/models/eidtusermodel.dart';
import 'package:gradua_project/models/change_Password_Model.dart';
import 'package:gradua_project/models/get_history_model.dart';
import 'package:gradua_project/models/home_model.dart';
import 'package:gradua_project/shared/network/end_points.dart';
import 'package:gradua_project/shared/network/remote/dio_helper.dart';
import '../../models/add_history_model.dart';
import '../../models/delete_his_item_model.dart';
import '../../models/user_model.dart';
import '../components/constants.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  //change visibility of Current Password

  IconData currentSuffix = Icons.visibility_off_outlined;
  bool currentIsPass = true;

  void changeCurrentPasswordVisibility() {
    currentIsPass = !currentIsPass;
    currentSuffix = currentIsPass
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ChangePasswordNewPasswordVisibilityState());
  }

  //change visibility of new Password

  IconData suffix = Icons.visibility_off_outlined;
  bool isPass = true;

  void changePasswordVisibility() {
    isPass = !isPass;
    suffix = isPass ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordNewPasswordVisibilityState());
  }

  // Get Home Data

  HomeModel? homeModel;

  void getPlants() async {
    emit(GetHomeLoadingState());
    if (homeModel == null) {
      await DioHelper.getData(url: GETPLANTS, token: token).then((value) {
        homeModel = HomeModel.fromJson(value.data);
        printLongString(homeModel!.toString());
        print(homeModel!.count);
        print(homeModel!.plants![0].name);
        print(homeModel!.plants![0].sId);
        emit(GetHomeSuccessState(homeModel!));
      }).catchError((error) {
        print(error.toString());
        emit(GetHomeErrorState());
      });
    } else {
      emit(GetHomeSuccessState(homeModel!));
    }
  }

  //Get User Data

  UserModel? userModel;

  void getUser() async {
    emit(GetUserLoadingState());
    await DioHelper.getData(url: USERDATA, token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      printLongString(userModel!.toString());
      print(userModel!.user!.username);
      print(userModel!.user!.email);
      print(userModel!.user!.sId);
      emit(GetUserSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState());
    });
  }

  //Edit User Name

  EditUserModel? editModel;

  void editUserName({
    String? name,
  }) async {
    emit(EditUserLoadingState());
    await DioHelper.putData(url: EDITUSERNAME, token: token, data: {
      "username": name,
    }).then((value) {
      editModel = EditUserModel.fromJson(value.data);
      printLongString(editModel!.toString());
      print(editModel!.message);
      emit(EditUserSuccessState(editModel!));
      getUser();
      emit(GetUserSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(EditUserErrorState());
    });
  }

  //Edit User Password

  ChangePasswordModel? changePassModel;
  void changePassword({
    String? oldPass,
    String? newPass,
  }) async {
    emit(ChangePasswordLoadingState());
    await DioHelper.putData(url: EDITUSERPASS, token: token, data: {
      "oldpassword": oldPass,
      "newpassword": newPass,
    }).then((value) {
      changePassModel = ChangePasswordModel.fromJson(value.data);
      printLongString(changePassModel!.toString());
      print(changePassModel!.message);
      emit(ChangePasswordSuccessState(changePassModel!));
      getUser();
      emit(GetUserSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ChangePasswordErrorState());
    });
  }

  //Get History

  GetHistoryModel? getHistoryModel;

  void getHistory() async {
    emit(GetHistoryLoadingState());
    await DioHelper.getData(url: GETHISTORY, token: token).then((value) {
      getHistoryModel = GetHistoryModel.fromJson(value.data);
      printLongString(getHistoryModel!.toString());
      print(getHistoryModel!.count);
      print(getHistoryModel!.history![0].diseaseName);
      emit(GetHistorySuccessState(getHistoryModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetHistoryErrorState());
    });
  }

  //Add History

  AddHistoryModel? addHistoryModel;

  // void addHistory({
  //   String? diseaseName,
  //   String? diseaseDescription,
  //   String? diseaseCure,
  //   var diseasePhoto,
  // }) async {
  //   emit(AddHistoryLoadingState());
  //   await DioHelper.postData(url: ADDHISTORY, token: token, data: {
  //     "diseasePhoto": diseasePhoto,
  //     "diseaseName": diseaseName,
  //     "diseaseDesciption": diseaseDescription,
  //     "diseaseCure": diseaseCure,
  //   }).then((value) {
  //     addHistoryModel = AddHistoryModel.fromJson(value.data);
  //     printLongString(addHistoryModel!.toString());
  //     print(addHistoryModel!.resu!.date);
  //     emit(AddHistorySuccessState(addHistoryModel!));
  //     getHistory();
  //     emit(GetHistorySuccessState(getHistoryModel!));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AddHistoryErrorState());
  //   });
  // }

  void addHistory({
    String diseaseName = '',
    String diseaseDescription = '',
    String diseaseCure = '',
    File? diseasePhoto,
  }) async {
    emit(AddHistoryLoadingState());

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://plantgradutionapi.herokuapp.com/history/add/'));
    request.fields.addAll({
      'diseaseName': diseaseName,
      'diseaseDesciption': diseaseDescription,
      'diseaseCure': diseaseCure
    });
    request.files.add(
        await http.MultipartFile.fromPath('diseasePhoto', diseasePhoto!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send().catchError((error) {
      showToast(
          msg: 'Pls, Check Your Internet access', state: ToastStates.ERROR);
    });

    if (response.statusCode == 200) {
      showToast(msg: 'Data Added to History', state: ToastStates.SUCCESS);
      print(await response.stream.bytesToString().then((value) {
        getHistory();
      }));
    } else {
      print(response.reasonPhrase);
    }

    // await DioHelper.postData(url: ADDHISTORY, token: token, data: {
    //   "diseasePhoto": diseasePhoto,
    //   "diseaseName": diseaseName,
    //   "diseaseDesciption": diseaseDescription,
    //   "diseaseCure": diseaseCure,
    // }).then((value) {
    //   addHistoryModel = AddHistoryModel.fromJson(value.data);
    //   printLongString(addHistoryModel!.toString());
    //   print(addHistoryModel!.resu!.date);
    //   emit(AddHistorySuccessState(addHistoryModel!));
    //   getHistory();
    //   emit(GetHistorySuccessState(getHistoryModel!));
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(AddHistoryErrorState());
    // });
  }

  DeleteHisItemModel? deleteHisItemModel;

  void deleteHistoryItem({
    String? id,
  }) async {
    emit(DeleteHistoryItemLoadingState());
    await DioHelper.deleteData(
      url: DELETEHISTORY + id!,
      token: token,
    ).then((value) {
      deleteHisItemModel = DeleteHisItemModel.fromJson(value.data);
      print(deleteHisItemModel!.message);
      emit(DeleteHistoryItemSuccessState());
      getHistory();
      emit(GetHistorySuccessState(getHistoryModel!));
    }).catchError((error) {
      print(error.toString());
      emit(DeleteHistoryItemErrorState());
    });
  }
}
