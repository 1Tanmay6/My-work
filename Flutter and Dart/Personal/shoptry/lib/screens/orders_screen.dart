import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_Item.dart' as oi;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order_screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _futureOrders;

  Future<void> _obtainFutureOrders() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _futureOrders = _obtainFutureOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else {
              if (snapshot.error != null) {
                return Center(child: Text('An error occured'));
              } else {
                return Consumer<Orders>(
                    builder: ((context, orderData, child) => ListView.builder(
                          itemBuilder: ((context, index) =>
                              oi.OrderItem(orderData.orders[index])),
                          itemCount: orderData.orders.length,
                        )));
              }
            }
          }),
          future: _futureOrders,
        ));
  }
}
