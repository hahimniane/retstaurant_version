import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PenOrders extends StatelessWidget {
  final _usersStream = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Pending Orders')
      .snapshots();

  PenOrders({
    Key? key,
  }) : super(key: key);
  buildCard(
      Icon icon, String title, StreamBuilder subtitle, StreamBuilder trailing) {
    return Card(
      child: TextButton(
        onPressed: () {
          print('hello world');
          // myFunction() {
          //   final a = FirebaseFirestore.instance
          //       .collection('Customers')
          //       .doc('Qbv3t2lsJNgQq9uFftTBNYiBbLq2')
          //       .collection('Orders')
          //       .get();
          //
          //   a.then(
          //     (value) => {
          //       // print(FirebaseAuth.instance.currentUser!.uid),
          //       if (value.docs.isNotEmpty)
          //         {
          //           for (int i = 0; i < value.size; ++i)
          //             {print(value.docs[i].id)}
          //         }
          //       else
          //         {
          //           print('it is empty'),
          //         }
          //     },
          //   );
          // }
          //
          // myFunction();
        },
        child: ListTile(
            leading: icon,
            title: Text('$title'),
            subtitle: subtitle,
            //   Text('$subtitle'),
            trailing: trailing),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var date;
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return GridView(
          primary: false,
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5),
          children: List.generate(
            snapshot.data!.docs.length,
            (i) => buildCard(
              const Icon(Icons.person, size: 40, color: Colors.pink),
              snapshot.data!.docs[i].id,
              StreamBuilder(
                stream: snapshot.data!.docs[i].reference
                    .collection('Orders')
                    .doc('total price and location')
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data['Total Price']);
                  }
                  return const CircularProgressIndicator();
                },
              ),
              StreamBuilder(
                stream: snapshot.data!.docs[i].reference
                    .collection('Orders')
                    .doc('total price and location')
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    DateTime dt =
                        (snapshot.data['Order Date'] as Timestamp).toDate();
                    return Text('${dt.day} / ' +
                        dt.month.toString() +
                        ' / ' +
                        dt.year.toString());
                  } else if (!snapshot.hasData) {
                    return Container(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    return const Text(''
                        'Error from the database Please try Again later');
                  }
                },
              ),
            ),
          ),
        );
      },
    );
    //   GridView(
    //   primary: false,
    //   padding: const EdgeInsets.all(20),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 1,
    //       childAspectRatio: 3,
    //       mainAxisSpacing: 10,
    //       crossAxisSpacing: 5),
    //   children: [
    //     // StreamBuilder<QuerySnapshot>(
    //     //   stream: _usersStream,
    //     //   builder:
    //     //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     //     if (snapshot.hasError) {
    //     //       return const Text('Something went wrong');
    //     //     }
    //     //
    //     //     if (snapshot.connectionState == ConnectionState.waiting) {
    //     //       return Center(child: const CircularProgressIndicator());
    //     //     }
    //     //     if (!snapshot.hasData) {
    //     //       return const Center(
    //     //           child: SizedBox(
    //     //               height: 50,
    //     //               width: 50,
    //     //               child: CircularProgressIndicator()));
    //     //     }
    //     //     return GridView(
    //     //       primary: false,
    //     //       padding: const EdgeInsets.all(20),
    //     //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     //           crossAxisCount: 1,
    //     //           childAspectRatio: 3,
    //     //           mainAxisSpacing: 10,
    //     //           crossAxisSpacing: 5),
    //     //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //     //         Map<String, dynamic> data =
    //     //             document.data()! as Map<String, dynamic>;
    //     //         return Card(
    //     //           child: GestureDetector(
    //     //             onLongPress: () {
    //     //               print('card was long pressed');
    //     //             },
    //     //             child: Row(
    //     //               children: [
    //     //                 Expanded(
    //     //                   flex: 6,
    //     //                   child: ListTile(
    //     //                       leading: Image(
    //     //                           image: NetworkImage(data['image link'])),
    //     //                       title: Text(data['food name']),
    //     //                       subtitle: Text(data['description']),
    //     //                       trailing: Text(' ${data['food price']} GNF')),
    //     //                 ),
    //     //                 Expanded(
    //     //                     flex: 1,
    //     //                     child: GestureDetector(
    //     //                       onTap: () {
    //     //                         print('the edit button was pressed');
    //     //                       },
    //     //                       child: const Icon(
    //     //                         Icons.edit,
    //     //                         size: 15,
    //     //                       ),
    //     //                     ))
    //     //               ],
    //     //             ),
    //     //           ),
    //     //         );
    //     //       }).toList(),
    //     //     );
    //     //     return ListView(
    //     //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //     //         Map<String, dynamic> data =
    //     //             document.data()! as Map<String, dynamic>;
    //     //         return ListTile(
    //     //           title: Text(data['full_name']),
    //     //           subtitle: Text(data['company']),
    //     //         );
    //     //       }).toList(),
    //     //     );
    //     //   },
    //     // ),
    //     buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //         '200', '03/29/2022'),
    //     buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //         '2400', '03/28/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '2500', '03/27/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '2200', '03/26/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '2100', '03/25/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '2400', '03/25/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '1200', '03/24/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '3200', '03/23/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '3400', '03/22/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '5600', '03/21/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '1000', '03/20/2022'),
    //     StreamBuilder<QuerySnapshot>(
    //         stream: FirebaseFirestore.instance
    //             .collection('Restaurants')
    //             .doc(FirebaseAuth.instance.currentUser!.uid)
    //             .collection('Pending Orders')
    //             .snapshots(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasError) {
    //             return Text('Something went wrong');
    //           }
    //
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return Text("Loading");
    //           }
    //
    //           return
    //         })
    //   ],
    // );
  }
}
