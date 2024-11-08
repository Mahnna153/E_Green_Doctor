import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/cubit/app_states.dart';

import '../../shared/components/components.dart';
import '../drawer/drawer_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController ConfNewPass = TextEditingController();
  var changePasskey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is ChangePasswordSuccessState) {
        showToast(
            msg: AppCubit.get(context).changePassModel!.message.toString(),
            state: ToastStates.SUCCESS);
        currentPass.text = '';
        newPass.text = '';
        ConfNewPass.text = '';
      } else if (state is ChangePasswordErrorState) {
        showToast(
            msg: 'Pls Enter The Right Current Password and Try Again',
            state: ToastStates.ERROR);
      }
    }, builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Change Password'),
          centerTitle: true,
        ),
        body: Container(
            color: Colors.white,
            width: double.infinity,
            //height: 280,
            padding: EdgeInsets.all(20),
            child: Form(
              key: changePasskey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is ChangePasswordLoadingState)
                      Column(
                        children: const [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    const Text(
                      'Current Password',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextFormField(
                        controller: currentPass,
                        obscureText: cubit.currentIsPass,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          suffix: cubit.currentSuffix != null
                              ? IconButton(
                                  onPressed: () {
                                    cubit.changeCurrentPasswordVisibility();
                                  },
                                  icon: Icon(cubit.currentSuffix))
                              : null,
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Please enter Current Password',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                          border: const UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cant be Empty';
                          }
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'New Password',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextFormField(
                        controller: newPass,
                        textCapitalization: TextCapitalization.words,
                        obscureText: cubit.isPass,
                        decoration: InputDecoration(
                          suffix: cubit.suffix != null
                              ? IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(cubit.suffix))
                              : null,
                          contentPadding: EdgeInsets.all(15),
                          hintText: 'Please enter New Password',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cant be Empty';
                          }
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Confirm New Password',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextFormField(
                        controller: ConfNewPass,
                        obscureText: cubit.isPass,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          hintText: 'Please Confirm Your New Password',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cant be Empty';
                          }
                        }),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (changePasskey.currentState!.validate()) {
                              if (ConfNewPass.text.trim() ==
                                  newPass.text.trim()) {
                                cubit.changePassword(
                                    oldPass: currentPass.text.trim(),
                                    newPass: newPass.text.trim());
                              } else {
                                showToast(
                                    msg: 'Password is not matched',
                                    state: ToastStates.ERROR);
                              }
                            }
                          },
                          child: const Text(
                            'Change Password',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ]),
            )),
      );
    });
  }
}
