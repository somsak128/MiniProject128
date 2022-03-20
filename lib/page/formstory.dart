import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:miniproject128/model/story.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final CollectionReference _travelstoryCollection = FirebaseFirestore.instance.collection("Travelstory");

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
                title: const Text("แบบฟอร์มบันทึก Travel story",style: TextStyle(color: Colors.white),),
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ชื่อสถานที่ท่องเที่ยว",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนชื่อสถานที่ท่องเที่ยวด้วยครับ"),
                          onSaved: (attraction) {
                            mytravelstory.attraction = attraction;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "ที่อยู่",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนที่อยู่ด้วยครับ"),
                          onSaved: (address) {
                            mytravelstory.address = address;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "เรื่องราว",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนนามสกุลด้วยครับ ^^"),
                          onSaved: (story) {
                            mytravelstory.story = story;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        
                        const Text(
                          "คะแนน",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนคะแนนด้วยครับ"),
                          onSaved: ( score) {
                            mytravelstory.score = score;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              child: const Text(
                                "บันทึกข้อมูล",
                                style: TextStyle(fontSize: 20,color: Colors.white),
                              ),
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                   formKey.currentState!.save();
                                   await _travelstoryCollection.add({
                                      "attraction":mytravelstory.attraction,
                                      "address":mytravelstory.address,
                                      "story":mytravelstory.story,
                                      "score":mytravelstory.score
                                   });
                                   formKey.currentState!.reset();
                                }
                              }),
                        )
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