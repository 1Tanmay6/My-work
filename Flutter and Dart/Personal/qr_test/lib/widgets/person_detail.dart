import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tickets.dart';
import '../models/ticket.dart';

class PersonDetails extends StatelessWidget {
  final String? name;
  final String? id;
  final String? email;
  final String? phoneNumber;
  final String? enrollmentNumber;
  final bool inHall;
  final bool isPreRegistered;
  final bool hasVipTicket;

  PersonDetails({
    required this.name,
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.inHall,
    required this.enrollmentNumber,
    required this.isPreRegistered,
    required this.hasVipTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Details'),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text('Name'),
              subtitle: Text(name as String),
            ),
            ListTile(
              title: Text('ID'),
              subtitle: Text(id as String),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(email as String),
            ),
            ListTile(
              title: Text('Phone Number'),
              subtitle: Text(phoneNumber as String),
            ),
            ListTile(
              title: Text('Enrollment Number'),
              subtitle: Text(enrollmentNumber as String),
            ),
            ListTile(
              title: Text('Has Entered'),
              trailing: Icon(
                hasVipTicket ? Icons.check_circle : Icons.cancel,
                color: hasVipTicket ? Colors.green : Colors.red,
              ),
            ),
            ListTile(
              title: Text('Pre-registration'),
              trailing: Icon(
                isPreRegistered ? Icons.check_circle : Icons.cancel,
                color: isPreRegistered ? Colors.green : Colors.red,
              ),
            ),
            ListTile(
              title: Text('VIP Ticket'),
              trailing: Icon(
                hasVipTicket ? Icons.check_circle : Icons.cancel,
                color: hasVipTicket ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              width: 50,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(30)))),
                  onPressed: () {
                    Ticket newTicket = Ticket(
                        id: id,
                        email: email,
                        enrollment: enrollmentNumber,
                        enteredHall: true,
                        name: name,
                        phoneNo: phoneNumber,
                        preRegestration: isPreRegistered,
                        vipTicket: hasVipTicket);
                    Provider.of<Tickets>(context, listen: false)
                        .updateTicket(id as String, newTicket, true);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              width: 50,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(30)))),
                  onPressed: () {
                    Ticket newTicket = Ticket(
                        id: id,
                        email: email,
                        enrollment: enrollmentNumber,
                        enteredHall: false,
                        name: name,
                        phoneNo: phoneNumber,
                        preRegestration: isPreRegistered,
                        vipTicket: hasVipTicket);
                    Provider.of<Tickets>(context, listen: false)
                        .updateTicket(id as String, newTicket, false);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
