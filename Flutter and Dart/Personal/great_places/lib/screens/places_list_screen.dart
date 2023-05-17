import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Places'), actions: [
        IconButton(
            onPressed: (() {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            }),
            icon: Icon(Icons.add))
      ]),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(child: Text('No places yet')),
                builder: ((context, greatPlaces, child) =>
                    greatPlaces.items.length <= 0
                        ? child!
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, index) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                        greatPlaces.items[index].image as File),
                                  ),
                                  title: Text(
                                      greatPlaces.items[index].title as String),
                                  onTap: () {},
                                )))),
      ),
    );
    ;
  }
}
