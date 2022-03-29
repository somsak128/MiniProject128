import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:miniproject128/model/story.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miniproject128/page/datapage.dart';

class Formstory extends StatefulWidget {
  const Formstory({Key? key}) : super(key: key);

  @override
  _FormstoryState createState() => _FormstoryState();
}

class _FormstoryState extends State<Formstory> {
  final formKey = GlobalKey<FormState>();
  Travelstory mytravelstory = Travelstory();
  //เตรียม firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _travelstoryCollection =
      FirebaseFirestore.instance.collection("Travelstory");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Record From My Travel",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                        child: const Icon(
                          Icons.exit_to_app_rounded,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      })
                ],
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "กรุณาป้อนชื่อสถานที่ท่องเที่ยวด้วยครับ"),
                            onSaved: (attraction) {
                              mytravelstory.attraction = attraction;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              prefixIcon: Icon(
                                Icons.travel_explore_rounded,
                                color: Colors.amber,
                              ),
                              label: Text(
                                'ชื่อสถานที่ท่องเที่ยว',
                                style: TextStyle(color: Colors.amber),
                              ),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนเรื่องราวด้วยครับ"),
                            onSaved: (story) {
                              mytravelstory.story = story;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              prefixIcon: Icon(
                                Icons.drive_file_rename_outline_outlined,
                                color: Colors.amber,
                              ),
                              label: Text(
                                'เรื่องราว',
                                style: TextStyle(color: Colors.amber),
                              ),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนคะแนนด้วยครับ"),
                            onSaved: (score) {
                              mytravelstory.score = score;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              prefixIcon: Icon(
                                Icons.scoreboard_outlined,
                                color: Colors.amber,
                              ),
                              label: Text(
                                'คะแนน',
                                style: TextStyle(color: Colors.amber),
                              ),
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                await _travelstoryCollection.add({
                                  "attraction": mytravelstory.attraction,
                                  "story": mytravelstory.story,
                                  "score": mytravelstory.score
                                });
                                formKey.currentState!.reset();
                                Fluttertoast.showToast(
                                    msg: "บันทึกข้อมูลเรียบร้อยแล้ว",
                                    fontSize: 15,
                                    gravity: ToastGravity.TOP);
                              }
                            },
                            icon: const Icon(Icons.add,
                                color: Colors.amber, size: 25),
                            label: const Text(
                              "บันทึกข้อมูล",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
