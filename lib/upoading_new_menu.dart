import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_version/services/firbase.dart';
import 'package:restaurant_version/trial_page_for%20textfield.dart';
import 'package:path/path.dart' as Path;

class AddNewMenuPage extends StatefulWidget {
  const AddNewMenuPage({Key? key}) : super(key: key);

  @override
  State<AddNewMenuPage> createState() => _AddNewMenuPageState();
}

class _AddNewMenuPageState extends State<AddNewMenuPage> {
  FirebaseAthentications database = FirebaseAthentications();
  TextEditingController firstController = TextEditingController();
  final List<TextEditingController> _controllers = [];
  final List<Row> _fields = [];
  TextEditingController controller = TextEditingController();
  late UploadTask? task;
  late Row field;

  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  // static List friendsList = [null];
  // var currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController photo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController ingredientOne = TextEditingController();
  final TextEditingController ingredientTwo = TextEditingController();
  final TextEditingController ingredientThree = TextEditingController();
  ScrollController _scrolController = ScrollController();

  File? imageFile1;

  late String imageLink;

  @override
  Widget build(BuildContext context) {
    final saveButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      color: Colors.deepOrange,
      child: MaterialButton(
        height: 10,
        padding: const EdgeInsets.all(8.0),
        minWidth: MediaQuery.of(context).size.width * 0.90,
        onPressed: () async {
          if (name.text.isNotEmpty ||
              desc.text.isNotEmpty ||
              price.text.isNotEmpty ||
              imageFile1!.path.isNotEmpty ||
              _controllers.isNotEmpty) {
            var downloadableUrl = await uploadFile();
            if (downloadableUrl != null) {
              var isDone = await database.getLastMenNumber(
                  name.text,
                  desc.text,
                  price.text,
                  downloadableUrl.toString(),
                  firstController.text,
                  _controllers);
              if (isDone) {
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(
                    msg: 'An error has occurred. please try again');
              }
            }
          } else {
            print('something is empty');
          }

//            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//  await firebaseAthentications.signInUser(
//        emailController.text, passwordController.text, context);
//
//     signIn(emailController.text, passwordController.text);
// loader = true;
//   String result = await uploadFile();
//  firebaseAthentications.getLastMenNumber(
//      name.text,
//      desc.text,
//     price.text,
//        result,
//      ingredientOne.text,
//     ingredientTwo.text,
//     ingredientThree.text);
//        for (int i = 0; i < friendsList.length; ++i) {
//             print(friendsList[i] + " ");
//           }
        },
        child: const Text(
          'Save',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
    final nameField = TextFormField(
      autofocus: false,
      controller: name,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('food name is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Food name can't be less than 3 char");
        }
      },
      onSaved: (value) {
        name.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.food_bank),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Food Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //=====================food name input filed ==============================//
    final ingredients = <TextFormField>[
      // thought of this but a little confuse
    ];

    //=====================food name input filed ==============================//
    final descField = TextFormField(
      autofocus: false,
      controller: desc,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('food description is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Description can't be less than 3 char");
        }
      },
      onSaved: (value) {
        desc.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.fork_left),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Food description",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //=====================food name input filed ==============================//
    final priceField = TextFormField(
      autofocus: false,
      controller: price,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ('food price is required');
        }
      },
      onSaved: (value) {
        price.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.attach_money),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Price",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final ingredientOneField = TextFormField(
      autofocus: false,
      controller: ingredientOne,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Ingredient is required');
        }
      },
      onSaved: (value) {
        ingredientOne.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Ingredient 1",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Menu Details'),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: nameField,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: priceField,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: descField,
              ),
              Row(
                children: [
                  Expanded(
                    flex: (MediaQuery.of(context).size.width * 0.90).round(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: firstController,
                        decoration: InputDecoration(
                          hintText: ' Enter Ingredient ${'1'}',
                          prefixIcon: const Icon(
                            FontAwesomeIcons.mortarPestle,
                            color: Colors.grey,
                            size: 18,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey, //this has no effect
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  addTextFieldButton(),
                ],
              ),

              Expanded(child: _listView()),
// Column(
// children: ingredients.map((ingredient) {
//   return  Expanded(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ingredient,
//     ),
//   );
// }).toList(),
// ),
//***************************************************
// Row(
//   children: [
//     Expanded(
//         flex: 4, child: ingredientOneField),
//     Expanded(
//         flex: 1,
//         child: IconButton(
//           icon: const Icon(Icons.plus_one),
//           onPressed: () {},
//         ))
//   ],
// ),
              const SizedBox(
                height: 1,
              ),

              ElevatedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (name) {
                          return Container(
                            color: Colors.grey,
                            height: 200,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        _getImage(0);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.camera_alt)),
                                  IconButton(
                                      onPressed: () {
                                        _getImage(1);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                          FontAwesomeIcons.photoVideo)),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: const Text('choose photo')),

              Visibility(
                visible: true,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.grey),
                  ),
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Card(
                      elevation: 7,
                      child: imageFile1 != null
                          ? Image.file(imageFile1!)
                          : Image.asset('images/menu.jpeg')),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 46.0),
                  child: saveButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
      super.dispose();
    }

