import 'package:gradua_project/models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {}

class RegisterPasswordVisibilityState extends RegisterStates {}
