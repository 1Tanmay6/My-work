import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../providers/tickets.dart';
import '../screens/scanner_screen.dart';
import '../providers/qr_code.dart';
import '../models/ticket.dart';
import '../widgets/person_detail.dart';

class Details extends StatefulWidget {
  static const routeName = '/details';
  String qr;
  Details({this.qr = 'Unknown'});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void didChangeDependencies() {
    ticketFounder(context);
    super.didChangeDependencies();
  }

  late Ticket idTick = Ticket(
      id: 'id',
      email: 'email',
      enrollment: 'enrollment',
      enteredHall: false,
      name: 'name',
      phoneNo: 'phoneNo',
      preRegestration: false,
      vipTicket: false);

  void ticketFounder(BuildContext context) {
    String code = Provider.of<QrCode>(context, listen: false).qr;
    List<Ticket> tickets =
        Provider.of<Tickets>(context, listen: false).items as List<Ticket>;

    for (int i = 0; i < tickets.length; i++) {
      if (tickets[i].id.toString() == code.toString()) {
        Ticket newTicket = Ticket(
            id: tickets[i].id,
            email: tickets[i].email,
            enrollment: tickets[i].enrollment,
            enteredHall: true,
            name: tickets[i].name,
            phoneNo: tickets[i].phoneNo,
            preRegestration: tickets[i].preRegestration,
            vipTicket: tickets[i].vipTicket);
        setState(() {
          idTick = tickets[i];
        });

        print(tickets[i].name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PersonDetails(
      name: idTick.name,
      id: idTick.id,
      email: idTick.email,
      phoneNumber: idTick.phoneNo,
      enrollmentNumber: idTick.enrollment,
      isPreRegistered: idTick.preRegestration,
      hasVipTicket: idTick.vipTicket,
      inHall: idTick.enteredHall,
    );
  }
}
