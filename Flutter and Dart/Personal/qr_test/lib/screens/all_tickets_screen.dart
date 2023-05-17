import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/ticket.dart';
import '../providers/tickets.dart';
import '../widgets/ticket_item.dart';

class AllTicketsScreen extends StatefulWidget {
  static const routeName = '/allticketscreen';
  const AllTicketsScreen({super.key});

  @override
  State<AllTicketsScreen> createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Tickets>(context).fetchTickets();
      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Ticket> items = Provider.of<Tickets>(context, listen: false).items;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('All Tickets'),
        ),
        body: items.length == 0
            ? CircularProgressIndicator()
            : ListView.builder(
                itemBuilder: (context, index) => TicketItem(
                    name: items[index].name,
                    inHall: items[index].enteredHall,
                    ticket: items[index]),
                itemCount: items.length,
              ));
  }
}
