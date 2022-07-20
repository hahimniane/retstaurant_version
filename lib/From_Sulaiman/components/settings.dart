import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:restaurant_version/From_Sulaiman/components/save_coverPhoto.dart';
import 'package:restaurant_version/From_Sulaiman/components/save_profilePhoto.dart';

import '../../trial_page_for textfield.dart';
import '../../trying.dart';

class Setting extends StatefulWidget {
  Setting({
    Key? key,
  }) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  saveUpdateToDatabase(
    TextEditingController update,
    String fieldNameInFirestore,
  ) {
    User? user = FirebaseAuth.instance.currentUser;
    if (update.text.isNotEmpty) {
      _firestore.collection('Restaurants').doc(_auth.currentUser!.uid).set({
        fieldNameInFirestore: update.text
      }, SetOptions(merge: true)).then((value) => {
            if (fieldNameInFirestore == 'Community')
              {
                _firestore
                    .collection('All restaurant profile Pictures')
                    .doc(_auth.currentUser!.uid)
                    .set({'location': update.text}, SetOptions(merge: true))
              },
            if (fieldNameInFirestore == 'Restaurant Name')
              {
                _firestore
                    .collection('All restaurant profile Pictures')
                    .doc(_auth.currentUser!.uid)
                    .set({'restaurant name': update.text},
                        SetOptions(merge: true)),
              },
            if (fieldNameInFirestore == 'Email')
              {
                user?.updateEmail(update.text),
                print('email was updated successfully'),
              }
          });
    }
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future resetEmail(String newEmail) async {
    var message;
    User firebaseUser = await FirebaseAuth.instance.currentUser!;
    firebaseUser
        .updateEmail(newEmail)
        .then(
          (value) => message = 'Success',
        )
        .then((value) => {print('updated')})
        .catchError((onError) => message = 'error');
    return message;
  }

  // var hintName = getEmailName();
  late var restaurantNameFromFirebase = '';

  File? imageFileForTheCoverPhoto;
  File? imageFileForTheProfilePhoto;

  // Future<String?> getEmailName() async {
  //   var restName;
  //   var result = await FirebaseFirestore.instance
  //       .collection('Restaurants Database')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) => {
  //             restaurantNameFromFirebase = value['Restaurant Name'],
  //             restName = value['Restaurant Name'],
  //           });
  //   return restName;
  // }

  final TextEditingController email = TextEditingController();

  final TextEditingController restaurantName = TextEditingController();

  final TextEditingController restaurantFullAddress = TextEditingController();

  final TextEditingController restaurantPhoneNumber = TextEditingController();

  final TextEditingController community = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return TextFormField(
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          );
        });

    //=====================restaurant name input filed ==============================//
    final restaurantNameField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return TextFormField(
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
                hintText: snapshot.data!['Restaurant Name'],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          );
        });

    //=====================restaurant address input filed ==============================//
    final restaurantAddressField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return TextFormField(
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
                hintText: snapshot.data!['Community'],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          );
        });

    //=====================restaurant address input filed ==============================//
    final restaurantPhoneNumberField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TextFormField(
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
                  hintText: snapshot.data!['Phone Number'],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            );
          } else {
            return CircularProgressIndicator();
          }
        });

    //=====================community input filed ==============================//
    final communityField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TextFormField(
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
                  hintText: snapshot.data!['Restaurant Full Address'],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            );
          } else
            return CircularProgressIndicator();
        });

    final updateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xffFF3F02),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          saveUpdateToDatabase(email, 'Email');
          saveUpdateToDatabase(
            restaurantName,
            'Restaurant Name',
          );
          saveUpdateToDatabase(restaurantFullAddress, 'Community');

          saveUpdateToDatabase(restaurantPhoneNumber, 'Phone Number');
          saveUpdateToDatabase(community, 'Restaurant Full Address');
        },
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
                      onTap: () async {
                        var isComplete = await selectFileForCoverPhoto();
                        if (isComplete != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SaveCoverPhotoPage(
                                imageUrl: imageFileForTheCoverPhoto,
                              ),
                            ),
                          );
                        }
                      },
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('MenuPhotos')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text(
                                  'Error with the databaase. try again later');
                            } else if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.20,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.none,
                                  image: NetworkImage(
                                    snapshot.data!['cover image url'],
                                  ),
                                ),
                              ),
                            );
                          }),
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
                    onTap: () async {
                      print('Hello world');
                      var isComplete = await selectFileForProfilePhoto();
                      if (isComplete != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaveProfilePhoto(
                              imageUrl: imageFileForTheProfilePhoto,
                            ),
                          ),
                        );
                      }
                    },
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('All restaurant profile Pictures')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text(
                                'Error with the databaase. try again later');
                          } else if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return Stack(clipBehavior: Clip.none, children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.width * 0.30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                        snapshot.data!['image url']),
                                  ),
                                  border: Border.all(
                                      color: Colors.white, width: 5.0)),
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
                          ]);
                        }),
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
    // getEmailName();
    super.initState();
  }

  selectFileForCoverPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    try {
      if (result != null) {
        final path = result.files.single.path;
        setState(() {
          imageFileForTheCoverPhoto = File(
            path!,
          );
          // //  avatarImage = File(path);
          //
          print(imageFileForTheCoverPhoto);
        });
        return path;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  selectFileForProfilePhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    try {
      if (result != null) {
        final path = result.files.single.path;
        setState(() {
          imageFileForTheProfilePhoto = File(
            path!,
          );
          // //  avatarImage = File(path);
          //
          print(imageFileForTheProfilePhoto);
        });
        return path;
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
