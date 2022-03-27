import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class datapage extends StatefulWidget {
  const datapage({ Key? key }) : super(key: key);

  @override
  State<datapage> createState() => _datapageState();
}

class _datapageState extends State<datapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title:const Text("My Travel List",style: TextStyle(color: Colors.white),),
      actions: [
        IconButton( 
          icon: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 70, 0),
            child: Icon(Icons.exit_to_app_rounded,color: Colors.redAccent,size: 30,),
          ),
          onPressed: (){
            SystemNavigator.pop();
          })
        ],
      ),
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/T6.png'),
              fit: BoxFit.cover,
        )),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Travelstory").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(),);
            }
            else{
              return ListView(
                children: snapshot.data!.docs.map((document){
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color: const Color.fromARGB(255, 249, 249, 251),
                          child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                child: FittedBox(child: Text(document["score"],style: const TextStyle(fontSize:35,color: Colors.white),),
                                ),
                              ),
                              title: Text(document["attraction"],style: const TextStyle(fontSize: 15),),
                              subtitle: Text(document["story"],style: const TextStyle(fontSize: 13),),
                          ),
                        ),
                      ),
                    );
                }).toList(),
            );
            }
          },
        ),
      ),
      ));
  }
}
// title: Text(document["attraction"]+document["address"]),