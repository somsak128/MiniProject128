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
          title: const Text("Register | Login",style: TextStyle(color: Colors.white),),
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/T1.jpg'),
              fit: BoxFit.cover,
            )),
            child:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 100, 10, 50),
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
          ),
        ));
  }

  SizedBox register() {
    return SizedBox(
        child: ElevatedButton.icon(
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const Register();
        }));
      },
      icon: const Icon(Icons.add, color: Color.fromARGB(255, 230, 245, 24),),
      label: const Text("Register",style: TextStyle(color: Colors.white),),
    ));
  }

  SizedBox login() {
    return SizedBox(
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const Login();
              }));
            },
            icon: Icon(Icons.login, color: Colors.amber,),
            label: Text("Login",style: TextStyle(color: Colors.white),)));
  }
}
