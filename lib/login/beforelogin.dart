import 'package:fourth_year/login/login.dart';
import 'package:flutter/material.dart';

class Beforelogin extends StatefulWidget {
  const Beforelogin({super.key});

  @override
  State<Beforelogin> createState() => _BeforeloginState();
}

class _BeforeloginState extends State<Beforelogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text("User Data"),
          backgroundColor: Colors.blueGrey.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter your Address',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 1,),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent,width: 2,),
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                ),
              ),
             const  SizedBox(
                height: 30,
              ),
               Container(
                 width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.blueGrey.shade400,
                  borderRadius: BorderRadius.circular(13)
                ),
                child:
                TextButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));

                },
                    child:Text("Submit",
                      style:TextStyle(
                          color: Colors.black,fontSize: 20),)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
