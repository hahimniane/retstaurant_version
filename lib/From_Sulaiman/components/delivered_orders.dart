import 'package:flutter/material.dart';

class DelOrders extends StatelessWidget {
  const DelOrders({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      primary: false,
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5
      ) ,
      children: [
        Card(
          child: TextButton(
            onPressed: (){},
            child: const ListTile(
              leading: Icon(Icons.person,size: 40, color: Colors.pink,),
              title: Text('Orders'),
              subtitle: Text('1000'),
              trailing: Icon(Icons.check, size: 30, color: Colors.green,)
            ),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: (){},
            child: const ListTile(
              leading: Icon(Icons.person,size: 40, color: Colors.pink,),
              title: Text('Orders'),
              subtitle: Text('1000'),
              trailing: Icon(Icons.check, size: 30, color: Colors.green,)
            ),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: (){},
            child: const ListTile(
              leading: Icon(Icons.person,size: 40, color: Colors.pink,),
              title: Text('Orders'),
              subtitle: Text('1000'),
              trailing: Icon(Icons.check, size: 30, color: Colors.green,)
            ),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: (){},
            child: const ListTile(
              leading: Icon(Icons.person,size: 40, color: Colors.pink,),
              title: Text('Orders'),
              subtitle: Text('1000'),
              trailing: Icon(Icons.check, size: 30, color: Colors.green,)
            ),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: (){},
            child: const ListTile(
              leading: Icon(Icons.person,size: 40, color: Colors.pink,),
              title: Text('Orders'),
              subtitle: Text('1000'),
              trailing: Icon(Icons.check, size: 30, color: Colors.green,)
            ),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: (){},
            child: const ListTile(
              leading: Icon(Icons.person,size: 40, color: Colors.pink,),
              title: Text('Orders'),
              subtitle: Text('1000'),
              trailing: Icon(Icons.check, size: 30, color: Colors.green,)
            ),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: (){},
            child: const ListTile(
              leading: Icon(Icons.person,size: 40, color: Colors.pink,),
              title: Text('Orders'),
              subtitle: Text('1000'),
              trailing: Icon(Icons.check, size: 30, color: Colors.green,)
            ),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: (){},
            child: const ListTile(
              leading: Icon(Icons.person,size: 40, color: Colors.pink,),
              title: Text('Sulaiman A.Barry'),
              subtitle: Text('1000'),
              trailing: Icon(Icons.check, size: 30, color: Colors.green,)
            ),
          ),
        ),
      ],
    );
  }
}
