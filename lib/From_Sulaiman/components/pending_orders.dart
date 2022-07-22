import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PenOrders extends StatelessWidget {
  final _usersStream = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Pending Orders');

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  PenOrders({
    Key? key,
  }) : super(key: key);
  buildCard(Widget imageUrl, String title, StreamBuilder subtitle,
      StreamBuilder trailing,
      {required VoidCallback whenYouTapp}) {
    return Card(
      child: TextButton(
        onPressed: whenYouTapp,
        child: ListTile(
            leading: imageUrl,
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
      stream: _usersStream.snapshots(),
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
              FutureBuilder<DocumentSnapshot>(
                future: snapshot.data!.docs[i].reference
                    .collection('Order')
                    .doc('1')
                    .get(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  }
                  return Image.network(snapshot.data['image link']);
                },
              ),
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
              whenYouTapp: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: StreamBuilder<DocumentSnapshot>(
                                        stream: snapshot.data!.docs[i].reference
                                            .snapshots(),
                                        builder: (context, snapshot1) {
                                          if (!snapshot1.hasData) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return TextButton(
                                              style: TextButton.styleFrom(
                                                  elevation: 4,
                                                  backgroundColor:
                                                      Colors.green.shade500),
                                              onPressed: () async {
                                                if (snapshot1
                                                        .data!['bike called'] ==
                                                    '1') {
                                                  await Fluttertoast.showToast(
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          backgroundColor:
                                                              Colors.green,
                                                          msg:
                                                              'the bike is already on its way')
                                                      .then((value) => {
                                                            // Navigator.pop(
                                                            //     context)
                                                          });
                                                } else {
                                                  snapshot
                                                      .data!.docs[i].reference
                                                      .update({
                                                    'call bike': false,
                                                    'bike called': '1',
                                                  }).then((value) async => {
                                                            await Fluttertoast.showToast(
                                                                    gravity:
                                                                        ToastGravity
                                                                            .CENTER,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    msg:
                                                                        'the bike  is already  on its way')
                                                                .then((value) =>
                                                                    {
                                                                      Navigator.pop(
                                                                          context)
                                                                    })
                                                          });
                                                }
                                              },
                                              child: snapshot1
                                                          .data!['call bike'] ==
                                                      false
                                                  ? const Text(
                                                      'Bike  is on its way',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : const Text(
                                                      'Call Bike for delivery',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ));
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          elevation: 4,
                                          backgroundColor: Colors.red),
                                      onPressed: () {},
                                      child: const Text(
                                        'Decline order',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Restaurants')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('Pending Orders')
                                    .doc(snapshot.data!.docs[i].reference.id)
                                    .collection('Order')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> lastSnapshot) {
                                  if (!lastSnapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }
                                  return ListView.builder(
                                    itemCount: lastSnapshot.data.docs.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var document =
                                          lastSnapshot.data.docs[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Card(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                      leading: const Text(
                                                          'Menu Name: '),
                                                      trailing: Text(
                                                          document['food name'])
                                                      // Image.network(
                                                      //     document['image link']),
                                                      ),
                                                  ListTile(
                                                      leading: const Text(
                                                          'amount of items: '),
                                                      trailing: Text(document[
                                                              'amount of items']
                                                          .toString())
                                                      // Image.network(
                                                      //     document['image link']),
                                                      ),
                                                  ListTile(
                                                      leading: const Text(
                                                          'Total Price: '),
                                                      trailing: Text((int.parse(
                                                                      document[
                                                                          'food price']) *
                                                                  document[
                                                                      'amount of items'])
                                                              .toString() +
                                                          ' GNF')
                                                      // Image.network(
                                                      //     document['image link']),
                                                      ),
                                                  ListTile(
                                                      leading: const Text(
                                                          'Ketchup: '),
                                                      trailing:
                                                          document['ketchup'] ==
                                                                  true
                                                              ? const Icon(
                                                                  Icons.done)
                                                              : const Icon(
                                                                  Icons.cancel)
                                                      // Image.network(
                                                      //     document['image link']),
                                                      ),
                                                  ListTile(
                                                      leading: const Text(
                                                          'Mayonnaise: '),
                                                      trailing: document[
                                                                  'mayonnaise'] ==
                                                              true
                                                          ? const Icon(
                                                              Icons.done)
                                                          : const Icon(
                                                              Icons.cancel)
                                                      // Image.network(
                                                      //     document['image link']),
                                                      ),

                                                  //   lastSnapshot.data[index
                                                  //       ? SizedBox(
                                                  //           height: 20,
                                                  //         )
                                                  //       : SizedBox(
                                                  //           height: 0,
                                                  //         )
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.black,
                                              thickness: 2,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    // children: lastSnapshot.data!.docs
                                    //     .map<Widget>(
                                    //         (DocumentSnapshot document) {
                                    //   Map<String, dynamic> data = document
                                    //       .data()! as Map<String, dynamic>;
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
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
