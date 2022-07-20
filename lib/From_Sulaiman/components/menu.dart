import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../services/firbase.dart';

import '../../upoading_new_menu.dart';

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  //final _formKey = GlobalKey<FormState>();
  // TextEditingController? _nameController;
  //  static List friendsList = [null];
  var currentUser = FirebaseAuth.instance.currentUser;

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Menus')
      .snapshots();

  final TextEditingController photo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController ingredientOne = TextEditingController();
  final TextEditingController ingredientTwo = TextEditingController();
  final TextEditingController ingredientThree = TextEditingController();

  late int imageType;

  bool loader = false;
  // bool controller = true;

  FirebaseAthentications firebaseAthentications = FirebaseAthentications();

  late File imageFile1;

  late UploadTask? task;

  late String avatarImage =
      'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';

  late String iconLink =
      'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';

  buildCard(String img, String title, String subtitle, String price) {
    return Card(
      child: TextButton(
        onPressed: () {},
        child: ListTile(
            leading: Image(image: AssetImage(img)),
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Text(price)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.height;

    // final nameField = TextFormField(
    //   autofocus: false,
    //   controller: name,
    //   keyboardType: TextInputType.text,
    //   validator: (value) {
    //     RegExp regexp = RegExp(r'^.{3,}$');
    //     if (value!.isEmpty) {
    //       return ('food name is required');
    //     }
    //     if (!regexp.hasMatch(value)) {
    //       return ("Food name can't be less than 3 char");
    //     }
    //   },
    //   onSaved: (value) {
    //     name.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.food_bank),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Food Name",
    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    // );
    //=====================food name input filed ==============================//
    // final ingredients = <TextFormField>[
    //   // thought of this but a little confuse
    // ];

    //=====================food name input filed ==============================//
    // final descField = TextFormField(
    //   autofocus: false,
    //   controller: desc,
    //   keyboardType: TextInputType.text,
    //   validator: (value) {
    //     RegExp regexp = RegExp(r'^.{3,}$');
    //     if (value!.isEmpty) {
    //       return ('food description is required');
    //     }
    //     if (!regexp.hasMatch(value)) {
    //       return ("Description can't be less than 3 char");
    //     }
    //   },
    //   onSaved: (value) {
    //     desc.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.fork_left),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Food description",
    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    // );
    //=====================food name input filed ==============================//
    // final priceField = TextFormField(
    //   autofocus: false,
    //   controller: price,
    //   keyboardType: TextInputType.number,
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return ('food price is required');
    //     }
    //   },
    //   onSaved: (value) {
    //     price.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.attach_money),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Price",
    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    // );
    // final ingredientOneField = TextFormField(
    //   autofocus: false,
    //   controller: ingredientOne,
    //   keyboardType: TextInputType.text,
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return ('Ingredient is required');
    //     }
    //   },
    //   onSaved: (value) {
    //     ingredientOne.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //       // prefixIcon: Icon(Icons.),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Ingredient 1",
    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    // );
    // final SaveButton = Material(
    //   elevation: 2,
    //   borderRadius: BorderRadius.circular(30),
    //   color: Colors.pink,
    //   child: MaterialButton(
    //     height: MediaQuery.of(context).size.height * 0.20,
    //     padding: const EdgeInsets.all(8.0),
    //     minWidth: MediaQuery.of(context).size.width * 0.60,
    //     onPressed: () async {
    //       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    //       // await firebaseAthentications.signInUser(
    //       //     emailController.text, passwordController.text, context);
    //
    //       // signIn(emailController.text, passwordController.text);
    //       //------------------------------------------------------
    //       loader = true;
    //       // String result = await uploadFile();
    //       // firebaseAthentications.getLastMenNumber(
    //       //     name.text,
    //       //     desc.text,
    //       //     price.text,
    //       //     result,
    //       //     ingredientOne.text,
    //       //     ingredientTwo.text,
    //       //     ingredientThree.text);
    //     },
    //     child: const Text(
    //       'Save',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //           fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    //     ),
    //   ),
    // );
    // List<Widget> list = [];
    return SafeArea(
        child: Column(
      children: [
        Expanded(
          flex: 5,
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else if (snapshot.data!.docs.isEmpty) {
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                //   setState(() {
                //     snapshot.data!.docs.isEmpty ? controller = false : true;
                //   });
                // });

                return Center(
                    child: Text(
                  "You don't have any menus yet",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * 0.066,
                  ),
                ));
              } else if (!snapshot.hasData) {
                return const Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()));
              } else {
                return GridView(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Card(
                      child: GestureDetector(
                        onLongPress: () {
                          print('card was long pressed');
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: ListTile(
                                  leading: Image(
                                      image: NetworkImage(data['image link'])),
                                  title: Text(data['food name']),
                                  subtitle: Text(data['description']),
                                  trailing: Text(' ${data['food price']} GNF')),
                            ),
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    print('the edit button was pressed');
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 15,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              // return ListView(
              //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
              //     Map<String, dynamic> data =
              //         document.data()! as Map<String, dynamic>;
              //     return ListTile(
              //       title: Text(data['full_name']),
              //       subtitle: Text(data['company']),
              //     );
              //   }).toList(),
              // );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                splashColor: Colors.pink,
                child: const Center(
                    child: Icon(
                  Icons.add,
                  size: 20,
                )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddNewMenuPage()));
//                   showModalBottomSheet(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30)),
//                       ),
//                       context: context,
//                       builder: (context) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: MediaQuery.of(context).size.height,
//                             child: ListView(
//                               children: [
//                                 SizedBox(
//                                   height: MediaQuery.of(context).size.height,
//                                   child: Column(
//                                     children: [
//                                       const Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Text('Add To Menu'),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.all(12.0),
//                                         child: nameField,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: priceField,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: descField,
//                                       ),
// // Column(
// // children: ingredients.map((ingredient) {
// //   return  Expanded(
// //     child: Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: ingredient,
// //     ),
// //   );
// // }).toList(),
// // ),
// //***************************************************
// // Row(
// //   children: [
// //     Expanded(
// //         flex: 4, child: ingredientOneField),
// //     Expanded(
// //         flex: 1,
// //         child: IconButton(
// //           icon: const Icon(Icons.plus_one),
// //           onPressed: () {},
// //         ))
// //   ],
// // ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Form(
//                                         key: _formKey,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
// // name textfield
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 32.0),
//                                                 child: TextFormField(
//                                                   controller: _nameController,
//                                                   decoration: InputDecoration(
//                                                       hintText:
//                                                           'Enter your name'),
//                                                   validator: (v) {
//                                                     if (v!.trim().isEmpty)
//                                                       return 'Please enter something';
//                                                     return null;
//                                                   },
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 20,
//                                               ),
//
//                                               ..._getFriends(),
//                                               SizedBox(
//                                                 height: 40,
//                                               ),
//                                               TextButton(
//                                                 style: TextButton.styleFrom(
//                                                   backgroundColor: Colors.green,
//                                                 ),
//                                                 onPressed: () {
//                                                   if (_formKey.currentState!
//                                                       .validate()) {
//                                                     _formKey.currentState!
//                                                         .save();
//                                                   }
//                                                 },
//                                                 child: Text('Submit'),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       ElevatedButton(
//                                           onPressed: () async {
//                                             showModalBottomSheet(
//                                                 context: context,
//                                                 builder: (name) {
//                                                   return Container(
//                                                     color: Colors.grey,
//                                                     height: 200,
//                                                     child: Center(
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           IconButton(
//                                                               onPressed:
//                                                                   () async {
//                                                                 imageType = 0;
//                                                                 await _getImage(
//                                                                     imageType);
// // imageType = 0;
// //
// // // enumList.photo;
// // selectFile(imageType);
//                                                               },
//                                                               icon: const Icon(Icons
//                                                                   .camera_alt)),
//                                                           IconButton(
//                                                               onPressed: () {
//                                                                 imageType = 1;
//                                                                 _getImage(
//                                                                     imageType);
//                                                               },
//                                                               icon: const Icon(
//                                                                   FontAwesomeIcons
//                                                                       .photoVideo)),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   );
//                                                 });
// // selectFile();
//                                           },
//                                           child: const Text('choose photo')),
//
//                                       Expanded(
//                                           flex: 1,
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 46.0),
//                                             child: SaveButton,
//                                           )),
// // SizedBox(
// //   height: 100,
// //   width: 100,
// //   child: avatarImage ==
// //       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg'
// //       ? Image.network(iconLink)
// //       : avatarImage !=
// //       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg'
// //       ? Image.file(imageFile1)
// //       : Image.network(avatarImage),
// // ),
// // ElevatedButton(
// //     onPressed: () async {
// //       loader = true;
// //       String result = await uploadFile();
// //       if (result != null) {
// //         firebaseAthentications.getLastMenNumber(
// //             nameController.text,
// //             descriptionController.text,
// //             priceController.text,
// //             result,
// //             ingredient1Controller.text,
// //             ingredient2Controller.text,
// //             ingredient3nameController.text);
// //       }
// //       // var result = await FirebaseStorage.instance
// //       //     .ref('menus')
// //       //     .child(FirebaseAuth.instance.currentUser!.uid)
// //       //     .listAll();
// //       // print(result.items.first.name);
// //     },
// //     child: const Text('upload')),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//
//                         ;
//                       });
                },
              ),
            ),
          ),
        )
      ],
    )
        // GridView(
        //   primary: false,
        //   padding: const EdgeInsets.all(20),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 1,
        //       childAspectRatio: 3,
        //       mainAxisSpacing: 10,
        //       crossAxisSpacing: 5),
        //   children: [
        //     StreamBuilder<QuerySnapshot>(
        //       stream: _usersStream,
        //       builder:
        //           (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //         if (snapshot.hasError) {
        //           return Text('Something went wrong');
        //         }
        //
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return Text("Loading");
        //         }
        //
        //         return buildCard('images/pizza.png', 'Pizza',
        //             'lorem ipsum is the stander testing text', '1000');
        //
        //           ListView(
        //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        //             return ListTile(
        //               title: Text(data['full_name']),
        //               subtitle: Text(data['company']),
        //             );
        //           }).toList(),
        //         );
        //       },
        //
        // buildCard('images/burger.png', 'Pizza',
        //     'lorem ipsum is the stander testing text', '900'),
        //       // buildCard('images/plate.png', 'Pizza',
        //       //     'lorem ipsum is the stander testing text', '1200'),
        //       // buildCard('images/noodle.png', 'Pizza',
        //       //     'lorem ipsum is the stander testing text', '300'),
        //       // buildCard('images/kfc.png', 'Pizza',
        //       //     'lorem ipsum is the stander testing text', '2500'),
        //       // buildCard('images/chicken.png', 'Pizza',
        //       //     'lorem ipsum is the stander testing text', '500'),
        //       // buildCard('images/shawarma.png', 'Pizza',
        //       //     'lorem ipsum is the stander testing text', '700'),
        //     )
        //   ],
        // ),
        );
  }

  // uploadFile() async {
  //   final fileName = imageFile1;
  //
  //   var baseName = basename(fileName.path);
  //   task = FirebaseApi.uploadFile(fileName, baseName);
  //   if (task != null) {
  //     final snapshot = await task?.whenComplete(() => {});
  //     final url = await snapshot?.ref.getDownloadURL();
  //     setState(() {
  //       avatarImage = url!;
  //       print(' the download url is ' + avatarImage);
  //       loader = false;
  //     });
  //     return url;
  //   } else {
  //     return null;
  //   }
  // }

  // _getImage(type) async {
  //   try {
  //     var pickedFile;
  //     if (type == 0) {
  //       pickedFile = await ImagePicker().pickImage(
  //         source: ImageSource.camera,
  //         maxWidth: 1800,
  //         maxHeight: 1800,
  //       );
  //     } else {
  //       pickedFile = await ImagePicker().pickImage(
  //         source: ImageSource.gallery,
  //         maxWidth: 1800,
  //         maxHeight: 1800,
  //       );
  //     }
  //
  //     if (pickedFile != null) {
  //       File imageFile = File(pickedFile.path);
  //
  //       setState(() {
  //         imageFile1 = File(pickedFile!.path);
  //         print(imageFile);
  //       });
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // List<Widget> _getFriends() {
  //   List<Widget> friendsTextFields = [];
  //   for (int i = 0; i < friendsList.length; i++) {
  //     friendsTextFields.add(Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 16.0),
  //       child: Row(
  //         children: [
  //           Expanded(child: FriendTextFields(i)),
  //           SizedBox(
  //             width: 16,
  //           ),
  //           // we need add button at last friends row
  //           _addRemoveButton(i == friendsList.length - 1, i),
  //         ],
  //       ),
  //     ));
  //   }
  //   return friendsTextFields;
  // }

  // Widget _addRemoveButton(bool add, int index) {
  //   return InkWell(
  //     onTap: () {
  //       if (add) {
  //         // add new text-fields at the top of all friends textfields
  //         friendsList.insert(0, '');
  //       } else
  //         friendsList.removeAt(index);
  //       setState(() {});
  //     },
  //     child: Container(
  //       width: 30,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: (add) ? Colors.green : Colors.red,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Icon(
  //         (add) ? Icons.add : Icons.remove,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
}
/*
*     loader = true;
                                    String result = await uploadFile();
                                    if (result != null) {
                                      firebaseAthentications.getLastMenNumber(
                                          nameController.text,
                                          descriptionController.text,
                                          priceController.text,
                                          result,
                                          ingredient1Controller.text,
                                          ingredient2Controller.text,
                                          ingredient3nameController.text);
                                    }
* */
//******************************************************************************************************
//
//
