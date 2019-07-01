import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * 基础Widget
 */
class BaseDemo extends StatefulWidget {
  @override
  _BaseDemoState createState() => _BaseDemoState();
}

class _BaseDemoState extends State<BaseDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ContainerDemo(),
    );
  }

}


class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        textDirection: TextDirection.ltr,
        //以整个组件的中心为坐标原点，x、y 偏移量取值范围为 [-1,1]，
        // 如果 x 的偏移量大于 0，则表示向右偏移，小于 0 则向左偏移；
        // 如果 y 轴的偏移量大于 0 则向下偏移，小于 0 则向上偏移。
//        alignment: Alignment(0, 0),
        //AlignmentDirectional.topStart:垂直靠顶部水平靠左对齐
        //AlignmentDirectional.topCenter：垂直靠顶部水平居中对齐
        //AlignmentDirectional.topEnd：垂直靠顶部水平靠右对齐
        //AlignmentDirectional.centerStart：垂直居中水平靠左对齐
        //AlignmentDirectional.center：垂直和水平居中都对齐
        //AlignmentDirectional.centerEnd：垂直居中水平靠右对齐
        //AlignmentDirectional.bottomStart：垂直靠底部水平靠左对齐
        //AlignmentDirectional.bottomCenter：垂直靠底部水平居中对齐
        //AlignmentDirectional.bottomEnd：垂直靠底部水平靠右对齐
//        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          Container(
            color: Colors.black54,
            child: Text(
              '1111111',
            ),
          ),
          Positioned(
            top: 100,
            child: Text(
              '111FFFFg',
              style: TextStyle(
                fontSize: 18,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
          Positioned(
            child: Text('2222222222222222'),
            right: 100,
            width: 100,
            top: 100,
          )
        ],
      ),
    );
  }
}

class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContainerDemo'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 10, right: 20),
//        color: Colors.orangeAccent,
        decoration: new BoxDecoration(
            //设置了decoration的color，就不能设置Container的color，否则会报错
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: new Border.all(width: 10, color: Colors.blue)),
        child: Column(
          //Column 垂直方向，Row 水平方向
          mainAxisAlignment: MainAxisAlignment.center,
          //max相当于match_parent，min相当于wrap_content
          mainAxisSize: MainAxisSize.max,

          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              color: Colors.black54,
              child: Text(
                '1111111',
              ),
            ),
            Text(
              '111FFFFg',
              style: TextStyle(
                fontSize: 18,
                backgroundColor: Colors.black54,
              ),
            ),
            Text('222'),
            Text('333'),
          ],
        ),
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DemoPage'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.cyan, Colors.brown, Colors.deepOrange],
          )),
        ),
      ),
      body: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 10, right: 20),
//        color: Colors.orangeAccent,
        decoration: new BoxDecoration(
            //设置了decoration的color，就不能设置Container的color，否则会报错
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: new Border.all(width: 10, color: Colors.blue)),

        child: Text(
          //文本
          '我是Text我是Text我是Text我是Text我是Text我是Text我是Text我是Text我是Text我是Text',
          //超出屏幕 clip裁剪，fade渐隐，ellipsis省略号
          overflow: TextOverflow.ellipsis,
          //对齐方式
          textAlign: TextAlign.center,
          //文本方向
          textDirection: TextDirection.rtl,
          //样式
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 14,
            fontStyle: FontStyle.italic,
            backgroundColor: Colors.black87,
            //none无文字装饰，lineThrough删除线，overline文字上面显示线，underline文字下面显示线
            decoration: TextDecoration.lineThrough,
            //字母间隙
            letterSpacing: 10,
          ),
        ),
      ),
    );
  }
}

class TextFieldDemo extends StatefulWidget {
  @override
  _TextFieldDemoState createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          elevation: 0,
//          brightness: Brightness.light,
//          backgroundColor: Colors.deepOrange,
//        ),
        body: Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        //键盘输入方式
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          //提示文字
          hintText: '请输入手机号',
          //内容边距
          contentPadding: EdgeInsets.all(10),
          //提示文字样式
          hintStyle: TextStyle(color: Colors.deepOrangeAccent, fontSize: 18),
          //边框
          border: OutlineInputBorder(
            //圆角
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: Colors.deepOrange),
          ),
        ),
        //文字改变时调用
        onChanged: (String content) {
          print("content=" + content);
        },
        //光标颜色
        cursorColor: Colors.deepOrangeAccent,
        //光标圆角
        cursorRadius: Radius.circular(4),
        //光标宽度
        cursorWidth: 2,
      ),
    ));
  }
}
