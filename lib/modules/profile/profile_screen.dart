// import 'package:flutter/material.dart';
// import 'package:gradua_project/modules/drawer/drawer_screen.dart';
//
// import '../../shared/components/components.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//
//   final _formKey = GlobalKey<FormState>();
//   final _controllerForUserName = TextEditingController();
//   final _controllerForPass = TextEditingController();
//   bool _showORnot = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const drawerScreen(),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         //leading: const Icon(Icons.menu),
//         title: const Text('Profile'),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(children: [
//           Center(
//             child: Column(children: [
//               const SizedBox(
//                 height: 30,
//               ),
//               CircleAvatar(
//                 child: Image.asset(
//                   'assets/images/logo_1.png',
//                   width: 120.0,
//                   height: 120.0,
//                 ),
//                 radius: 30,
//                 backgroundColor: Colors.white,
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               SizedBox(
//                 width: 374,
//                 height: 63,
//                 child: TextFormField(
//                   controller: _controllerForUserName,
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Please enter your name'
//                       : null,
//                   keyboardType: TextInputType.text,
//                   textInputAction: TextInputAction.next,
//                   autocorrect: false,
//                   decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         onPressed: () => _controllerForUserName.clear(),
//                         icon: const Icon(
//                           Icons.clear,
//                         ),
//                       ),
//                       label: Row(children: const [
//                         Icon(Icons.supervised_user_circle_rounded),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           'User Name',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Color(0xffa1a4b2),
//                             letterSpacing: 0.12,
//                           ),
//                         ),
//                       ]),
//                       border: const OutlineInputBorder(),
//                       filled: true,
//                       fillColor: const Color.fromARGB(255, 238, 239, 247)),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: 374,
//                 height: 63,
//                 child: TextFormField(
//                   controller: _controllerForPass,
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Please enter your e-mail'
//                       : null,
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   autocorrect: false,
//                   decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         onPressed: () => _controllerForPass.clear(),
//                         icon: const Icon(
//                           Icons.clear,
//                         ),
//                       ),
//                       label: Row(children: const [
//                         Icon(Icons.mail_rounded),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           'Email address',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontFamily: 'PoppinsLight',
//                             color: Color(0xffa1a4b2),
//                             letterSpacing: 0.12,
//                           ),
//                         ),
//                       ]),
//                       border: const OutlineInputBorder(),
//                       filled: true,
//                       fillColor: const Color.fromARGB(255, 238, 239, 247)),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: 374,
//                 height: 63,
//                 child: TextFormField(
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Please enter password'
//                       : null,
//                   keyboardType: TextInputType.text,
//                   obscureText: _showORnot,
//                   textInputAction: TextInputAction.next,
//                   autocorrect: false,
//                   decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         onPressed: () => setState(() {
//                           _showORnot = !_showORnot;
//                         }),
//                         icon: Icon(
//                           _showORnot ? Icons.visibility : Icons.visibility_off,
//                         ),
//                       ),
//                       label: Row(children: const [
//                         Icon(Icons.lock),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           'Password',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontFamily: 'PoppinsLight',
//                             color: Color(0xffa1a4b2),
//                             letterSpacing: 0.12,
//                           ),
//                         ),
//                       ]),
//                       border: const OutlineInputBorder(),
//                       filled: true,
//                       fillColor: const Color.fromARGB(255, 238, 239, 247)),
//                 ),
//               ),
//               const SizedBox(
//                 height: 280.0,
//               ),
//
//               defButton(text: "Edit", width: 380.0, function: () {}),
//               // ElevatedButton(
//               //   onPressed: () => _formKey.currentState!.validate()
//               //       ? ScaffoldMessenger.of(context).showSnackBar(
//               //           const SnackBar(content: Text('Processing Data')),
//               //         )
//               //       : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               //           padding: EdgeInsets.fromLTRB(136, 10, 136, 10),
//               //           content: Text(
//               //             'Please fill all',
//               //             style: TextStyle(
//               //               fontSize: 17,
//               //               fontFamily: 'PoppinsBold',
//               //               letterSpacing: 1.5,
//               //               color: Colors.white,
//               //             ),
//               //           ),
//               //         )),
//               //   child: const Text(
//               //     'Edit',
//               //     style: TextStyle(
//               //       fontSize: 20,
//               //       letterSpacing: 1.5,
//               //       color: Colors.white,
//               //     ),
//               //   ),
//               //   style: ButtonStyle(
//               //       minimumSize: MaterialStateProperty.all(const Size(347, 63)),
//               //       backgroundColor: MaterialStateProperty.all(
//               //         const Color(0xff3eb489),
//               //       )),
//               // ),
//             ]),
//           ),
//         ]),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/modules/change_password/change_password.dart';
import 'package:gradua_project/modules/home/home_screen.dart';
import 'package:gradua_project/shared/components/components.dart';
import 'package:gradua_project/shared/components/components.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/cubit/app_states.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../shared/network/local/cache_helper.dart';
import '../drawer/drawer_screen.dart';
import '../edit_user_data/edit_user_data.dart';
import '../login/login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool hasInternet = false;
  // late StreamSubscription internetSubscription;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   internetSubscription =
  //       InternetConnectionChecker().onStatusChange.listen((status) {
  //     final hasNet = status == InternetConnectionStatus.connected;
  //     setState(() {
  //       hasInternet = hasNet;
  //     });
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   internetSubscription.cancel();
  //   super.dispose();
  // }

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        var model = cubit.userModel;
        nameController.text = model!.user!.username!;
        emailController.text = model.user!.email!;
        passwordController.text = model.user!.sId!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Profile'),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Colors.grey[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is GetUserLoadingState)
                      Column(
                        children: const [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ahlan ${model.user!.username}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '${model.user!.email}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 280,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'PERSONAL INFORMATION',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Name',
                              style: TextStyle(fontSize: 15),
                            ),
                            defFormField(
                                enabled: false,
                                controller: nameController,
                                context: context,
                                prefix: Icons.person,
                                validate: (value) {},
                                label: ''),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              'E-mail',
                              style: TextStyle(fontSize: 15),
                            ),
                            defFormField(
                                enabled: false,
                                context: context,
                                controller: emailController,
                                prefix: Icons.email,
                                validate: (value) {},
                                label: ''),
                          ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SECURITY INFORMATION',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                navigateTo(context, ChangePasswordScreen());
                              },
                              child: const Text('Change Password')),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const Spacer(),
                            defButton(
                              text: 'Edit',
                              function: () {
                                navigateTo(context, EditUserData());
                              },
                              height: 45,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            defButton(
                              text: 'Sign out',
                              bgColor: Colors.redAccent,
                              function: () {
                                CacheHelper.removeData('token').then((value) {
                                  if (value) {
                                    navigateAndKill(context, LogInScreen());
                                  }
                                });
                              },
                              height: 45,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
