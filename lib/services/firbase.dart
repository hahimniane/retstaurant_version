import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_version/post_registration/page1.dart';
import 'package:email_validator/email_validator.dart';
import 'package:restaurant_version/registration/setup_profile.dart';

import '../From_Sulaiman/screens/home_screen.dart';

class FirebaseAthentications {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  SignUpUser(
      BuildContext context,
      String email,
      String password,
      String userName,
      String fullAddress,
      String phoneNumber,
      String community) async {
    try {
      var ref;
      String? currentUser;
      var newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      currentUser = auth.currentUser?.uid;

      User? user = newUser.user;
      user?.updateDisplayName(userName);
      user?.updatePhotoURL('');
      // user?.updatePhoneNumber(PhoneAuthCredential.parse(phoneNumber));
      firestore
          .collection("Restaurants")
          .doc(auth.currentUser?.uid)
          .set({
            'Email': email,
            'Restaurant Name': userName,
            'Restaurant Full Address': fullAddress,
            'Phone Number': phoneNumber,
            'Community': community,
          })
          .then((value) => {
                firestore
                    .collection('Restaurants')
                    .doc(auth.currentUser!.uid)
                    .set({'user id': auth.currentUser!.uid})
              })
          .then((value) => {
                firestore
                    .collection('Restaurants')
                    .doc(auth.currentUser!.uid)
                    .set({
                  'rating': '10',
                  'speed': '10',
                  'service': '10',
                  'taste': '10',
                }, SetOptions(merge: true)),
              })
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()))
              })
          .then((value) => {
                firestore
                    .collection('All restaurant profile Pictures')
                    .doc(auth.currentUser!.uid)
                    .set({'location': community, 'restaurant name': userName})
              })
          .then((value) => {
                // ref = FirebaseStorage.instance
                //     .ref('menus/${auth.currentUser!.uid}'),
              })
          .then((value) => {
                defaultRestaurantProfilePicFunction(
                    'https://firebasestorage.googleapis.com/v0/b/yemeksepeti-f4347.appspot.com/o/RestaurantProfilePictures%2FdefaultImage.jpg?alt=media&token=de43d688-d144-4c61-94e1-bbdf641623ff'),
              });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

  signInUser(String email, String password, BuildContext context) async {
    try {
      if (EmailValidator.validate(email)) {
        print(EmailValidator.validate(email));
        auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          bool exist;
          firestore
              .collection('Restaurants')
              .doc(auth.currentUser!.uid)
              .get()
              .then((value) => {
                    value.exists ? exist = true : exist = false,
                    if (exist)
                      {
                        print('the user is from the restaurant app'),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen())),
                      }
                    else
                      {print('the user is not a restaurant')}
                  });
        });
      } else {
        var displayNme = auth.currentUser?.displayName;
        if (displayNme == email) {
          bool exist;
          auth
              .signInWithEmailAndPassword(
                  email: auth.currentUser!.email.toString(), password: password)
              .then((value) => {
                    firestore
                        .collection('Restaurants database')
                        .doc(auth.currentUser!.uid)
                        .get()
                        .then((value) => {
                              value.exists ? exist = true : exist = false,
                              if (exist)
                                {
                                  print('the user is from the restaurant app'),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FirstPage())),
                                }
                              else
                                {print('the user is not a restaurant')}
                            })
                  });
        }
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

  logoutUser(context) {
    try {
      auth.signOut().then((value) => {
            // Navigator.pop(context)
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => WelcomePage()))
          });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) => {
            Fluttertoast.showToast(
                msg: 'the  reset code was sent to your email',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 20.0)
          });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

  getLastMenNumber(name, description, price, imageLink, ingredient1,
      ingredient2, ingredient3) async {
    print(auth.currentUser!.uid);

    var lastMenu;
    try {
      var getDoc = await firestore
          .collection("Restaurants")
          .doc(auth.currentUser!.uid)
          .collection('Menus')
          .get();
      // .then((QuerySnapshot querySnapshot) {
      // print(int.parse(querySnapshot.docs.last.id) + 1);
      if (getDoc.docs.isNotEmpty) {
        firestore
            .collection('Restaurants')
            .doc(auth.currentUser!.uid)
            .collection('Menus')
            .doc((int.parse(getDoc.docs.last.id) + 1).toString())
            .set({
          'food name': name,
          'description': description,
          'food price': price,
          'image link': imageLink,
          'first ingredient': ingredient1,
          'second ingredient': ingredient2,
          'third ingredient': ingredient3,
        }).then((value) => {
                  // print( ),
                  // firestore.collection('Restaurants/${auth.currentUser!.uid}/Menus/${value.id}').
                  //     .doc(auth.currentUser!.uid)
                  //     .collection('Menus').doc().

                  firestore
                      .collection('MenuPhotos')
                      .doc(auth.currentUser!.uid)
                      .set({
                    'image url': imageLink,
                  })
                });
      } else {
        firestore
            .collection('Restaurants')
            .doc(auth.currentUser!.uid)
            .collection('Menus')
            .doc(('1').toString())
            .set({
          'food name': name,
          'description': description,
          'food price': price,
          'image link': imageLink,
          'first ingredient': ingredient1,
          'second ingredient': ingredient2,
          'third ingredient': ingredient3,
        }).then((value) => {
                  // firestore
                  //     .collection('MenuPhotos')
                  //     .doc(auth.currentUser!.uid)
                  //     .set({
                  //   'image url': imageLink,
                  //  })
                });
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  // Future<String?> getMenuLinks() async {
  //   CollectionReference documentReference = firestore.collection('MenuPhotos');
  //   String? url;
  //   List list = [];
  //   await documentReference.get().then((snapshot) {
  //     for (int i = 0; i < snapshot.size; ++i) {
  //       url = snapshot.docs[i]['image url'];
  //       list.add(url);
  //       print('came from firebase  ' + list[i]);
  //     }
  //   });
  //
  //   return url;
  // }

  uploadRestaurantCoverPhoto(imageUrl) {
    firestore
        .collection('MenuPhotos')
        .doc(auth.currentUser!.uid)
        .set({'image url': imageUrl}).then((value) => {
              firestore
                  .collection('Restaurants')
                  .doc(auth.currentUser!.uid)
                  .set(
                {'cover image url': imageUrl},
                SetOptions(merge: true),
              ),
            });
  }

  uploadRestaurantProfilePhoto(imageUrl, [context]) {
    firestore
        .collection('All restaurant profile Pictures')
        .doc(auth.currentUser!.uid)
        .update({
      'image url': imageUrl,
    }).then((value) => {
              firestore
                  .collection('Restaurants')
                  .doc(auth.currentUser!.uid)
                  .set({
                'profile image url': imageUrl,
              }, SetOptions(merge: true)),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FirstPage())),
            });
  }

  defaultRestaurantProfilePicFunction(
    imageUrl,
  ) {
    firestore
        .collection('All restaurant profile Pictures')
        .doc(auth.currentUser!.uid)
        .update({
      'image url': imageUrl,
    }).then((value) => {
              firestore
                  .collection('Restaurants ')
                  .doc(auth.currentUser!.uid)
                  .set({
                'profile image url': imageUrl,
              }, SetOptions(merge: true)),
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const FirstPage()),
              // ),
            });
  }
}
