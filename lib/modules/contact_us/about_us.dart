import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:gradua_project/models/team_member.dart';
import 'package:gradua_project/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/material.dart';
import 'package:gradua_project/modules/sure/sure_screen.dart';

import '../../shared/styles/colors.dart';
import '../drawer/drawer_screen.dart';

class AboutUsPage extends StatefulWidget {
  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  var _scrollController = ScrollController();

  List<TeamMember> listTeam = [
    TeamMember(
        image: 'assets/images/team/abdu.jpg',
        name: 'Abdallah Mahnna',
        dep: 'Flutter Team Member',
        gitHup: 'https://github.com/Mahnna153'),
    TeamMember(
        image: 'assets/images/team/ftyan.jpeg',
        name: 'Ftyan Anas',
        dep: 'Flutter Team Member',
        gitHup: 'https://github.com/fetian-debug'),
    TeamMember(
        image: 'assets/images/team/mostafa.jpg',
        name: 'Mostafa Alaa',
        dep: 'Flutter Team Member',
        gitHup: 'https://github.com/Mostafa-Bkry'),
  ];

  // animateToMaxMin(double max, double min, double direction, int seconds,
  //     ScrollController scrollController) {
  //   scrollController
  //       .animateTo(direction,
  //           duration: Duration(seconds: seconds), curve: Curves.linear)
  //       .then((value) {
  //     direction = direction == max ? min : max;
  //     animateToMaxMin(max, min, direction, seconds, scrollController);
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  //     double minScrollExtent1 = _scrollController.position.minScrollExtent;
  //     double maxScrollExtent1 = _scrollController.position.maxScrollExtent;
  //     //
  //     animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 10,
  //         _scrollController);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 165.0,
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
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Our Team Members',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // width: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ]),
                      ),
                      // color: defColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Flutter Team',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 10.0, end: 10.0),
                              child: Container(
                                height: 2.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    '${listTeam[0].image}',
                                    fit: BoxFit.cover,
                                    width: 105,
                                    height: 160,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Container(
                                  width: 215,
                                  height: 165,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${listTeam[0].name}',
                                        style: const TextStyle(
                                            fontSize: 23.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Text(
                                        '🔭 I’m currently working on Bachelor of Software Engineering \n\n 🌱 I’m Mobile App Developer :) ',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black54),
                                      ),
                                      Spacer(),
                                      Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('${listTeam[0].gitHup}'),
                                        builder: (context, followLink) =>
                                            GestureDetector(
                                                onTap: followLink,
                                                child: const Text(
                                                  'GitHup',
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            divider(),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    '${listTeam[1].image}',
                                    fit: BoxFit.cover,
                                    width: 105,
                                    height: 160,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Container(
                                  width: 215,
                                  height: 165,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${listTeam[1].name}',
                                        style: const TextStyle(
                                            fontSize: 23.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Text(
                                        '🔭 I’m currently working on Bachelor of Software Engineering \n\n 🌱 I’m learning Web developer. ',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black54),
                                      ),
                                      Spacer(),
                                      Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('${listTeam[1].gitHup}'),
                                        builder: (context, followLink) =>
                                            GestureDetector(
                                                onTap: followLink,
                                                child: const Text(
                                                  'GitHup',
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            divider(),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    '${listTeam[2].image}',
                                    fit: BoxFit.cover,
                                    width: 105,
                                    height: 160,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Container(
                                  width: 215,
                                  height: 165,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${listTeam[2].name}',
                                        style: const TextStyle(
                                            fontSize: 23.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Text(
                                        '🔭 I’m currently working on Bachelor of Software Engineering \n\n 🌱 I’m currently learning mobile app developer. ',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black54),
                                      ),
                                      Spacer(),
                                      Link(
                                        target: LinkTarget.blank,
                                        uri: Uri.parse('${listTeam[2].gitHup}'),
                                        builder: (context, followLink) =>
                                            GestureDetector(
                                                onTap: followLink,
                                                child: const Text(
                                                  'GitHup',
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   width: 370.0,
              //   height: 540.0,
              //   child: ListView.separated(
              //       controller: _scrollController,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) =>
              //           buildTeamMemberItem(listTeam[index]),
              //       separatorBuilder: (context, index) => const SizedBox(
              //             width: 15.0,
              //           ),
              //       itemCount: listTeam.length),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTeamMemberItem(TeamMember member) => Card(
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                '${member.image}',
                fit: BoxFit.cover,
                height: 430.0,
                width: 350.0,
                // fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                '${member.name}',
                style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                '${member.dep}',
                style: TextStyle(fontSize: 17.0),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Link(
                target: LinkTarget.blank,
                uri: Uri.parse('${member.gitHup}'),
                builder: (context, followLink) => GestureDetector(
                    onTap: followLink,
                    child: const Text(
                      'GitHup',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    )),
              )
            ],
          ),
        ),
      );
}
