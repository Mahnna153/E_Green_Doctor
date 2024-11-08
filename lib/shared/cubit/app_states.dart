import 'package:gradua_project/models/get_history_model.dart';
import 'package:gradua_project/models/home_model.dart';
import 'package:gradua_project/models/user_model.dart';
import 'package:gradua_project/models/change_Password_Model.dart';

import '../../models/add_history_model.dart';
import '../../models/eidtusermodel.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangePasswordNewPasswordVisibilityState extends AppStates {}

class GetHomeLoadingState extends AppStates {}

class GetHomeSuccessState extends AppStates {
  final HomeModel homeModel;
  GetHomeSuccessState(this.homeModel);
}

class GetHomeErrorState extends AppStates {}

class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {
  final UserModel usermodel;
  GetUserSuccessState(this.usermodel);
}

class GetUserErrorState extends AppStates {}

class EditUserLoadingState extends AppStates {}

class EditUserSuccessState extends AppStates {
  final EditUserModel editmodel;
  EditUserSuccessState(this.editmodel);
}

class EditUserErrorState extends AppStates {}

class ChangePasswordLoadingState extends AppStates {}

class ChangePasswordSuccessState extends AppStates {
  final ChangePasswordModel changePassModel;
  ChangePasswordSuccessState(this.changePassModel);
}

class ChangePasswordErrorState extends AppStates {}

class GetHistoryLoadingState extends AppStates {}

class GetHistorySuccessState extends AppStates {
  final GetHistoryModel getHistoryModel;
  GetHistorySuccessState(this.getHistoryModel);
}

class GetHistoryErrorState extends AppStates {}

class AddHistoryLoadingState extends AppStates {}

class AddHistorySuccessState extends AppStates {
  final AddHistoryModel addHistoryModel;
  AddHistorySuccessState(this.addHistoryModel);
}

class AddHistoryErrorState extends AppStates {}

class DeleteHistoryItemLoadingState extends AppStates {}

class DeleteHistoryItemSuccessState extends AppStates {}

class DeleteHistoryItemErrorState extends AppStates {}

class GetHistoryItemDetailsLoadingState extends AppStates {}

class GetHistoryItemDetailsSuccessState extends AppStates {}
