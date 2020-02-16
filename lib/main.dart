import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/chat/IncomingPictureMessage.dart';
import 'package:flutter_chat_ui/chat/IncomingTextMessage.dart';
import 'package:flutter_chat_ui/chat/ListItem.dart';
import 'package:flutter_chat_ui/chat/OutgoingPictureMessage.dart';
import 'package:flutter_chat_ui/chat/OutgoingTextMessage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'ProximaNova',
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<ListItem> conversion = getMyConversation();

  MyHomePage({String title});

  @override
  State<StatefulWidget> createState() {
    return HomePage(conversion);
  }
}

class HomePage extends State<MyHomePage> {
  TextEditingController messageController = TextEditingController();

  List<ListItem> conversion = <ListItem>[];

  HomePage(this.conversion);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLUTTER CHAT UI"),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: conversion.length,
                itemBuilder: (context, index) {
                  ListItem item = conversion[index];

                  if (item is IncomingTextMessage) {
                    IncomingTextMessage textMessage = item;
                    return IncomingTextMessageWidget(textMessage);
                  } else if (item is IncomingPictureMessage) {
                    IncomingPictureMessage pictureMessage = item;
                    return IncomingPictureMessageWidget(pictureMessage);
                  } else if (item is OutgoingTextMessage) {
                    OutgoingTextMessage textMessage = item;
                    return OutgoingTextMessageWidget(textMessage);
                  } else {
                    OutgoingPictureMessage pictureMessage = item;
                    return OutgoingPictureMessageWidget(pictureMessage);
                  }
                },
              ),
            ),
            Stack(
              children: <Widget>[
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Your message here",
                      alignLabelWithHint: false),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: GestureDetector(
                      onTap: () {
                        print("OnTap");
                        setState(() {
                          String message = messageController.text.toString();
                          conversion.add(OutgoingTextMessage(message));
                        });
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.teal,
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    super.dispose();
  }
}

Widget IncomingTextMessageWidget(IncomingTextMessage textMessage) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
    child: Wrap(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              "images/user_picture.png",
              width: 30,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(textMessage.message),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget IncomingPictureMessageWidget(IncomingPictureMessage pictureMessage) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    child: Wrap(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Positioned(
              child: Image.asset(
                "images/user_picture.png",
                width: 30,
                height: 30,
              ),
              top: 0,
              left: 0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(pictureMessage.picture),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget OutgoingTextMessageWidget(OutgoingTextMessage textMessage) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    child: Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(textMessage.message),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
            child: Text(
              "Me",
              style: TextStyle(color: Colors.teal, fontSize: 12.0),
            ),
          )
        ],
      ),
    ),
  );
}

Widget OutgoingPictureMessageWidget(OutgoingPictureMessage pictureMessage) {
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Wrap(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(pictureMessage.picture),
            ),
          ),
        ],
      ),
    ),
  );
}

List<ListItem> getMyConversation() {
  var conversation = <ListItem>[];
  String senderPicture = "images/user_picture.png";
  conversation.add(IncomingTextMessage("Hello Ali", senderPicture));
  conversation.add(OutgoingTextMessage("Hello Ahmad"));

  conversation.add(IncomingTextMessage("How are you?", senderPicture));
  conversation.add(OutgoingTextMessage("I am good"));

  conversation
      .add(IncomingPictureMessage("images/trekking.png", senderPicture));
  conversation.add(IncomingTextMessage("Let's go for walk", senderPicture));

  conversation.add(OutgoingPictureMessage("images/happy.png"));
  conversation.add(OutgoingTextMessage("Let's go"));

  return conversation;
}
