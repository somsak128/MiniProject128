import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:miniproject128/model/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miniproject128/page/home.dart';
import 'package:miniproject128/page/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(110, 0, 0, 0),
                  child: const Text("Register",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 25,
                      )),
                ),
              ),
              body: Center(
                // child: Container(
                //   decoration: const BoxDecoration(
                //      image: DecorationImage(
                //   image: AssetImage('images/T2.jpg'),
                //   fit: BoxFit.cover,
                // )),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                                      EmailValidator(
                                          errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (email) {
                                      profile.email = email!;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.cyan, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.cyan, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2),
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
                                const SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                                    obscureText: true,
                                    onSaved: (password) {
                                      profile.password = password!;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.cyan, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.cyan, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2),
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
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(120, 0, 0, 0),
                                  child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        try {
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: profile.email,
                                                  password: profile.password)
                                              .then((value) {
                                            formKey.currentState!.reset();
                                            Fluttertoast.showToast(
                                                msg:
                                                    "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                                gravity: ToastGravity.TOP);
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const Login();
                                            }));
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          // ignore: avoid_print
                                          print(e.code);
                                          String message;
                                          if (e.code ==
                                              'email-already-in-use') {
                                            message =
                                                "มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน";
                                          } else if (e.code ==
                                              'weak-password') {
                                            message =
                                                "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                                          } else {
                                            message = e.message!;
                                          }
                                          Fluttertoast.showToast(
                                              msg: message,
                                              gravity: ToastGravity.CENTER);
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.add,
                                        color: Colors.amber, size: 25),
                                    label: const Text(
                                      "ลงทะเบียน",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
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
