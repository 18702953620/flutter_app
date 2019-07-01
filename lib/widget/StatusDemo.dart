import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class StatusDemo extends StatefulWidget {
  @override
  _StatusDemoState createState() => _StatusDemoState();
}

class _StatusDemoState extends State<StatusDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AsynDemo(),
//      onWillPop: () {
      ///如果返回 return new Future.value(false); popped 就不会被处理
      ///如果返回 return new Future.value(true); popped 就会触发
      ///这里可以通过 showDialog 弹出确定框，在返回时通过 Navigator.of(context).pop(true);决定是否退出
//        return showExitDialog(context);
//      },
    );
  }

  Future<bool> showExitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext content) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("确认退出吗？"),
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  child: Text('退出'),
                ),
                onTap: () {
                  Navigator.of(context).pop(true);
                },
              ),
              GestureDetector(
                child: Container(
                  child: Text('取消'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class AsynDemo extends StatefulWidget {
  @override
  _AsynDemoState createState() => _AsynDemoState();
}

class _AsynDemoState extends State<AsynDemo> {
  String value = '000';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text(
              '执行',
            ),
            color: Colors.teal,
            onPressed: () {
              setValue();
            },
          ),
          Text('结果是：$value'),
        ],
      ),
    );
  }

  Future delayed() async {
    await new Future.delayed(new Duration(milliseconds: 3000), () {
      value = '111';
      print('delayed value $value');
    });
  }

  setValue() {
    delayed().then((v) {
      print('then $value');
      setState(() {
        print('setValue $value');
      });
    });
//    await delayed();
//
//    setState(() {
//      print('setValue  value $value');
//    });
  }
}

class TakeDemo extends StatefulWidget {
  @override
  _TakeDemoState createState() => _TakeDemoState();
}

class _TakeDemoState extends State<TakeDemo> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20),
      alignment: AlignmentDirectional.center,
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              getImage();
            },
            child: Text('从相册选择'),
          ),
          Center(
            child: _image == null
                ? Text(
                    'No image selected.',
                    style: TextStyle(fontSize: 14),
                  )
                : Image.file(_image),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
}

/**
 * 状态栏
 */
class StatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        child: Column(
          children: <Widget>[
            Container(
              //状态栏高度
              height: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .padding
                  .top,
//            color: Colors.blue,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.cyan, Colors.brown, Colors.deepOrange],
              )),
            ),
            Container(
              height: 200,
              color: Colors.brown,
              alignment: AlignmentDirectional.center,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      FutureBuilder<File>(
                        future:
                            ImagePicker.pickImage(source: ImageSource.gallery),
                        builder: (BuildContext context,
                            AsyncSnapshot<File> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data != null) {
                            return Container(
                              child:
                                  Image.file(snapshot.data, fit: BoxFit.cover),
                            );
                          }
                        },
                      );
                    },
                    child: Text('从相册选择'),
                  ),
                ],
              ),
            ),
          ],
        ),
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.cyan,
            //有Appbar时，会被覆盖
            statusBarIconBrightness: Brightness.light,
            //底部navigationBar背景颜色
            systemNavigationBarColor: Colors.white),
      ),
    );
  }
}
