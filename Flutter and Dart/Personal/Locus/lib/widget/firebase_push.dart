import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/fetch.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../models/data.dart';

class FirebasePush extends StatefulWidget {
  final String lat;
  final String long;
  final String address;
  final String? treeid;
  final bool idbool;

  FirebasePush(
      {required this.lat,
      required this.long,
      required this.address,
      required this.treeid,
      required this.idbool});

  @override
  State<FirebasePush> createState() => _FirebasePushState();
}

class _FirebasePushState extends State<FirebasePush> {
  Future createUser(Data data) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final json = data.toJson();
    await docUser.set(json);
  }

  bool isScuess = true;

  void beforeCreatingUser(RoundedLoadingButtonController controller) async {
    print('"${widget.idbool}"');
    // print(widget.treeid!.length);
    if ((widget.lat.toString() == 'null' || widget.lat.toString() == '') &&
        (widget.address.toString() == 'null' ||
            widget.address.toString() == '') &&
        (widget.long.toString() == 'null' || widget.long.toString() == '')) {
      setState(() {
        // ishow = true;
        isScuess = false;
      });
      Future.delayed(Duration(seconds: 1), () {
        controller.success();
        // controller.reset();
      });
    } else if (widget.idbool == false) {
      setState(() {
        // ishow = true;
        isScuess = false;
      });
      Future.delayed(Duration(seconds: 1), () {
        controller.success();
        // controller.reset();
      });
    } else {
      setState(() {
        // ishow = true;
        isScuess = true;
      });

      Future.delayed(Duration(seconds: 1), () {
        final data = Data(
            id: Fetch.sorterid,
            lat: widget.lat,
            long: widget.long,
            address: widget.address,
            treeid: widget.treeid);
        createUser(data);
        controller.success();
      });
    }

    Future.delayed(Duration(seconds: 2), () {
      controller.reset();
    });
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 100,
      child: RoundedLoadingButton(
        borderRadius: 30,
        color: Theme.of(context).accentColor,
        successIcon: isScuess ? Icons.task_alt_rounded : Icons.cancel_outlined,
        valueColor: Theme.of(context).secondaryHeaderColor,
        successColor: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.save_alt_rounded,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Save',
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor, fontSize: 15),
            ),
          ],
        ),
        controller: _btnController,
        onPressed: () {
          beforeCreatingUser(_btnController);
        },
      ),
    );
  }
}
