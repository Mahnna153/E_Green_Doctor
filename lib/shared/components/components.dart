import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradua_project/models/get_history_model.dart';
import 'package:gradua_project/modules/details/details_screen.dart';
import 'package:gradua_project/shared/components/constants.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/cubit/app_states.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import '../styles/colors.dart';

Widget defButton({
  var bgColor = defColor,
  double width = double.infinity,
  bool isUpper = true,
  double radius = 5.0,
  required String text,
  required Function function,
  double height = 40.0,
  bool hide = false,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
    );

Widget defFormField({
  required context,
  required TextEditingController? controller,
  required String label,
  required IconData? prefix,
  String? initialValue,
  TextInputType? keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  bool enabled = true,
  IconData? suffix,
  suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textCapitalization: TextCapitalization.words,
      textAlignVertical: TextAlignVertical.center,
      //style: Theme.of(context).textTheme.bodyText1,
      initialValue: initialValue,
      //textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        label: Text(
          label,
        ),
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
      ),
    );

Widget defAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(title ?? ''),
      titleSpacing: 5.0,
      actions: actions,
    );

Widget divider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 40.0),
      child: Container(
        height: 1.0,
        color: Colors.white.withOpacity(0.2),
      ),
    );

Widget divider2() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0),
      child: Container(
        height: 1.0,
        color: Colors.grey.withOpacity(0.4),
      ),
    );

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndKill(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void showToast({required String msg, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildNotFoundItem() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Plant not disease',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 100.0,
        ),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('assets/images/res.png'),
                width: 200.0,
                height: 200.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'E-green doctor focus on disease plant only',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFf61625)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAnalysisItem(List output, File? image) {
  return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        String type =
            image!.path.substring(image.path.length - 3, image.path.length);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Image(
                        image: AssetImage('assets/images/doc.jpg'),
                        width: 130.0,
                        height: 230.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage('assets/images/check.jpg'),
                              width: 30.0,
                              height: 30.0,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'Identified ',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //${output[0]['confidence']}
                          Text(
                            '${output[0]['label']}',
                            style: const TextStyle(
                              color: Color(0xFF719552),
                              fontSize: 25.0,
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          const Icon(
                            Icons.done_all,
                            color: Color(0xFF719552),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                '${output[0]['label']}'.contains('Healthy') ||
                        '${output[0]['label']}'.contains('healthy')
                    ? Text(
                        '${details['${output[0]['label']}_B']}',
                        maxLines: 8,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color(0xFFa1a4b2),
                          fontSize: 20.0,
                        ),
                      )
                    : Column(
                        children: [
                          Text(
                            '${details['${output[0]['label']}_B']}',
                            maxLines: 8,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xFFa1a4b2),
                              fontSize: 20.5,
                            ),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // if('${output[0]['label']}'.contains('Healthy'))
                              const Text(
                                'Treatment',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                child: Text(
                                  '${details['${output[0]['label']}_T']}',
                                  maxLines: 20,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.teal,
                                    fontSize: 20.0,
                                    wordSpacing: 3.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              defButton(
                                  text: 'Add To History',
                                  function: () {
                                    print(type);
                                    cubit.addHistory(
                                      diseasePhoto: image,
                                      diseaseName: '${output[0]['label']}',
                                      diseaseDescription:
                                          '${details['${output[0]['label']}_B']}',
                                      diseaseCure:
                                          '${details['${output[0]['label']}_T']}',
                                    );
                                  })
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      });
}

Widget buildRecommended(url, name) {
  return Column(
    children: [
      Image(
        image: AssetImage(url),
        width: 40.0,
        height: 50.0,
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        '$name',
        maxLines: 1,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Color(0xFF27554e),
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
        ),
      )
    ],
  );
}

Widget buildGridViewItem(BuildContext context, imageUrl, name) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          //assets/images/apple-fruit_1.jpg
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 3.5, top: 3.5),
          color: Colors.black.withOpacity(0.7),
          width: double.infinity,
          child: Text(
            '$name',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ],
    ),
  );
}

Widget historyItem(context, var model, int index) {
  return InkWell(
    onTap: () {
      int? num = index;
      navigateTo(
          context,
          DetailsScreen(
            index: index,
          ));
    },
    child: Container(
      height: 180,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                Image(
                  image: NetworkImage('${model!.diseasePhoto}'),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.diseaseName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${model.diseaseDesciption}',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                model.date.toString().substring(0, 25),
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(
                Icons.delete_outline_outlined,
                color: Colors.redAccent,
              ),
              TextButton(
                  onPressed: () {
                    AppCubit.get(context).deleteHistoryItem(id: model!.sId);
                  },
                  child: const Text('Remove',
                      style: TextStyle(
                        color: Colors.grey,
                      ))),
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildDetailsItem(context, History model) {
  return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Image(
                        image: NetworkImage('${model.diseasePhoto}'),
                        width: 240.0,
                        height: 300.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${model.diseaseName}',
                            style: const TextStyle(
                              color: Color(0xFF719552),
                              fontSize: 25.0,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Icon(
                            Icons.done_all,
                            color: Color(0xFF719552),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${model.diseaseDesciption}',
                      maxLines: 8,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFFa1a4b2),
                        fontSize: 20.5,
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // if('${output[0]['label']}'.contains('Healthy'))
                        const Text(
                          'Treatment',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: Text(
                            '${model.diseaseCure}',
                            maxLines: 20,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.teal,
                              fontSize: 20.0,
                              wordSpacing: 3.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
