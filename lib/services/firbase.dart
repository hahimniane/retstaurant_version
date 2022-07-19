import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_version/averege_price_page.dart';
import 'package:restaurant_version/post_registration/page1.dart';
import 'package:email_validator/email_validator.dart';
import 'package:restaurant_version/registration/setup_profile.dart';

import '../From_Sulaiman/screens/home_screen.dart';
import '../From_Sulaiman/screens/login_screen.dart';
import '../average_time_page.dart';

class FirebaseAthentications {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String restaurantsCollection = 'Restaurants';
  String menusCollection = 'Menus';
  String restaurantsDatabaseCollection = 'Restaurants Database';

  SignUpUser(
      BuildContext context,
      String email,
      String password,
      String userName,
      String fullAddress,
      String phoneNumber,
      String community) async {
    try {
      String? currentUser;
      var newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      currentUser = auth.currentUser?.uid;

      User? user = newUser.user;
      user?.updateDisplayName(userName);
      user?.updatePhotoURL('');
      // user?.updatePhoneNumber(PhoneAuthCredential.parse(phoneNumber));
      firestore
          .collection(restaurantsCollection.trim())
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
                    .collection(restaurantsCollection.trim())
                    .doc(auth.currentUser!.uid)
                    .update({'user id': auth.currentUser!.uid})
              })
          .then((value) => {
                firestore
                    .collection(restaurantsCollection.trim())
                    .doc(auth.currentUser!.uid)
                    .update(
                  {
                    'active': false,
                    'rating': '10',
                    'speed': '10',
                    'service': '10',
                    'taste': '10',
                    // 'array': FieldValue.arrayUnion(elements)
                  },
                ),
              })
          .then((value) => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AveragePricePage()))
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
              })
          .then((value) => {
                defaultRestaurantCoverFunction(
                    'https://firebasestorage.googleapis.com/v0/b/yemeksepeti-f4347.appspot.com/o/RestaurantProfilePictures%2FdefaultCoverImage.png?alt=media&token=587a0fae-380a-4a05-8600-742e2dd8de8d'),
              })
          .then((value) => {
                firestore.collection('Statistics').doc('Data').set({
                  'Total restaurants': FieldValue.increment(1),
                }, SetOptions(merge: true))
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
              .collection(restaurantsCollection.trim())
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
                        .collection(restaurantsDatabaseCollection.trim())
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

// this function checks if there is already a menu in the past then add
  Future<bool> getLastMenNumber(name, description, price, imageLink,
      compulsoryIngredient, List ingredientsList) async {
    print(auth.currentUser!.uid);

    var lastMenu;
    try {
      var getDoc = await firestore
          .collection(restaurantsCollection.trim())
          .doc(auth.currentUser!.uid)
          .collection(menusCollection.trim())
          .get();
      // .then((QuerySnapshot querySnapshot) {
      // print(int.parse(querySnapshot.docs.last.id) + 1);
      if (getDoc.docs.isNotEmpty) {
        firestore
            .collection(restaurantsCollection.trim())
            .doc(auth.currentUser!.uid)
            .collection(menusCollection.trim())
            .doc((int.parse(getDoc.docs.last.id) + 1).toString())
            .set({
          'food name': name,
          'description': description,
          'food price': price,
          'image link': imageLink,
          'ingredient 1': compulsoryIngredient,
          // 'first ingredient': ingredient1,
          // 'second ingredient': ingredient2,
          // 'third ingredient': ingredient3,
        }).then((value) => {
                  // firestore
                  //     .collection('MenuPhotos')
                  //     .doc(auth.currentUser!.uid)
                  //     .set({
                  //   'image url': imageLink,
                  // })
                  for (int i = 0; i < ingredientsList.length; ++i)
                    {
                      firestore
                          .collection(restaurantsCollection.trim())
                          .doc(auth.currentUser!.uid)
                          .collection(menusCollection.trim())
                          .doc((int.parse(getDoc.docs.last.id) + 1).toString())
                          .update({
                        'ingredient ${i + 2}': ingredientsList[i].text.trim(),

                        // 'food name': name,
                        // 'description': description,
                        // 'food price': price,
                        // 'image link': imageLink,
                        // 'first ingredient': ingredient1,
                        // 'second ingredient': ingredient2,
                        // 'third ingredient': ingredient3,
                      }),
                      // SetOptions(merge: true)
                    }
                });
        return true;
      } else {
        firestore
            .collection(restaurantsCollection.trim())
            .doc(auth.currentUser!.uid)
            .collection(menusCollection.trim())
            .doc(('1').toString())
            .set({
          'food name': name,
          'description': description,
          'food price': price,
          'image link': imageLink,
          'ingredient 1': compulsoryIngredient,
          // 'first ingredient': ingredient1,
          // 'second ingredient': ingredient2,
          // 'third ingredient': ingredient3,
        }).then((value) => {
                  for (int i = 0; i < ingredientsList.length; i++)
                    {
                      firestore
                          .collection(restaurantsCollection.trim())
                          .doc(auth.currentUser!.uid)
                          .collection(menusCollection.trim())
                          .doc(('1').toString())
                          .update({
                        'ingredient ${i + 2}': ingredientsList[i].text.trim(),
                      }),
                      // SetOptions(merge: true),

                      // firestore
                      //     .collection('MenuPhotos')
                      //     .doc(auth.currentUser!.uid)
                      //     .set({
                      //   'image url': imageLink,
                      //  })
                    }
                });
        return true;
      }
    } on FirebaseException catch (e) {
      return false;
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
    firestore.collection('MenuPhotos').doc(auth.currentUser!.uid).update({
      'cover image url': imageUrl,
    }).then((value) => {
          firestore
              .collection(restaurantsCollection.trim())
              .doc(auth.currentUser!.uid)
              .update(
            {'cover image url': imageUrl},
            // SetOptions(merge: true),
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
                  .collection(restaurantsCollection.trim())
                  .doc(auth.currentUser!.uid)
                  .update(
                {
                  'profile image url': imageUrl,
                },
              ),
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
        .set({
      'image url': imageUrl,
    }, SetOptions(merge: true)).then((value) => {
              firestore
                  .collection(restaurantsCollection.trim())
                  .doc(auth.currentUser!.uid)
                  .update(
                {
                  'profile image url': imageUrl,
                },
              ),
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const FirstPage()),
              // ),
            });
  }

  defaultRestaurantCoverFunction(
    imageUrl,
  ) {
    firestore.collection('MenuPhotos').doc(auth.currentUser!.uid).set({
      'cover image url': imageUrl,
    }).then((value) => {
          firestore
              .collection(restaurantsCollection.trim())
              .doc(auth.currentUser!.uid)
              .update(
            {
              'cover image url': imageUrl,
            },
          ),
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const FirstPage()),
          // ),
        });
  }

  void updateAverageRestaurantPrice(averagePrice, context) {
    firestore
        .collection(restaurantsCollection.trim())
        .doc(auth.currentUser!.uid)
        .update(
      {
        'average price': averagePrice,
      },
    ).then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AverageTimePage()))
            });
  }

  void updateAverageRestaurantTime(averageTime, context) {
    firestore
        .collection(restaurantsCollection.trim())
        .doc(auth.currentUser!.uid)
        .update(
      {
        'average time': averageTime,
      },
    ).then((value) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()))
            });
  }
}

enum ascendingIngredientList {
  firstIngredient,
  secondIngredient,
  thirdIngredient,
  fourthIngredient,
  fifthIngredient,
}
