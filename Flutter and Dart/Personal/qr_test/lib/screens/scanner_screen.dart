import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_test/providers/tickets.dart';
import 'package:qr_test/screens/all_tickets_screen.dart';
import 'package:qr_test/screens/details.dart';
import 'package:qr_test/screens/error.dart';

import '../providers/qr_code.dart';
import '../models/ticket.dart';

class ScannerScreen extends StatefulWidget {
  static const routeName = '/scanner-screen';

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String scanBarcode = 'Unknown';
  bool _isInit = true;
  bool valid = false;
  List<Ticket> tickets = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Tickets>(context).fetchTickets();
      print(tick);
      _isInit = false;
    }

    setState(() {
      tickets = Provider.of<Tickets>(context).items;
    });
    super.didChangeDependencies();
  }

  bool get tick {
    if (tickets.length != 0) {
      print(tickets);
      return false;
    }
    print(tickets);
    return true;
  }

  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) {
      return;
    }

    setState(() {
      scanBarcode = barcodeScanRes;
      print(
          '=====================================================================');
      print(scanBarcode);
      print(
          '=====================================================================');
      Provider.of<QrCode>(context, listen: false).setQrCode(scanBarcode);
    });

    var pointer = tickets.indexWhere((element) => element.id == scanBarcode);
    print(
        '=====================================================================');
    print(pointer);
    print(
        '=====================================================================');
    if (scanBarcode != '-1') {
      if (pointer >= 0) {
        Navigator.pushNamed(context, Details.routeName);
      } else {
        Navigator.pushNamed(context, ErrorScreen.routeName);
      }
    } else {
      Navigator.pushNamed(context, ScannerScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return tick
        ? Center(
            child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ))
        : Scaffold(
            extendBody: true,
            body: Container(
              color: Theme.of(context).focusColor,
              child: Center(
                child: Image.asset('lib/assets/images/main.jpg'),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).hintColor,
              child: FittedBox(
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                scanQR();
              },
            ),
            bottomNavigationBar: BottomAppBar(
              height: 60,
              shape: CircularNotchedRectangle(),
              color: Theme.of(context).hintColor,
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.all_inbox,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AllTicketsScreen.routeName);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.person_2_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Details.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Stack(children: <Widget>[
  //     Center(
  //       child: SizedBox(
  //         height: 80.0,
  //         width: 80.0,
  //         child: ElevatedButton(
  //           style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all(Colors.white),
  //               shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(40.0),
  //               )),
  //               elevation: MaterialStateProperty.all(4.0)),
  //           onPressed: () {
  //             scanQR();
  //           },
  //           child: Icon(
  //             Icons.qr_code_scanner_rounded,
  //             size: 50.0,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ),
  //     ),
  //     Positioned(
  //       bottom: 20,
  //       left: 0,
  //       right: 0,
  //       child: Text('Scan result : $scanBarcode\n',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             fontSize: 20.0,
  //             color: Colors.black,
  //           )),
  //     ),
  //     Positioned(
  //       bottom: 150,
  //       left: MediaQuery.of(context).size.width * 0.35,
  //       child: Row(
  //         children: [
  //           Container(
  //             // width: 150,
  //             child: ElevatedButton.icon(
  //               style: ButtonStyle(
  //                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(15))),
  //                   backgroundColor: MaterialStateProperty.all(Colors.white)),
  //               label: Text(
  //                 'All tickets',
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               onPressed: () {
  //                 // print(scanBarcode);

  //                 Navigator.pushNamed(context, AllTicketsScreen.routeName);
  //               },
  //               icon: Icon(
  //                 Icons.keyboard_arrow_right_rounded,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     Positioned(
  //       bottom: 80,
  //       left: MediaQuery.of(context).size.width * 0.35,
  //       child: Row(
  //         children: [
  //           Container(
  //             // width: 150,
  //             child: ElevatedButton.icon(
  //               style: ButtonStyle(
  //                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(15))),
  //                   backgroundColor: MaterialStateProperty.all(Colors.white)),
  //               label: Text(
  //                 'Details',
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               onPressed: () {
  //                 Navigator.pushNamed(context, Details.routeName);
  //               },
  //               icon: Icon(
  //                 Icons.keyboard_arrow_right_rounded,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ]));
  // }
}
