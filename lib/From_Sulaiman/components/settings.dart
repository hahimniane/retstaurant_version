import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  Setting({
    Key? key,
  }) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // var hintName = getEmailName();
  late var restaurantNameFromFirebase = '';

  Future<String?> getEmailName() async {
    var restName;
    var result = await FirebaseFirestore.instance
        .collection('Restaurants Database')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {
              restaurantNameFromFirebase = value['Restaurant Name'],
              restName = value['Restaurant Name'],
            });
    return restName;
  }

  @override
  final TextEditingController email = TextEditingController();

  final TextEditingController restaurantName = TextEditingController();

  final TextEditingController restaurantFullAddress = TextEditingController();

  final TextEditingController restaurantPhoneNumber = TextEditingController();

  final TextEditingController community = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: email,
      keyboardType: TextInputType.emailAddress,
      //validator: () {},
      onSaved: (value) {
        email.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: FirebaseAuth.instance.currentUser!.email,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================restaurant name input filed ==============================//
    final restaurantNameField = TextFormField(
      autofocus: false,
      controller: restaurantName,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('Restaurant name is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Restaurant name can't be less than 3 char");
        }
      },
      onSaved: (value) {
        restaurantName.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.house),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: getEmailName().toString(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================restaurant address input filed ==============================//
    final restaurantAddressField = TextFormField(
      autofocus: false,
      controller: restaurantFullAddress,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('Restaurant address is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Restaurant address can't be less than 3 char");
        }
      },
      onSaved: (value) {
        restaurantFullAddress.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.place),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Water side",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================restaurant address input filed ==============================//
    final restaurantPhoneNumberField = TextFormField(
      autofocus: false,
      controller: restaurantPhoneNumber,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('Contact is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Please enter a valid number");
        }
      },
      onSaved: (value) {
        restaurantPhoneNumber.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "+224(**)-******",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================community input filed ==============================//
    final communityField = TextFormField(
      autofocus: false,
      controller: community,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('Community name is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Community name can't be less than 3 char");
        }
      },
      onSaved: (value) {
        community.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "West Point",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final updateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xffFF3F02),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          'Update Setting',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // primary: false,
        // padding: const EdgeInsets.all(20),
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 1,
        //     childAspectRatio: 5,
        //     mainAxisSpacing: 10,
        //     crossAxisSpacing: 5),
        children: [
          Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        selectFile();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/yemeksepeti-f4347.appspot.com/o/Main%20Menu%20photo%2FhqR2ua7lyhamnB8HaiUtZ9wJw943?alt=media&token=93ef34ad-7b46-47c0-a3a1-fdf880020bec',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      left: MediaQuery.of(context).size.width * 0.90,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        height: 30,
                        width: 30,
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 100.0,
                  child: GestureDetector(
                    onTap: () {
                      print('prfile pressed');
                    },
                    child: Stack(clipBehavior: Clip.none, children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/yemeksepeti-f4347.appspot.com/o/RestaurantProfilePictures%2FQmDs3ANrMmZsdIuM4qgWeXtyZsi2?alt=media&token=91212474-0146-4652-8546-d2d55b322fa3'),
                            ),
                            border:
                                Border.all(color: Colors.white, width: 5.0)),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.10,
                        left: MediaQuery.of(context).size.width * 0.24,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                          ),
                          height: 30,
                          width: 30,
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: emailField,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: restaurantNameField,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: restaurantAddressField,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: restaurantPhoneNumberField,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: communityField,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: updateButton,
          ),
        ],
      ),
    ));
  }

  @override
  void initState() {
    getEmailName();
    super.initState();
  }

  void selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    try {
      if (result != null) {
        final path = result.files.single.path;
        setState(() {
          // imageFile = File(path!);
          // //  avatarImage = File(path);
          //
          // print(imageFile);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class AddPic extends StatelessWidget {
  const AddPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Container(
          color: Colors.white70,
          width: width,
          height: height,
          child: Column(
            children: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
              const Expanded(
                  child: Image(
                image: AssetImage('images/sokpov.jpeg'),
              ))
            ],
          ),
        ));
  }
}
