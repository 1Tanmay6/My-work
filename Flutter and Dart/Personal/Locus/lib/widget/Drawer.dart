import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'fetch.dart';
import '../Screens/location_page.dart';
import '../Screens/login.dart';

class DrawerWid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: media.size.height * 0.7,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.only(
                      // bottomLeft: Radius.circular(50),
                      // bottomRight: Radius.circular(50),
                      ),
                  color: Color(0xFF38ac65),
                ),
                child: const Center(
                  child: Text(
                    'Options',
                    style: const TextStyle(color: Colors.black, fontSize: 28),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.location_pin,
                  color: Colors.black,
                ),
                title: const Text(
                  'Fetch Location',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, LocationPage.routeName);
                },
              ),
              ListTile(
                leading: Image.asset(
                  'lib/assests/images/tree.png',
                  height: 24,
                ),
                title: const Text(
                  'Your Trees',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF363635)),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, Fetch.routeName);
                },
              ),
            ],
          ),
        ),
        Container(
          height: media.size.height * 0.15,
          width: media.size.width * 0.4,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: RoundedLoadingButton(
                color: Theme.of(context).accentColor,
                controller: buttonController,
                valueColor: Theme.of(context).secondaryHeaderColor,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Login.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.power_settings_new_sharp,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    Text(
                      'Log Out',
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                )),
          ),
        ),
      ]),
    );
  }

  RoundedLoadingButtonController buttonController =
      new RoundedLoadingButtonController();
}
