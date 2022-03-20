import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      title:Text("รายการสถานที่ท่องเที่ยว",style: TextStyle(color: Colors.white),)
      ),
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/T5.jpg'),
              fit: BoxFit.cover,
        )),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Travelstory").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            else{
              return ListView(
                children: snapshot.data!.docs.map((document){
                    return Container(
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: FittedBox(child: Text(document["score"]),
                            ),
                          ),
                          title: Text(document["attraction"]),
                          subtitle: Text(document["address"]),
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