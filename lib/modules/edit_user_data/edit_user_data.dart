import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/cubit/app_states.dart';

import '../../shared/components/components.dart';
import '../drawer/drawer_screen.dart';

class EditUserData extends StatelessWidget {
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  var changePasskey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is EditUserSuccessState) {
        showToast(
            msg: AppCubit.get(context).editModel!.message.toString(),
            state: ToastStates.SUCCESS);
      } else if (state is EditUserErrorState) {
        showToast(msg: 'Check Your Internet', state: ToastStates.ERROR);
      }
    }, builder: (context, state) {
      var cubit = AppCubit.get(context);
      nameCont.text = cubit.userModel!.user!.username!;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Edit'),
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
                    if (state is EditUserLoadingState)
                      Column(
                        children: const [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Current Name',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextFormField(
                        controller: nameCont,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                            border: const UnderlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cant be Empty';
                          }
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Current E-mail',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextFormField(
                        controller: emailCont,
                        enabled: false,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          label: Text('${cubit.userModel!.user!.email}'),
                          contentPadding: EdgeInsets.all(15),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) {}),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (changePasskey.currentState!.validate()) {
                              cubit.editUserName(name: nameCont.text.trim());
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ]),
            )),
      );
    });
  }
}
