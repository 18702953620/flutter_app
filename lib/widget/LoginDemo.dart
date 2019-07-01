import 'package:flutter/material.dart';

/**
 * 登录demo
 */
class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState(tel);

  final String tel;

  LoginDemo({Key key, @required this.tel}) : super(key: key);
}

class _LoginDemoState extends State<LoginDemo> {
  String tel;

  _LoginDemoState(this.tel);

  TextEditingController user = new TextEditingController();
  TextEditingController pwd = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      user.text = tel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginDemo'),
        actions: <Widget>[
          GestureDetector(
            child: OutlineButton(
                onPressed: () {
                  Navigator.of(context).pop('0000000');
                },
                child: Text(
                  '保存',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100),
            ),
            TextField(
              controller: user,
              decoration: InputDecoration(
                  hintText: '请输入账户',
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            TextField(
              controller: pwd,
              //显示*号
              obscureText: true,

              decoration: InputDecoration(
                  hintText: '请输入密码',
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            FlatButton(
              onPressed: () {
                //显示弹窗
                _showDialog(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(color: Colors.deepOrangeAccent),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    '登录',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      backgroundColor: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
                child: Text('重新输入'),
              ),
              onTap: () {
                pwd.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    if (pwd.text.length < 6) {
      buildDialog(context, '输入的密码不能小于6位');
    } else {
      buildDialog(context, '输入的账户是' + user.text + ",输入的密码是" + pwd.text);
    }
  }
}
