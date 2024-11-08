import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/app_states.dart';

class AnalysisScreen extends StatelessWidget {
  List? out;
  File? imageP;

  AnalysisScreen(List? output, File? image) {
    out = output;
    imageP = image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              //leading: const Icon(Icons.menu),
              title: const Text('Result'),
              centerTitle: true,
            ),
            body: buildAnalysisItem(out!, imageP!),
          );
        },
      ),
    );
  }
}
