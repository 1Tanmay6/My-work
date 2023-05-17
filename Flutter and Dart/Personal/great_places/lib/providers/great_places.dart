import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File? pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: PlaceLocation(latitude: 0.0, longitude: 0.0, address: ''),
        image: pickedImage);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id as Object,
      'title': newPlace.title as Object,
      'image': newPlace.image!.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final datalist = await DBHelper.getData('user_places');
    _items = datalist
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(latitude: 0.0, longitude: 0.0, address: ''),
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }
}
