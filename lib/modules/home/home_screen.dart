import 'dart:async';
import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:gradua_project/modules/drawer/drawer_screen.dart';
import 'package:gradua_project/modules/sure/sure_screen.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/cubit/app_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path/path.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageC;
  bool hasInternet = false;
  late StreamSubscription internetSubscription;
  Widget fallBack = const Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    super.initState();
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasNet = status == InternetConnectionStatus.connected;
      setState(() {
        hasInternet = hasNet;
      });
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {
        fallBack = Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Failed To Fetch Data',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<AppCubit, AppStates>(
                listener: (context, stat) {},
                builder: (context, stat) {
                  return OutlinedButton(
                      onPressed: () {
                        setState(() {
                          AppCubit.get(context)
                            ..getPlants()
                            ..getUser()
                            ..getHistory();
                        });
                      },
                      child: const Text('Try again'));
                },
              )
            ],
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      imageC = imageTemporary;
    } on PlatformException catch (e) {
      print('error to pick image + $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          drawer: const drawerScreen(),
          appBar: AppBar(
            actions: [],
            backgroundColor: Colors.transparent,
            //leading: const Icon(Icons.menu),
            title: const Text('Home'),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    height: 180.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(20.0),
                            topStart: Radius.circular(20.0)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/beg.jpg'),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.black.withOpacity(.4),
                                Colors.black.withOpacity(.2),
                              ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'For the health of our plants',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 35.0,
                          ),
                          Container(
                              height: 40,
                              width: 190.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Center(
                                  child: Text(
                                "Choose your sick plant,",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
                              ))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! GetHomeLoadingState,
                      builder: (context) => GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.homeModel?.count,
                        itemBuilder: (context, index) {
                          return FocusedMenuHolder(
                            menuWidth: 185.0,
                            menuItems: [
                              FocusedMenuItem(
                                title: const Text('Camera'),
                                onPressed: () {
                                  pickImage(ImageSource.camera).then((value) {
                                    navigateTo(context, SureScreen(imageC));
                                  });
                                },
                                //trailingIcon: const Icon(Icons.camera_alt_outlined)
                              ),
                              FocusedMenuItem(
                                title: const Text('Gallery'),
                                onPressed: () {
                                  pickImage(ImageSource.gallery).then((value) {
                                    navigateTo(context, SureScreen(imageC));
                                  });
                                },
                                // trailingIcon: const Icon(Icons.browse_gallery_outlined)
                              ),
                            ],
                            openWithTap: true,
                            menuOffset: 10.0,
                            onPressed: () {},
                            child: buildGridViewItem(
                              context,
                              '${cubit.homeModel?.plants![index].plantImage}',
                              '${cubit.homeModel?.plants![index].name?.toUpperCase()}',
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0),
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => fallBack,
          ),
        );
      },
    );
  }
}
