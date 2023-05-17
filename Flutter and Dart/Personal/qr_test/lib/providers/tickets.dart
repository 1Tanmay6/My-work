import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/ticket.dart';
import '../models/http_exception.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _items = [];
  List<Ticket> get items {
    return [..._items];
  }

  Future<void> updateTicket(String id, Ticket newTicket, bool inHall) async {
    final prodIndex = _items.indexWhere((prod) {
      return prod.id == id;
    });
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://tedxniit23-default-rtdb.firebaseio.com/tickets/$id.json');
      await http.patch(url,
          body: json.encode({
            'EnteredHall': inHall,
          }));
      _items[prodIndex] = newTicket;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> fetchTickets([bool filterbyuser = false]) async {
    final url = Uri.parse(
        'https://tedxniit23-default-rtdb.firebaseio.com/tickets.json');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final List<Ticket> loadedTicket = [];
    extractedData.forEach((tickID, tickData) {
      loadedTicket.add(Ticket(
        id: tickID.toString(),
        email: tickData['EmailID'],
        enrollment: tickData['EnrolNo'],
        enteredHall: tickData['EnteredHall'],
        name: tickData['FullName'],
        phoneNo: tickData['PhoneNo'].toString(),
        preRegestration: tickData['PreRegistration'],
        vipTicket: tickData['VIPTicket'],
      ));
    });
    _items = loadedTicket;
    print(response.body);
    notifyListeners();
  }
}
