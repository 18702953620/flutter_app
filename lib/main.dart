import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/net/NetDemo.dart';
import 'package:flutter_app/widget/BannerDemo.dart';
import 'package:flutter_app/widget/BaseDemo.dart';
import 'package:flutter_app/widget/ListViewDemo.dart';
import 'package:flutter_app/widget/LoginDemo.dart';
import 'package:flutter_app/widget/PageViewDemo.dart';
import 'package:flutter_app/widget/StatusDemo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'base': (BuildContext context) {
          return BaseDemo();
        },
        'login': (BuildContext context) {
          return LoginDemo();
        }
      },
      title: 'Flutter Demo',
      home: MainDemo(),
      theme: ThemeData(primaryColor: Colors.green),
    );
  }
}

class MainDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FlutterDemo'),
          brightness: Brightness.dark,
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('BaseWidget'),
                onPressed: () {
                  Navigator.pushNamed(context, 'base');
                },
              ),
              RaisedButton(
                child: Text('ListView'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return ListViewDemo();
                  }));
                },
              ),
              RaisedButton(
                child: Text('PageView'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return PageViewDemo();
                  }));
                },
              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return LoginDemo(tel: '18700000000');
                  })).then((onValue) {
                    buildDialog(context, onValue);
                  });

//                  Navigator.pushNamed(context, 'login').then((onValue) {
//                    buildDialog(context, onValue);
//                  });
                },
              ),
              RaisedButton(
                child: Text('NetView'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return NetDemo();
                  }));
                },
              ),
              RaisedButton(
                child: Text('StatusBar'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return StatusDemo();
                  }));
                },
              ),
              RaisedButton(
                child: Text('Banner'),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return BannerDemo();
                  }));
                },
              ),
            ],
          ),
        ));
  }

  void buildDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext content) {
        return AlertDialog(
          title: Text("提示"),
          content: Text(text),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                child: Text('关闭'),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
