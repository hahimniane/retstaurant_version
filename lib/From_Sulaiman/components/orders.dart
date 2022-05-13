import 'package:flutter/material.dart';

import '../components/delivered_orders.dart';
import '../components/pending_orders.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    final _kTapPages = <Widget>[
      PenOrders(),
      const DelOrders(),
    ];
    final _kTabs = <Tab>[
      const Tab(icon: Icon(Icons.timelapse), text: 'Pending Orders'),
      const Tab(icon: Icon(Icons.car_rental), text: 'Delivered Orders'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Colors.pink,
          labelColor: Colors.pink,
          tabs: _kTabs,
        ),
        body: Center(
          child: TabBarView(
            children: _kTapPages,
          ),
        ),
      ),
    );
  }
}
