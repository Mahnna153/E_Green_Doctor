import 'package:gradua_project/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {}

class LoginPasswordVisibilityState extends LoginStates {}
