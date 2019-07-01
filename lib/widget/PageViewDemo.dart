import 'package:flutter/material.dart';

/**
 * PageViewDemo
 */
class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo>
    with SingleTickerProviderStateMixin {
  PageController pageController = new PageController();
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    ///初始化时创建控制器
    ///通过 with SingleTickerProviderStateMixin 实现动画效果。
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    ///页面销毁时，销毁控制器
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableDemo'),
        brightness: Brightness.light,
        backgroundColor: Colors.teal,
      ),
//      body: PageView.builder(
//        itemBuilder: (BuildContext context, int index) {
//          return Container(
//            child: Center(
//              child: Text('PAGE ${index}'),
//            ),
//          );
//        },
//        itemCount: 5,
//        onPageChanged: (indext) {},
//      ),

      body: _pageView(),
//      body: _tabBarView(),
      bottomNavigationBar: Container(
        height: 40,
        child: Center(
          child: _tabView(),
        ),
      ),
    );
  }

  Widget _tabBarView() {
    return TabBarView(
      children: <Widget>[
        Container(
          color: Colors.blue,
          alignment: AlignmentDirectional.center,
          child: Text('PAGE 1'),
        ),
        Container(
          color: Colors.deepPurpleAccent,
          alignment: AlignmentDirectional.center,
          child: Text('PAGE 2'),
        ),
        Container(
          color: Colors.lightGreen,
          alignment: AlignmentDirectional.center,
          child: Text('PAGE 3'),
        ),
      ],
      controller: _tabController,
    );
  }

  Widget _tabView() {
    return TabBar(
      //可以滑动
      isScrollable: true,
      //边距
      labelPadding: EdgeInsets.only(right: 0),
      //颜色
      labelColor: Colors.orangeAccent,
      //样式 选中的
      labelStyle: TextStyle(fontSize: 18),
      //点击事件
      onTap: (index) {
//        pageController.jumpToPage(index);
//        pageController.jumpTo(MediaQuery.of(context).size.width * index);
        pageController.animateToPage(index,
            duration: Duration(
              milliseconds: 300,
            ),
            curve: Cubic(0, 0, 0, 0));
      },
      //未选中的颜色
      unselectedLabelColor: Colors.pink,
      //未选中样式
      unselectedLabelStyle: TextStyle(fontSize: 14),
      //指示器的宽度
      indicatorSize: TabBarIndicatorSize.tab,
      //指示器颜色
      indicatorColor: Colors.amber,
      //指示器高度
      indicatorWeight: 2,

      tabs: <Widget>[
        Container(
          width: 100,
          height: 40,
          child: Center(
            child: Text('MODEL 1'),
          ),
        ),
        Container(
          width: 100,
          height: 40,
          child: Center(
            child: Text('MODEL 2'),
          ),
        ),
        Container(
          width: 100,
          height: 40,
          child: Center(
            child: Text('MODEL 3'),
          ),
        ),
      ],
      controller: _tabController,
    );
  }

  Widget _pageView() {
    return PageView(
      children: <Widget>[
        Container(
          color: Colors.blue,
          alignment: AlignmentDirectional.center,
          child: Text('PAGE 1'),
        ),
        Container(
          color: Colors.deepPurpleAccent,
          alignment: AlignmentDirectional.center,
          child: Text('PAGE 2'),
        ),
        Container(
          color: Colors.lightGreen,
          alignment: AlignmentDirectional.center,
          child: Text('PAGE 3'),
        ),
      ],
      controller: pageController,
      onPageChanged: (index) {
        _tabController.animateTo(index);
      },
    );
  }
}
