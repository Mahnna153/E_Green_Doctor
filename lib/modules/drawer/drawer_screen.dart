import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/modules/history/history_screen.dart';
import 'package:gradua_project/modules/home/home_screen.dart';
import 'package:gradua_project/modules/login/login.dart';
import 'package:gradua_project/modules/profile/profile_screen.dart';
import 'package:gradua_project/shared/components/components.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/cubit/app_states.dart';
import 'package:gradua_project/shared/network/local/cache_helper.dart';

import '../contact_us/contact_us.dart';

class drawerScreen extends StatefulWidget {
  const drawerScreen({Key? key}) : super(key: key);

  @override
  State<drawerScreen> createState() => _drawerScreenState();
}

class _drawerScreenState extends State<drawerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Drawer(
            child: Container(
              color: const Color(0xFF3eb489),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        navigateTo(context, HomeScreen());
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.home,
                            size: 25.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    divider(),
                    AppCubit.get(context).homeModel == null
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(
                                height: 15.0,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  cubit.getHistory();
                                  Timer(const Duration(seconds: 2), () {
                                    setState(() {
                                      navigateTo(context, HistoryScreen());
                                    });
                                  });
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.history,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      'History',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              divider(),
                              const SizedBox(
                                height: 15.0,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  cubit.getUser();
                                  navigateTo(context, ProfileScreen());
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.account_circle,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              divider(),
                              const SizedBox(
                                height: 15.0,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  navigateTo(context, ContactUsScreen());
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.people,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      'Contact us',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
