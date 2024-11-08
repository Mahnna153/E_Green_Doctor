import 'package:flutter/material.dart';
import 'package:gradua_project/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login.dart';

class BoardingModel {
  late String image;
  late String text1;
  late String text2;

  BoardingModel(
      {required this.image, required this.text1, required this.text2});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  bool isLast = false;

  List<BoardingModel> list = [
    BoardingModel(
        image: 'assets/images/analysis.jpg',
        text1: 'Immediate Detection Of Disease',
        text2:
            'Identify and better understand all kinds of specific plants diseases living in nature '),
    BoardingModel(
        image: 'assets/images/advice.png',
        text1: 'Advice For The Best Treatment Methods',
        text2: 'Just take a photo of the plant you get the solution for it '),
    BoardingModel(
        image: 'assets/images/dot.jpg',
        text1: 'Recommendation For The Best Treatment Products',
        text2:
            'After your plant instantly recognized you get the product that you must use it for the treatment'),
  ];
  void onSubmit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndKill(context, LogInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                onSubmit();
              },
              child: const Text(
                'SKIP',
                style: TextStyle(color: defColor, letterSpacing: 1),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) => buildBoardingItem(list[index]),
                itemCount: list.length,
                onPageChanged: (int index) {
                  if (index == list.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: list.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defColor,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defColor,
                  child:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: () {
                    if (isLast) {
                      onSubmit();
                    } else {
                      pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.easeInOutCubicEmphasized,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 280,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  //spreadRadius: 5.0,
                  blurRadius: 3.0,
                  offset: Offset(10.0, 10.0),
                ),
              ],
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              image: AssetImage('${model.image}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(),
        Text(
          '${model.text1}',
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Expanded(
          child: Text(
            '${model.text2}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
      ],
    );
