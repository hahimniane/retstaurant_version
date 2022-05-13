import 'package:flutter/material.dart';

class AveragePricePage extends StatefulWidget {
  const AveragePricePage({Key? key}) : super(key: key);

  @override
  State<AveragePricePage> createState() => _AveragePricePageState();
}

class _AveragePricePageState extends State<AveragePricePage> {
  Prices price = Prices.fivethousand_twentyFiveThousand;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter average price of your Restuarant',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 15),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: ListTile(
                  title: const Text(
                    '5,000 GNF-25,000 GNF',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Radio(
                    value: Prices.fivethousand_twentyFiveThousand,
                    groupValue: price,
                    onChanged: (Prices? value) {
                      setState(() {
                        price = value!;
                      });
                    },
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 15),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: ListTile(
                  title: const Text('26,000 GNF-50,000 GNF'),
                  leading: Radio(
                    value: Prices.twentySix_fiftyThousand,
                    groupValue: price,
                    onChanged: (Prices? value) {
                      setState(() {
                        price = value!;
                      });
                    },
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 15),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: ListTile(
                  title: const Text('51,000 GNF-75,000 GNF'),
                  leading: Radio(
                    value: Prices.fiftyonethousand_seventyFiveThousand,
                    groupValue: price,
                    onChanged: (Prices? value) {
                      setState(() {
                        price = value!;
                      });
                    },
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 15),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: ListTile(
                  title: const Text('76,000 GNF-100,000 GNF'),
                  leading: Radio(
                    value: Prices.seventySix_hundredThousand,
                    groupValue: price,
                    onChanged: (Prices? value) {
                      setState(() {
                        price = value!;
                      });
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(
                          color: Colors.pink, // Set border color
                          width: 3.0), // Set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // Set rounded corner radius
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black,
                            offset: Offset(1, 3))
                      ] // Make rounded corner of border
                      ),
                  child:
                      TextButton(onPressed: () {}, child: Text('Next Patge')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum Prices {
  fivethousand_twentyFiveThousand,
  twentySix_fiftyThousand,
  fiftyonethousand_seventyFiveThousand,
  seventySix_hundredThousand
}
