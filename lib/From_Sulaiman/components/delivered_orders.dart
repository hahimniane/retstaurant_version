import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          crossAxisSpacing: 5),
      children: [
        // StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance
        //       .collection('Restaurants')
        //       .doc(FirebaseAuth.instance.currentUser!.uid)
        //       .collection('Pending Orders')
        //       .snapshots(),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return const Text('Something went wrong');
        //     }
        //
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Text("Loading");
        //     }
        //     if (!snapshot.hasData) {
        //       return const Center(
        //           child: SizedBox(
        //               height: 50,
        //               width: 50,
        //               child: CircularProgressIndicator()));
        //     }
        //     return GridView(
        //       primary: false,
        //       padding: const EdgeInsets.all(20),
        //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 1,
        //           childAspectRatio: 3,
        //           mainAxisSpacing: 10,
        //           crossAxisSpacing: 5),
        //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //         Map<String, dynamic> data =
        //             document.data()! as Map<String, dynamic>;
        //         return Card(
        //           child: GestureDetector(
        //             onLongPress: () {
        //               print('card was long pressed');
        //             },
        //             child: Row(
        //               children: [
        //                 Expanded(
        //                   flex: 6,
        //                   child: ListTile(
        //                       leading: Image(
        //                           image: NetworkImage(data['image link'])),
        //                       title: Text(data['food name']),
        //                       subtitle: Text(data['description']),
        //                       trailing: Text(' ${data['food price']} GNF')),
        //                 ),
        //                 Expanded(
        //                     flex: 1,
        //                     child: GestureDetector(
        //                       onTap: () {
        //                         print('the edit button was pressed');
        //                       },
        //                       child: const Icon(
        //                         Icons.edit,
        //                         size: 15,
        //                       ),
        //                     ))
        //               ],
        //             ),
        //           ),
        //         );
        //       }).toList(),
        //     );
        //     return ListView(
        //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //         Map<String, dynamic> data =
        //             document.data()! as Map<String, dynamic>;
        //         return ListTile(
        //           title: Text(data['full_name']),
        //           subtitle: Text(data['company']),
        //         );
        //       }).toList(),
        //     );
        //   },
        // ),
        Card(
          child: TextButton(
            onPressed: () {},
            child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.pink,
                ),
                title: Text('Orders'),
                subtitle: Text('1000'),
                trailing: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: () {},
            child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.pink,
                ),
                title: Text('Orders'),
                subtitle: Text('1000'),
                trailing: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: () {},
            child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.pink,
                ),
                title: Text('Orders'),
                subtitle: Text('1000'),
                trailing: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: () {},
            child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.pink,
                ),
                title: Text('Orders'),
                subtitle: Text('1000'),
                trailing: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: () {},
            child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.pink,
                ),
                title: Text('Orders'),
                subtitle: Text('1000'),
                trailing: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: () {},
            child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.pink,
                ),
                title: Text('Orders'),
                subtitle: Text('1000'),
                trailing: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: () {},
            child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.pink,
                ),
                title: Text('Orders'),
                subtitle: Text('1000'),
                trailing: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )),
          ),
        ),
        Card(
          child: TextButton(
            onPressed: () {},
            child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.pink,
                ),
                title: Text('Sulaiman A.Barry'),
                subtitle: Text('1000'),
                trailing: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )),
          ),
        ),
      ],
    );
  }
}
