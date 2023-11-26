import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text(
            'User Profile',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'playfair',
                fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                decoration:    BoxDecoration(
                     color: Colors.black,
                    borderRadius: BorderRadius.circular(10)

                ),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                height: 120,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration:
                          BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                    ),
                    const Padding(
                      padding:  EdgeInsets.all(15.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'M. Ahsan',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                          ),
                          Text(
                            'ahsan@gmail.com',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '03107596525',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('setting'),
                    ),
                    ListTile(
                      leading: Icon(Icons.question_answer),
                      title: Text("FAQ's"),
                    ),
                    ListTile(
                      leading: Icon(Icons.support),
                      title: Text('support'),
                    ),

                  ],
                ),
              )
            ],
          ),
        ));
  }
}
