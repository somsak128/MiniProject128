import 'package:flutter/material.dart';
import 'package:miniproject128/page/login.dart';
import 'package:miniproject128/page/register.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register | Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
              child: Image.asset('images/TravelLogo.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                login(),
                const SizedBox(
                  width: 20,
                ),
                register(),
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox register() {
    return SizedBox(
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context){
                  return const Register();
                }));
            }, 
            icon: Icon(Icons.add), 
            label: Text("Register"),
        )
    );
  }

  SizedBox login() {
    return SizedBox(
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context){
                  return const Login();
                }));
            },  
            icon: Icon(Icons.login), 
            label: Text("Login")));
  }
}
