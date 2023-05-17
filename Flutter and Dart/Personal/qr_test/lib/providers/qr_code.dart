import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QrCode with ChangeNotifier {
  String _qr = 'Unknown';

  void setQrCode(String qr) {
    _qr = qr;
    notifyListeners();
  }

  String get qr {
    return _qr;
  }
}