    // List<Widget> _getFriends() {
    //   List<Widget> friendsTextFields = [];
    //   for (int i = 0; i < friendsList.length; i++) {
    //     friendsTextFields.add(Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 16.0),
    //       child: Row(
    //         children: [
    //           // Expanded(child: FriendTextFields(i)),
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

  _getImage(type) async {
    try {
      var pickedFile;
      if (type == 0) {
        pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
      } else {
        pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
        );
      }

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        setState(() {
          imageFile1 = File(pickedFile!.path);
          print(imageFile);
        });
      } else {
        return;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  uploadFile() async {
    final fileName = imageFile1;

    var baseName = Path.basename(fileName!.path);
    task = FirebaseApi.uploadFile(fileName, baseName);
    if (task != null) {
      final snapshot = await task?.whenComplete(() => {});
      final url = await snapshot?.ref.getDownloadURL();
      setState(() {
        imageLink = url!;
        // print(' the download url is ' + avatarImage);
      });
      return url;
    } else {
      return null;
    }
  }

// this list view is there to show the list of ingredients inside of the fields of textfields;
  Widget _listView() {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            controller: _scrolController,
            itemCount: _fields.length + 1,
            itemBuilder: (context, index) {
              if (index == _fields.length) {
                return Container(
                  height: 100,
                );
              }
              return Container(
                margin: EdgeInsets.all(5),
                child: _fields[index],
              );
            }));
  }

  addTextFieldButton() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.10,
      child: FloatingActionButton(
          onPressed: () {
            var controller = TextEditingController();
            final field = Row(
              children: [
                Expanded(
                  flex: (MediaQuery.of(context).size.width * 0.90).round(),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: ' Enter Ingredient ${_fields.length + 2}',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.mortarPestle,
                        color: Colors.grey,
                        size: 18,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey, //this has no effect
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: (MediaQuery.of(context).size.width * 0.10).round(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.remove,
                          ),
                          onPressed: () {
                            setState(() {
                              _fields.removeLast();
                              _controllers.removeLast();
                              // _scrolController.animateTo(
                              //     _scrolController.position.maxScrollExtent,
                              //     duration: Duration(milliseconds: 1000),
                              //     curve: Curves.bounceIn);
                            });
                          }),
                    ))
              ],
            );

            setState(() {
              if (_controllers.length <= 3) {
                _controllers.add(controller);

                _fields.add(field);
                _scrolController.animateTo(
                    _scrolController.position.maxScrollExtent,
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeIn);
              } else {
                Fluttertoast.showToast(
                    msg: 'You cant add more than 8 ingredients');
              }
            });
          },
          child: Icon(Icons.add)),
    );
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(File filename, destination) {
    try {
      final ref = FirebaseStorage.instance
          .ref('/menus')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(destination);
      return ref.putFile(filename);
    } catch (e) {
      print(e);
    }
  }
}
