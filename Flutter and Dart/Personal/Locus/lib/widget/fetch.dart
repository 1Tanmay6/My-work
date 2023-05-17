import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../widget/firebase_fetcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/data.dart';

class Fetch extends StatefulWidget {
  static const routeName = '/fetcher';

  static String sorterid = '';
  static void idFetcher(String id) {
    sorterid = id;
  }

  @override
  State<Fetch> createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  static String? formatSheetDate(String? dateGot) {
    if (dateGot == null || dateGot == '') return null;
    final dateSome = DateTime.fromMillisecondsSinceEpoch(
        ((double.parse(dateGot) - 25569) * 86400000).toInt(),
        isUtc: true);
    var dateTime = DateTime.parse(dateSome.toString());

    var formatDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

    return formatDate;
  }

  static String? formatSheetTime(String? timeGot) {
    if (timeGot == null || timeGot == '') return null;
    final dateSome = DateTime.fromMillisecondsSinceEpoch(
        ((double.parse(timeGot) - 25569) * 86400000).toInt(),
        isUtc: true);
    var dateTime = DateTime.parse(dateSome.toString());

    var formattedTime = DateFormat('hh:mm a').format(dateTime);

    return formattedTime;
  }

  void _doSomething() async {}

  @override
  Widget build(BuildContext context) {
    return FireBaseFetcher(readUsers());
  }

  Stream<List<Data>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Data.fromJson(doc.data())).toList());
}
