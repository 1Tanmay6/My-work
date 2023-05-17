import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../Screens/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/data.dart';
import '../widget/Drawer.dart';
import '../widget/firebase_push.dart';

class LocationPage extends StatefulWidget {
  static const routeName = '/location-page';

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  static String? _currentAddress;
  static Position? _currentPosition;

  final _treeidController = TextEditingController();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: const Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: const Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  String get latitude {
    var lat;
    setState(() {
      lat = _currentPosition?.latitude.toString();
    });

    if (lat == null) {
      return 'null';
    }

    return _currentPosition!.latitude.toString();
  }

  String get longitude {
    var long;
    setState(() {
      long = _currentPosition?.longitude.toString();
    });

    if (long == null) {
      return 'null';
    }

    return _currentPosition!.longitude.toString();
  }

  String get address {
    var add;
    setState(() {
      add = _currentAddress;
    });

    if (add == null) {
      return 'null';
    }

    return add;
  }

  String? treeID;
  bool idtrue = false;

  void _submit() {
    String? enteredTreeID = _treeidController.text;

    if (enteredTreeID.isEmpty) {
      setState(() {
        idtrue = false;
      });

      return;
    } else {
      setState(() {
        idtrue = true;
        treeID = _treeidController.text;
      });
    }

    enteredTreeID = null;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Location Page"),
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Colors.black,
      ),
      drawer: DrawerWid(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: media.size.width * 0.6,
                height: media.size.height * 0.04,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    'Latitude: ${latitude}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Text('Longitude: ${_currentPosition?.longitude ?? ""}'),
              Container(
                width: media.size.width * 0.6,
                height: media.size.height * 0.04,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    'Longitude: ${longitude}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: media.size.width * 0.6,
                  height: media.size.height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      'Address: ${_currentAddress}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: media.size.width * 0.6,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).accentColor,
                    prefixIcon: Icon(
                      Icons.ad_units_outlined,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Theme.of(context).backgroundColor,
                    ),
                    border: InputBorder.none,
                    hintText: 'Enter Tree ID',
                    hintStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  cursorColor: Theme.of(context).secondaryHeaderColor,
                  controller: _treeidController,
                  onSubmitted: ((_) => _submit()),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    // print(LocationPage.ishow);
                    _getCurrentPosition();
                  },
                  child: Container(
                    width: 170,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        Text(
                          "Get Current Location",
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ],
                    ),
                  )),
              firebasePusher()
              // GoogleSheetUpdater(lat: latitude, long: longitude, add: address)
            ],
          ),
        ),
      ),
    );
  }

  List<String> datalist = [];
  List<String> treeidRetriver() {
    Stream<List<Data>> data = readUsers();
    data.listen((listofData) {
      for (Data da in listofData) {
        datalist.add(da.treeid.toString());
      }
    });
    return datalist;
  }

  @override
  void initState() {
    treeidRetriver();
    setState(() {});
    super.initState();
  }

  bool checker() {
    for (String id in datalist) {
      if (datalist.contains(treeID)) {
        return (false);
      } else {
        return (true);
      }
    }
    return true;
  }

  Widget firebasePusher() {
    _submit();
    // print('idtrue: ${idtrue} & ispresent: ${checker()}');

    if (idtrue && checker()) {
      return FirebasePush(
        lat: latitude,
        long: longitude,
        address: address,
        treeid: treeID,
        idbool: idtrue,
      );
    } else {
      return FirebasePush(
        lat: latitude,
        long: longitude,
        address: address,
        treeid: treeID,
        idbool: false,
      );
    }
  }

  Stream<List<Data>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Data.fromJson(doc.data())).toList());

  @override
  void dispose() {
    _treeidController.dispose();
    super.dispose();
  }
}
