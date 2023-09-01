import 'dart:io';
import 'dart:ui';
import 'package:dish_dive/Pages/SignUp.dart';
import 'package:dish_dive/Pages/profielpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../Recipe.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../components/custom_bottom_bar.dart';


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage>  with TickerProviderStateMixin<homepage>{
  final TextEditingController _recipename = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  // final FlutterTts flutterTts = FlutterTts();
  File? _imageFile;
  final FlutterTts flutterTts = FlutterTts();
  // final addedFarm newfarm = addedFarm();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<void> speakRecipe(Recipe recipe) async {
  //   await flutterTts.speak('Recipe Title: ${recipe.title}');
  //   await flutterTts.speak('Instructions: ${recipe.instructions}');
  // }

  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length:3 , vsync: this);
    // AssistantMethods.getCurrentOnlineUserInfo(context);
  }
  int currentIndex = 0;
  int currentTabIndex = 0;
  String titleApp = 'Home';
  String userId = '';

  TabController? bottomTabController;

  void _onItemTapped(int index) {
    setState(() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => homepage()),
              (Route<dynamic> route) => false);
    });
  }
  Future<void> speakRecipe(Recipe recipe) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.speak("${recipe.title}. ${recipe.ingredients}. ${recipe.instructions}");
  }
  void _submitForm() async {
    if (_recipename != null) {
      try {
        // Upload image to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child('recipe_images/${DateTime.now()}.jpg');
        final uploadTask = storageRef.putFile(_imageFile!);
        final imageUrl = await (await uploadTask).ref.getDownloadURL();

        // Save recipe data to Firestore
        await FirebaseFirestore.instance.collection('recipes').add({
          'title': _recipename.text,
          'ingredients': _ingredientsController.text,
          'instructions': _instructionsController.text,
          'imageUrl':imageUrl
          // Add other fields as needed
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Recipe saved successfully!'),
        ));

        // Clear form fields
        Navigator.pop(context);
        _recipename.clear();
        _ingredientsController.clear();
        _instructionsController.clear();
        setState(() {
          _imageFile = null;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error saving recipe: $error'),
        ));
      }
    }
  }
        Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source:  ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double _sigmaX = 5; // from 0-10
    double _sigmaY = 5; // from 0-10
    double _opacity = 0.2;
    double _width = 350;
    double _height = 300;
    return Scaffold(

        body: TabBarView(
          controller: bottomTabController,
          children: <Widget>[

   SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 39,),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign Out'),
                            backgroundColor: Colors.white,
                            content: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                      'Are you certain you want to Sign Out?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'Yes',
                                  style:
                                  TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  print('yes');
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      "/SignIn",
                                          (route) => false);
                                  // Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 0,
                          left: 10,
                          right: 15,
                        ),
                        width: 150,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(46),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 6,
                              color: Color(0xff000000).withOpacity(0.16),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text(
                                    "ADD A \n Recipe",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                        builder: (context, setState) {
                                          return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20.0)),
                                              //this right here
                                              child: Container(
                                                  height: 790,
                                                  child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          12.0),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            const Text(
                                                              "Add A Recipe",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  "Nunito",
                                                                  fontSize: 35,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),

                                                            _imageFile != null
                                                                ? Image.file(
                                                                _imageFile!)
                                                                : Icon(
                                                                Icons.camera_alt),
                                                            ElevatedButton(
                                                              onPressed: _getImage,
                                                              child: Text(
                                                                  'Upload Image'),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),

                                                            SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors
                                                                          .white54,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          12),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          offset: const Offset(
                                                                              0,
                                                                              3),
                                                                          blurRadius:
                                                                          6,
                                                                          color: const Color(
                                                                              0xff000000)
                                                                              .withOpacity(
                                                                              0.16),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    height: 50,
                                                                    child:
                                                                    TextField(
                                                                      textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                      key:
                                                                      UniqueKey(),
                                                                      controller:
                                                                      _recipename,
                                                                      keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                      style:
                                                                      const TextStyle(
                                                                        fontFamily:
                                                                        "Nunito",
                                                                        fontSize:
                                                                        16,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      decoration:
                                                                      InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintText:
                                                                        "Recipe Name",
                                                                        filled:
                                                                        true,
                                                                        fillColor:
                                                                        Colors.white54
                                                                        ,
                                                                        hintStyle:
                                                                        TextStyle(
                                                                          fontFamily:
                                                                          "Nunito",
                                                                          fontSize:
                                                                          16,
                                                                          color: Colors
                                                                              .grey,
                                                                        ),
                                                                      ),
                                                                      cursorColor:
                                                                      Colors
                                                                          .white54,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors
                                                                          .white54,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          12),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          offset: const Offset(
                                                                              0,
                                                                              3),
                                                                          blurRadius:
                                                                          6,
                                                                          color: const Color(
                                                                              0xff000000)
                                                                              .withOpacity(
                                                                              0.16),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    height: 50,
                                                                    child:
                                                                    TextField(
                                                                      textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                      key:
                                                                      UniqueKey(),
                                                                      controller:
                                                                      _ingredientsController,
                                                                      keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                      style:
                                                                      const TextStyle(
                                                                        fontFamily:
                                                                        "Nunito",
                                                                        fontSize:
                                                                        16,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      decoration:
                                                                      InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintText:
                                                                        "Ingredients",
                                                                        filled:
                                                                        true,
                                                                        fillColor:
                                                                        Colors.white54
                                                                        ,
                                                                        hintStyle:
                                                                        TextStyle(
                                                                          fontFamily:
                                                                          "Nunito",
                                                                          fontSize:
                                                                          16,
                                                                          color: Colors
                                                                              .grey,
                                                                        ),
                                                                      ),
                                                                      cursorColor:
                                                                      Colors
                                                                          .white54,
                                                                    ),
                                                                  ),

                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),


                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors
                                                                          .white54,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          12),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          offset: const Offset(
                                                                              0,
                                                                              3),
                                                                          blurRadius:
                                                                          6,
                                                                          color: const Color(
                                                                              0xff000000)
                                                                              .withOpacity(
                                                                              0.16),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    height: 50,
                                                                    child:
                                                                    TextFormField(
                                                                      controller: _instructionsController,
                                                                      decoration: InputDecoration(
                                                                          labelText: 'Instructions'),
                                                                      maxLines: 4,
                                                                      validator: (
                                                                          value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Please enter instructions.';
                                                                        }
                                                                        return null;
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),

                                                                  SizedBox(
                                                                      height: 20.0),

                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      _submitForm();
                                                                    },
                                                                    child:
                                                                    Container(
                                                                      height: 45,
                                                                      width: 90,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            20),
                                                                        color: Colors
                                                                            .black,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            offset: const Offset(
                                                                                0,
                                                                                3),
                                                                            blurRadius:
                                                                            6,
                                                                            color:
                                                                            const Color(
                                                                                0xff000000)
                                                                                .withOpacity(
                                                                                0.16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                      const Center(
                                                                        child:
                                                                        Text(
                                                                          "Done",
                                                                          style:
                                                                          TextStyle(
                                                                            fontSize:
                                                                            15,
                                                                            fontFamily:
                                                                            "Nunito",
                                                                            color:
                                                                            Colors
                                                                                .white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ]))));
                                        });
                                      },
                                    );
                                  },
                                  // onTap: (){
                                  //   Navigator.pushNamed(
                                  //       context,"/addproduct");
                                  //
                                  // },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 30,),

                Text("Recipes"),
                Center(




                     child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          final recipes = snapshot.data!.docs.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            return Recipe(
                              id: doc.id,
                              title: data['title'],
                              ingredients: data['ingredients'],
                              instructions: data['instructions'],
                              imageUrl: data['imageUrl'],
                            );
                          }).toList();

                          return Container(
                            height: 300,
                            child: ListView.builder(
                              itemCount: recipes.length,
                              itemBuilder: (context, index) {
                                final recipe = recipes[index];
                                return ListTile(
                                  leading: Image.network(recipe.imageUrl??""),
                                  title: Text(recipe.title),
                                  subtitle: Text(recipe.instructions),
                                  onTap: (){
                                    speakRecipe(recipe);
                                    // speakRecipe(recipe);
                                  },
                                  // Display recipe details and image here
                                );

                              },
                            ),
                          );
                        },


                  )),

              ],
            ),
          ),

            Profilepage(),
        ]),
        floatingActionButton:FloatingActionButton( //
          backgroundColor: Colors.black,
          // Floating action button on Scaffold
          splashColor:  Colors.cyan,
          onPressed: () => _onItemTapped(3),

          child: Icon(Icons.home), //icon inside button
        ),

        bottomNavigationBar: CustomBottomBar(controller: bottomTabController!)



    );
    ;
  }
}


displayToast(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
