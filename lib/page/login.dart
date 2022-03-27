import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:miniproject128/model/profile.dart';
import 'package:miniproject128/page/home.dart';
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
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(150,0, 0, 0),
                  
                  child: const Text("Sign In",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 25,)),
                ),
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
                          const SizedBox(height:20,),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                              EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (email) {
                              profile.email = email!;
                            },
                            decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.cyan, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.cyan, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.red, width: 2),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.amber,
                            ),
                            label: Text(
                              'E-mail',
                              style: TextStyle(color: Colors.amber),
                            ),
                          )),

                          const SizedBox(height: 40,),
                          
                          TextFormField(
                            validator: RequiredValidator(errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                              obscureText: true,
                              onSaved: (password) {
                              profile.password = password!;
                            },
                            decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.cyan, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.cyan, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.red, width: 2),
                            ),
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: Colors.amber,
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(color: Colors.amber),
                            ),
                          )),

                          const SizedBox(height: 40,),
                          SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
                                child: ElevatedButton.icon(
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
                                                return const Welcome(title: '',);
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
                            icon: const Icon(Icons.login_rounded, color: Colors.amber,size: 25),
                            label: const Text("เข้าสู่ระบบ",style: TextStyle(fontSize: 20,color: Colors.white),),
                          ),
                              )),
                        ],
                      ),
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
