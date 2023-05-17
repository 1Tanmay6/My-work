import 'dart:math';

import 'package:flutter/material.dart';

import '../models/ticket.dart';

class TicketItem extends StatefulWidget {
  final String? name;
  final bool inHall;
  final Ticket ticket;
  const TicketItem({
    required this.name,
    required this.inHall,
    required this.ticket,
  });

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.inHall ? Colors.lightGreen.shade200 : Colors.red.shade100,
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${widget.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).focusColor,
              ),
            ),
            subtitle: Text(
              'Has Entered Hall: ${widget.inHall ? "Yes" : "No"}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).focusColor,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                color: Theme.of(context).focusColor,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(seconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? 140 : 0,
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    'ID: ${widget.ticket.id}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Email ID: ${widget.ticket.email}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Enrollment Number: ${widget.ticket.enrollment}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Phone Number: ${widget.ticket.phoneNo}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Pre-Registration: ${widget.ticket.preRegestration}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'VIPTicket: ${widget.ticket.vipTicket}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
              ),
            )
        ],
      ),
    );
  }
}
