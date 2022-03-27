// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:miniproject128/page/home.dart';

// class Welcome extends StatelessWidget {

// final auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(title: Text("ยินดีต้อนรับ"),),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Center(
//           child: Column(
//             children: [
                
//                 ElevatedButton(
//                   child: Text("ออกจากระบบ"),
//                   onPressed: (){
//                      auth.signOut().then((value){
//                         Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context){
//                             return const Homepage();
//                         }));
//                      });
//                   }, 
//                 )
//             ],),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject128/page/datapage.dart';
import 'package:miniproject128/page/formstory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        textTheme: GoogleFonts.notoSansThaiTextTheme(),
      ),
      home: const Welcome(title: ''),
    );
  }
}

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  

  @override
  Widget build(BuildContext context) {
      return const DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              Formstory(),
              datapage()
             
              
              
            ],
            ),
            backgroundColor: Color.fromARGB(255, 231, 235, 15),
            bottomNavigationBar: TabBar(
              tabs: [
                Tab(text: "Save the Sights"),
                Tab(text: "List of Attractions")
                
              ],
        ),
      ));
  }
}
  