import 'package:firebase_auth/firebase_auth.dart';
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
                        
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนชื่อสถานที่ท่องเที่ยวด้วยครับ"),
                          onSaved: (attraction) {
                            mytravelstory.attraction = attraction;
                          },
                          decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.travel_explore_rounded,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'ชื่อสถานที่ท่องเที่ยว',
                            style: TextStyle(color: Colors.blue),
                          ),
                        )),
                        
                        const SizedBox(height: 15,),
                        
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนเรื่องราวด้วยครับ"),
                          onSaved: (story) {
                            mytravelstory.story = story;
                          },
                          decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.drive_file_rename_outline_outlined,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'เรื่องราว',
                            style: TextStyle(color: Colors.blue),
                          ),
                        )),

                        const SizedBox(height: 15,),
                        
                        
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนคะแนนด้วยครับ"),
                          onSaved: ( score) {
                            mytravelstory.score = score;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.scoreboard_outlined,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'คะแนน',
                            style: TextStyle(color: Colors.blue),
                          ),
                        )),

                        const SizedBox(height: 15,),

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
                                      "story":mytravelstory.story,
                                      "score":mytravelstory.score
                                   });
                                   formKey.currentState!.reset();
                                }
                              }),
                        ),
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