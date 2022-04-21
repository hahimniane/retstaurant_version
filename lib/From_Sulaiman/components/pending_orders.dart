import 'package:flutter/material.dart';

class PenOrders extends StatelessWidget {
  const PenOrders({
    Key? key,
  }) : super(key: key);
  buildCard(Icon icon, String title, String subtitle, String trailing) {
    return Card(
      child: TextButton(
        onPressed: () {},
        child: ListTile(
          leading: icon,
          title: Text('$title'),
          subtitle: Text('$subtitle'),
          trailing: Text('$trailing'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      primary: false,
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5),
      children: [
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '200', '03/29/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '2400', '03/28/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '2500', '03/27/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '2200', '03/26/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '2100', '03/25/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '2400', '03/25/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '1200', '03/24/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '3200', '03/23/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '3400', '03/22/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '5600', '03/21/2022'),
        buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
            '1000', '03/20/2022'),
      ],
    );
  }
}
