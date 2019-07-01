import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  @override
  _ReListViewDemoState createState() => _ReListViewDemoState();
}

class _ReListViewDemoState extends State<ListViewDemo> {
  int count = 2;
  final ScrollController _scrollController = new ScrollController();

  bool loadMore = false;

  Future refresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        count = 10;
      });
    });
  }

  Future getMore() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        loadMore = false;
        count += 5;
      });
    });
  }

  @override
  void initState() {
    ///增加滑动监听
    _scrollController.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          loadMore = true;
          count += 5;
        });
//        getMore();
      }
    });
    super.initState();
  }

  Widget getItem(int index) {
    if (loadMore && index == count) {
      return LoadMoreItem();
    } else {
      return MoveItem();
    }
  }

  int getItemCount() {
    if (loadMore) {
      return count + 1;
    } else {
      return count;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListViewDemo'),
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      body: RefreshIndicator(
        //刷新进度条颜色
        color: Colors.black45,
        //背景色
        backgroundColor: Colors.blue,
        ////触发下拉刷新的距离 默认40
        displacement: 40,
        //下拉回调方法,方法需要有async和await关键字，没有await，刷新图标立马消失，没有async，刷新图标不会消失
        onRefresh: refresh,
        child: ListView.separated(
          itemBuilder: ((context, index) {
            return MoveItem();
          }),
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.black45,
              height: 10,
            );
          },
          itemCount: count,
          controller: _scrollController,
          //保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}

class _ListViewDemoState extends State<ListViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListViewDemo'),
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      body: Container(
        child: ListView.custom(
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              //前置图标
              leading: new Icon(Icons.list),
              title: new Text('标题 custom'),
              subtitle: new Text('副标题 custom'),
              //后置图标
              trailing: new Icon(Icons.arrow_forward_ios),
              //内容边距
              contentPadding: EdgeInsets.all(10),
            );
          }),
        ),
//        child: ListView.separated(
//          itemBuilder: (context, index) {
//            return ListTile(
//              //前置图标
//              leading: new Icon(Icons.list),
//              title: new Text('标题'),
//              subtitle: new Text('副标题'),
//              //后置图标
//              trailing: new Icon(Icons.arrow_forward_ios),
//              //内容边距
//              contentPadding: EdgeInsets.all(10),
//            );
//          },
//          separatorBuilder: (context, index) {
//            return Divider(
//              color: Colors.black45,
//              height: 10,
//              //左边缩进
//              indent: 50,
//            );
//          },
//          itemCount: 20,
//        ),
//        child: ListView.builder(
//          itemBuilder: (context, index) {
//            return ListTile(
//              //前置图标
//              leading: new Icon(Icons.list),
//              title: new Text('标题'),
//              subtitle: new Text('副标题'),
//              //后置图标
//              trailing: new Icon(Icons.arrow_forward_ios),
//              //内容边距
//              contentPadding: EdgeInsets.all(10),
//            );
//          },
//          //数量
//          itemCount: 10,
//          //内容适配
//          shrinkWrap: true,
//          //内边距
//          padding: EdgeInsets.only(left: 10),
//          //是否倒叙
//          reverse: false,
//          //item 高度 让item加载更加高效
//          itemExtent: 50,
//
//          //滑动方式
//          //AlwaysScrollableScrollPhysics() 总是可以滑动
//          //NeverScrollableScrollPhysics禁止滚动
//          //BouncingScrollPhysics 内容超过一屏 上拉有回弹效果
//          //ClampingScrollPhysics 包裹内容 不会有回弹
//          physics: BouncingScrollPhysics(),
//          //预加载
//          cacheExtent: 10,
//        ),
//        child: ListView.builder(
//          itemBuilder: (context, index) {
//            return new Text('标题');
//          },
//          itemCount: 10,
//          padding: EdgeInsets.all(4),
//        ),
      ),
    );
  }
}

class LoadMoreItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Text('加载中'),
      ),
    );
  }
}

class MoveItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              'http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg',
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                '狄仁杰之四大天王',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text('豆瓣评分6.6'),
              Text('类型：动作、惊悚、冒险'),
              Text('导演：徐克'),
              Row(
                children: <Widget>[
                  Text('主演：'),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg'),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg'),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
