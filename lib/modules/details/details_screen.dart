import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';
import '../drawer/drawer_screen.dart';

class DetailsScreen extends StatelessWidget {
  late int ind;

  DetailsScreen({
    int index = 0,
  }) {
    ind = index;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getHistory(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          // print("${item} Done :)");
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Details'),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
                condition: state is! GetHistoryLoadingState,
                builder: (context) => buildDetailsItem(
                    context, cubit.getHistoryModel!.history![ind]),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator())),
          );
        },
      ),
    );
  }
}
