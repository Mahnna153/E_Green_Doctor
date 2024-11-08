import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/modules/login/login.dart';
import 'package:gradua_project/modules/register/cubit/register_states.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            showToast(
                msg: state.registerModel.message.toString(),
                state: ToastStates.SUCCESS);
            navigateAndKill(context, LogInScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Image(
                                image: AssetImage('assets/images/logo_1.png'),
                                fit: BoxFit.cover,
                                height: 90.0,
                                width: 80.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            "Create your account,",
                            style: TextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            "Register to get started",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1.0,
                                  blurRadius: 13.0,
                                  offset: Offset(1.0, 3.0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  defFormField(
                                      context: context,
                                      controller: nameController,
                                      keyboardType: TextInputType.name,
                                      label: 'Name',
                                      prefix: Icons.person_outline,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Name must be filled';
                                        }
                                      }),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  defFormField(
                                      context: context,
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      label: 'Email Address',
                                      prefix: Icons.email_outlined,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Email Address must be filled';
                                        }
                                      }),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  defFormField(
                                      context: context,
                                      controller: passwordController,
                                      suffix: RegisterCubit.get(context).suffix,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      isPassword:
                                          RegisterCubit.get(context).isPass,
                                      suffixPressed: () {
                                        RegisterCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                      label: 'Password',
                                      prefix: Icons.lock_outline,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password must be filled';
                                        }
                                      }),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  defFormField(
                                      context: context,
                                      controller: confirmPasswordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      isPassword:
                                          RegisterCubit.get(context).isPass,
                                      label: 'Confirm Password',
                                      prefix: Icons.lock_outline,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Confirm Password must be filled';
                                        }
                                      }),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  ConditionalBuilder(
                                    condition: state is! RegisterLoadingState,
                                    builder: (context) => defButton(
                                        text: "REGISTER",
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (passwordController.text ==
                                                confirmPasswordController
                                                    .text) {
                                              RegisterCubit.get(context)
                                                  .register(
                                                      name: nameController.text
                                                          .trim(),
                                                      email: emailController
                                                          .text
                                                          .trim(),
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim());
                                            } else {
                                              showToast(
                                                  msg:
                                                      'Password is not matched',
                                                  state: ToastStates.ERROR);
                                            }
                                          }
                                        }),
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
