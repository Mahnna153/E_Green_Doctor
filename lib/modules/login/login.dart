import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/modules/home/home_screen.dart';
import 'package:gradua_project/modules/login/cubit/login_cubit.dart';
import 'package:gradua_project/modules/login/cubit/login_states.dart';
import 'package:gradua_project/shared/components/components.dart';
import 'package:gradua_project/shared/components/constants.dart';
import 'package:gradua_project/shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';

class LogInScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.token.toString())
                .then((value) {
              token = state.loginModel.token;
              navigateAndKill(context, HomeScreen());
            });
            print(state.loginModel.token.toString());
            showToast(
                msg: state.loginModel.message.toString(),
                state: ToastStates.SUCCESS);
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
                          Container(
                            width: double.infinity,
                            child: const Center(
                              child: Image(
                                image: AssetImage('assets/images/logo_1.png'),
                                fit: BoxFit.cover,
                                height: 90.0,
                                width: 80.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60.0,
                          ),
                          const Text(
                            "Welcome Back,",
                            style: TextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            "Login to continue",
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
                                      suffix: LoginCubit.get(context).suffix,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      isPassword:
                                          LoginCubit.get(context).isPass,
                                      suffixPressed: () {
                                        LoginCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                      label: 'Password',
                                      prefix: Icons.lock_outline,
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          LoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password must be filled';
                                        }
                                      }),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  ConditionalBuilder(
                                    condition: state is! LoginLoadingState,
                                    builder: (context) => defButton(
                                        text: "login",
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            LoginCubit.get(context).userLogin(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim());
                                          }
                                        }),
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text(
                                  'Register Now',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ],
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
