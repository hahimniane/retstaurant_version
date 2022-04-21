import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GridView(
      primary: false,
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5),
      children: [
        Card(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text('Orders'),
              ),
              Row(
                children: const [
                  Expanded(
                    child: ListTile(
                      leading: Icon(
                        Icons.timelapse,
                        size: 30,
                        color: Colors.pink,
                      ),
                      title: Text('Pending'),
                      subtitle: Text('1000'),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Icon(
                        Icons.car_rental_outlined,
                        size: 30,
                        color: Colors.pink,
                      ),
                      title: Text('Delivered'),
                      subtitle: Text('1000'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Card(
        //   child: Column(
        //     children: [
        //       const Padding(
        //         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        //         child: Text('Orders'),
        //       ),
        //       Row(
        //         children: const [
        //           Expanded(
        //             child: ListTile(
        //               leading: Icon(
        //                 Icons.timelapse,
        //                 size: 30,
        //                 color: Colors.pink,
        //               ),
        //               title: Text('Pending'),
        //               subtitle: Text('1000'),
        //             ),
        //           ),
        //           // Expanded(
        //           //   child: ListTile(
        //           //     leading: Icon(
        //           //       Icons.car_rental_outlined,
        //           //       size: 30,
        //           //       color: Colors.pink,
        //           //     ),
        //           //     title: Text('Delivered'),
        //           //     subtitle: Text('1000'),
        //           //   ),
        //           // ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ));
  }
}
