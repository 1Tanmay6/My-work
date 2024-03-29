import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/image_input.dart';
import '../providers/great_places.dart';
import '../widget/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File? pickedImage) {
    print(pickedImage);
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    // print(_pickedImage);
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageImput(onSelectImage: _selectImage),
                  SizedBox(
                    height: 10,
                  ),
                  LocationImput(),
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
            onPressed: _savePlace,
            label: Text('Add Place'),
            icon: Icon(Icons.add),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).accentColor),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
