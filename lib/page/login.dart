import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:miniproject128/model/profile.dart';
import 'package:miniproject128/page/welcom.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Scaffold(
                appBar: AppBar(
                  title: Text("Error"),
                  ),
                body: Center(child: Text("${snapshot.error}"),
                ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("เข้าสู่ระบบ"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("อีเมล", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                              EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (email) {
                              profile.email = email!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                              obscureText: true,
                              onSaved: (password) {
                              profile.password = password!;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("ลงชื่อเข้าใช้",style: TextStyle(fontSize: 20)),
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try{
                                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: profile.email, 
                                      password: profile.password
                                      ).then((value){
                                          formKey.currentState!.reset();
                                          Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context){
                                              return Welcome();
                                          }));
                                      });
                                  }on FirebaseAuthException catch(e){
                                      Fluttertoast.showToast(
                                        msg: e.message!,
                                        gravity: ToastGravity.CENTER
                                      );
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
