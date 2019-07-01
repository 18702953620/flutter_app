import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/BaseModel.dart';
import 'package:flutter_app/model/ExpertModel.dart';

class NetDemo extends StatefulWidget {
  @override
  _NetDemoState createState() => _NetDemoState();
}

class _NetDemoState extends State<NetDemo> {
  var jsonString;
  List<ExpertModel> data;

  Map<String, dynamic> map = new Map();
  String name = 'Wang' 'Jianfei';

  @override
  void initState() {
    super.initState();
  }

  void getData() {
    Dio dio = new Dio();
    dio.request(
      'https://www.yfbr2018.com/module/index.php?ctl=user&act=expertList',
      data: {"p", "1"},
    ).then((onValue) {
      print(onValue);
//      //dynamic 代表动态数据类型 即可以是数字、字符串等
//      Map<String, dynamic> list = json.decode(onValue.toString());
      BaseModel<List<ExpertModel>> baseModel =
          BaseModel<List<ExpertModel>>.fromJson(onValue.toString());

      setState(() {
        jsonString = onValue;
        data = baseModel.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NetDemo'),
        actions: <Widget>[
          RaisedButton(
            child: Text('发起请求'),
            onPressed: () {
              getData();
            },
          ),
        ],
      ),
      body: Container(
        child: Text('$jsonString'),
      ),
//      body: _listView(),
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return MoveItem(data[index]);
      },
      itemCount: data.length,
    );
  }
}

class MoveItem extends StatelessWidget {
  ExpertModel model;

  MoveItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              'http://chuangfen.oss-cn-hangzhou.aliyuncs.com' +
                  model.head_image,
              width: 100,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '${model.nick_name}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text('${model.signature}'),
            ],
          ),
        ],
      ),
    );
  }
}
