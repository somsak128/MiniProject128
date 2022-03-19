import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject128/page/home.dart';

class Welcome extends StatelessWidget {

final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("ยินดีต้อนรับ"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
                
                ElevatedButton(
                  child: Text("ออกจากระบบ"),
                  onPressed: (){
                     auth.signOut().then((value){
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context){
                            return const Homepage();
                        }));
                     });
                  }, 
                )
            ],),
        ),
      ),
    );
  }
}