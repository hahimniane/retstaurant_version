import 'package:flutter/material.dart';
import 'package:restaurant_version/services/firbase.dart';

class AverageTimePage extends StatefulWidget {
  const AverageTimePage({Key? key}) : super(key: key);

  @override
  State<AverageTimePage> createState() => _AverageTimePageState();
}

class _AverageTimePageState extends State<AverageTimePage> {
  FirebaseAthentications service = FirebaseAthentications();

  Time price = Time.twentyMinute;
  var chosenTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Image.asset('images/pizza.png'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Choose Your Food Preparation averge time:',
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff030199),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '20 minutes',
                        style: TextStyle(
                          color: Color(0xff030199),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Color(0xff030199),
                        value: Time.twentyMinute,
                        groupValue: price,
                        onChanged: (Time? value) {
                          setState(() {
                            price = value!;
                            chosenTime = '20';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '30 minutes',
                        style: TextStyle(
                          color: Color(0xff030199),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Color(0xff030199),
                        value: Time.thirtyMinutes,
                        groupValue: price,
                        onChanged: (Time? value) {
                          setState(() {
                            price = value!;
                            chosenTime = '30';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '45 minutes',
                        style: TextStyle(
                          color: Color(0xff030199),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Color(0xff030199),
                        value: Time.fourtyFiveMinutes,
                        groupValue: price,
                        onChanged: (Time? value) {
                          setState(() {
                            price = value!;
                            chosenTime = '45';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '1 Hour',
                        style: TextStyle(
                          color: Color(0xff030199),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Color(0xff030199),
                        value: Time.oneHour,
                        groupValue: price,
                        onChanged: (Time? value) {
                          setState(() {
                            price = value!;
                            chosenTime = '60';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '1 Hour 30 minutes',
                        style: TextStyle(
                          color: Color(0xff030199),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Color(0xff030199),
                        value: Time.oneHourThirtyMinutes,
                        groupValue: price,
                        onChanged: (Time? value) {
                          setState(() {
                            price = value!;
                            chosenTime = '90';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      service.updateAverageRestaurantTime(
                          chosenTime.toString(), context);
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        margin: const EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            border: Border.all(
                                // Set border color
                                width: 3.0), // Set border width
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    20.0)), // Set rounded corner radius
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black,
                                  offset: Offset(1, 3))
                            ] // Make rounded corner of border
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Next ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.skip_next_outlined,
                              color: Colors.white,
                              size: 30,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    print(price);
  }
}

enum Time {
  twentyMinute,
  thirtyMinutes,
  fourtyFiveMinutes,
  oneHour,
  oneHourThirtyMinutes
}
