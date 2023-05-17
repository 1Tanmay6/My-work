import 'package:flutter/material.dart';
import 'package:meals_application/Screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListtile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 22,
            fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.keyboard_arrow_right_outlined),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.175,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.lightGreenAccent[700],
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListtile('Meals', Icons.restaurant_menu_outlined, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListtile('Filters', Icons.settings_sharp, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          }),
        ],
      ),
    );
  }
}
