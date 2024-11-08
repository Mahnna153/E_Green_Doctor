import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/modules/drawer/drawer_screen.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/cubit/app_states.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../shared/components/components.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          //print(cubit.getHistoryModel!.history![0].diseaseName);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('History'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is DeleteHistoryItemLoadingState)
                    Column(
                      children: const [
                        LinearProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ConditionalBuilder(
                    condition: cubit.getHistoryModel != null,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          if (state is GetHistoryLoadingState)
                            Column(
                              children: const [
                                LinearProgressIndicator(),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => historyItem(
                                  context,
                                  cubit.getHistoryModel!.history![index],
                                  index),
                              separatorBuilder: (context, index) => divider2(),
                              itemCount:
                                  cubit.getHistoryModel!.history!.length),
                        ],
                      ),
                    ),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
