import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/modules/analysis/analysis_screen.dart';
import 'package:gradua_project/shared/components/components.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/cubit/app_states.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tflite/tflite.dart';

import '../drawer/drawer_screen.dart';

File? image;

class SureScreen extends StatefulWidget {
  SureScreen(File? imageV) {
    image = imageV;
  }

  @override
  State<SureScreen> createState() => _SureScreenState();
}

class _SureScreenState extends State<SureScreen> {
  List? output;
  bool? _loading = false;

  void initState() {
    super.initState();
    _loading = true;
    LoadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  LoadModel() async {
    await Tflite.loadModel(
      model: "assets/output.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() async {
    await Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          classifyImage(File? image) async {
            var outp = await Tflite.runModelOnImage(
              path: image!.path,
              imageMean: 0.0,
              imageStd: 255.0,
              numResults: 14,
              threshold: 0.2,
            );
            setState(() {
              output = outp;
              _loading = false;
              navigateTo(context, AnalysisScreen(output, image));
            });
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Confirm'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      'Your Selected Photo',
                      style: TextStyle(
                        color: Color(0xFF3f414e),
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    image != null
                        ? Image.file(
                            image!,
                            width: 280.0,
                            height: 300.0,
                          )
                        : const Center(child: Text('No Image Selected :(')),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: 240.0,
                      height: 40.0,
                      color: Color(0xFF3eb489),
                      child: ElevatedButton(
                          onPressed: () {
                            classifyImage(image);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.search,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 18.0,
                              ),
                              Text(
                                'Analysis it',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
