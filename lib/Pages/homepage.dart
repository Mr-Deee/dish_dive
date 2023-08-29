import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Recipe.dart';



class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final TextEditingController _newProductGroup = TextEditingController();

  // final addedFarm newfarm = addedFarm();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double _sigmaX = 5; // from 0-10
    double _sigmaY = 5; // from 0-10
    double _opacity = 0.2;
    double _width = 350;
    double _height = 300;
    return Scaffold(

        body: Column(
          children: [
            SizedBox(height: 39,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
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
                              "ADD A \n TICKET",
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
                                                      height: 30,
                                                    ),
                                                    Column(
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
                                                            BorderRadius.circular(
                                                                12),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                offset: const Offset(
                                                                    0,
                                                                    3),
                                                                blurRadius:
                                                                6,
                                                                color: const Color(0xff000000)
                                                                    .withOpacity(0.16),
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
                                                            _newProductGroup,
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
                                                                    .black,
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
                                                            BorderRadius.circular(
                                                                12),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                offset: const Offset(
                                                                    0,
                                                                    3),
                                                                blurRadius:
                                                                6,
                                                                color: const Color(0xff000000)
                                                                    .withOpacity(0.16),
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
                                                            _newProductGroup,
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
                                                              "Event Group Name",
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
                                                                    .black,
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
                                                        GestureDetector(
                                                          onTap:
                                                              () async {
                                                            if (_newProductGroup.text !=
                                                                null &&
                                                                _newProductGroup.text !=
                                                                    "") {
                                                              try {
                                                                final DocumentSnapshot<
                                                                    Map<String,
                                                                        dynamic>> _doc = await _firestore
                                                                    .collection("utils")
                                                                    .doc("EventCategory")
                                                                    .get();
                                                                final List<dynamic>
                                                                _tempList =
                                                                _doc.data()!['list']
                                                                as List<dynamic>;
                                                                if (_tempList
                                                                    .contains(_newProductGroup.text)) {
                                                                  displayToast(
                                                                    "Group Name already created",
                                                                    context,
                                                                  );
                                                                } else {
                                                                  _tempList
                                                                      .add(_newProductGroup.text);
                                                                  _firestore
                                                                      .collection(
                                                                      'utils')
                                                                      .doc(
                                                                      "EventCategory")
                                                                      .update({
                                                                    'list':
                                                                    _tempList
                                                                  });
                                                                  displayToast(
                                                                    "Added Successfully",
                                                                    context,
                                                                  );
                                                                }
                                                              } catch (e) {
                                                                displayToast(
                                                                  "An Error Occured!",
                                                                  context,
                                                                );
                                                              }
                                                              // ignore: use_build_context_synchronously
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                              _newProductGroup
                                                                  .text = "";
                                                            } else {
                                                              displayToast(
                                                                "Enter Valid Name!",
                                                                context,
                                                              );
                                                            }
                                                          },
                                                          child:
                                                          Container(
                                                            height: 45,
                                                            width: 90,
                                                            decoration:
                                                            BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(
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
                                                                  const Color(0xff000000).withOpacity(0.16),
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
                                                                  Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]))));
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

              ],
            ),
            SizedBox(height: 399,),
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

                      // return ListView.builder(
                      //   itemCount: recipes.length,
                      //   itemBuilder: (context, index) {
                      //     final recipe = recipes[index];
                      //     return ListTile(
                      //       title: Text(recipe.title),
                      //       // Display recipe details and image here
                      //     );
                      //   },
                      // );

                      return Container();
                    },


              )),

          ],
        ));
    ;
  }
}

displayToast(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
