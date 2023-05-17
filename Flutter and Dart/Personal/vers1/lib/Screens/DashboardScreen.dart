import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/dashboard_progress_widget.dart';
import '../widgets/dashboard_card_Widget.dart';
import '../provider/login_provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = 'dashboard-screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isExapnnded = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Done With It',
          style: textTheme.headlineSmall!.copyWith(fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor:
            _isExapnnded ? Colors.transparent : Colors.black.withOpacity(0.3),
        leading: IconButton(
            onPressed: () {
              setState(() {
                _isExapnnded = !_isExapnnded;
              });
            },
            icon: Icon(
              Icons.menu,
              size: 29,
            )),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10, bottom: 8, top: 8),
            child: Image.asset('lib/assets/images/avatar.png'),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            // child: Image.asset(
            //   'lib/assets/images/background.png',
            //   fit: BoxFit.cover,
            // ),
            color: colorScheme.primaryVariant,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: media.height * 0.1,
              ),
              DashBoardProgressWidget(),
              Text(
                'Momo Ketchup',
                style: textTheme.displaySmall!.copyWith(
                    color: Colors.black87,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: media.width * 0.6,
                height: media.height * 0.07,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(49)),
                  color: colorScheme.secondaryVariant,
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: media.width * 0.08,
                        height: media.height * 0.08,
                        child: Image.asset(
                          'lib/assets/images/logo/Tornado.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text('Typoon League')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Upcoming Tasks',
                  style: textTheme.displaySmall!.copyWith(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                  height: media.height * 0.2,
                  width: double.infinity,
                  child: DashboardCardWidget()),
              SizedBox(
                height: media.height * 0.04,
              )
            ],
          ),
          !_isExapnnded
              ? Container(
                  height: 10,
                  width: 10,
                  color: Colors.black.withOpacity(0.3),
                )
              : ClipRRect(
                  // borderRadius: const BorderRadius.only(
                  //   topLeft: Radius.circular(40),
                  //   bottomRight: Radius.circular(40),
                  // ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              // borderRadius: const BorderRadius.only(
                              //   topLeft: Radius.circular(40),
                              //   bottomRight: Radius.circular(40),
                              // ),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.13)),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(0.35)
                                  ])),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                                child: Container(
                              height: media.height * 0.5,
                              width: media.width * 0.75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isExapnnded = false;
                                      });
                                      print('hi');
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                        'Dashboard',
                                        style: textTheme.headlineSmall!
                                            .copyWith(fontSize: 22),
                                      )),
                                      height: media.height * 0.07,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black45),
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                        'Workplaces',
                                        style: textTheme.headlineSmall!
                                            .copyWith(fontSize: 22),
                                      )),
                                      height: media.height * 0.07,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black45),
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Provider.of<LoginProvider>(context,
                                              listen: false)
                                          .singout(context);
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                        'Sign Out',
                                        style: textTheme.headlineSmall!
                                            .copyWith(fontSize: 22),
                                      )),
                                      height: media.height * 0.07,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          border:
                                              Border.all(color: Colors.black45),
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
