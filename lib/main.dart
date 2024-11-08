import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradua_project/modules/home/home_screen.dart';
import 'package:gradua_project/modules/login/login.dart';
import 'package:gradua_project/modules/on_boarding/on_boarding.dart';
import 'package:gradua_project/shared/bloc_observer.dart';
import 'package:gradua_project/shared/components/constants.dart';
import 'package:gradua_project/shared/cubit/app_cubit.dart';
import 'package:gradua_project/shared/network/local/cache_helper.dart';
import 'package:gradua_project/shared/network/remote/dio_helper.dart';
import 'package:gradua_project/shared/styles/colors.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    DioHelper.init();
    await CacheHelper.init();

    bool? onBoarding = CacheHelper.getData('onBoarding');
    token = CacheHelper.getData('token');

    Widget? wid;

    print(onBoarding);
    print(token);

    if (onBoarding != null) {
      if (token != null) {
        wid = HomeScreen();
      } else {
        wid = LogInScreen();
      }
    } else {
      wid = const OnBoardingScreen();
    }

    runApp(MyApp(
      myStart: wid,
    ));
}

class MyApp extends StatelessWidget {
  Widget? myStart;

  MyApp({this.myStart});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..getPlants()
              ..getUser()
              ..getHistory())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Green Doctor',
        theme: ThemeData(
          primarySwatch: buildMaterialColor(defColor),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleSpacing: 20.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
        home: AnimatedSplashScreen(
          splash: 'assets/images/logo_1.png',
          backgroundColor: Colors.white,
          duration: 6,
          nextScreen: myStart!,
        ),
      ),
    );
  }
}
//myStart
