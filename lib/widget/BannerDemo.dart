import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/**
 * 轮播图
 */
class BannerDemo extends StatefulWidget {
  @override
  _BannerDemoState createState() => _BannerDemoState();
}

class _BannerDemoState extends State<BannerDemo> {
  PageController pageController = new PageController();
  Timer _timer;
  int count = 3;
  int currentPosition = 0;

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(Duration(seconds: 2), (time) {
      changePage();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableDemo'),
        brightness: Brightness.light,
        backgroundColor: Colors.teal,
      ),
      body: _pageView(),
    );
  }

  Widget _swiper() {
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        return new Image.network(
          "http://img4.imgtn.bdimg.com/it/u=1621655683,865218969&fm=200&gp=0.jpg",
          fit: BoxFit.fitWidth,
          height: 150,
        );
      },
      itemCount: 3,
      //动画时间，默认300.0毫秒
      duration: 300,
      //初始位置
      index: 0,
      //无限轮播模式开关
      loop: true,
      //是否自动播放，默认false
      autoplay: true,
      layout: SwiperLayout.DEFAULT,
      //滚动方式
      scrollDirection: Axis.horizontal,
      //点击轮播的事件
      onTap: (index) {},
      //用户拖拽的时候，是否停止自动播放
      autoplayDisableOnInteraction: true,
      //指示器
      pagination: new SwiperPagination(),
      //左右箭头
      control: null,
    );
  }

  Widget _pageView() {
    return PageView(
      children: <Widget>[
        Image.network(
          'http://img4.imgtn.bdimg.com/it/u=1621655683,865218969&fm=200&gp=0.jpg',
          height: 150,
          fit: BoxFit.fitWidth,
        ),
        Image.network(
          'http://img1.imgtn.bdimg.com/it/u=1901690610,3955011377&fm=200&gp=0.jpg',
          height: 150,
          fit: BoxFit.fitWidth,
        ),
        Image.network(
          'http://img3.imgtn.bdimg.com/it/u=1546158593,2358526642&fm=200&gp=0.jpg',
          height: 150,
          fit: BoxFit.fitWidth,
        ),
      ],
      controller: pageController,
      onPageChanged: (index) {
        _timer.cancel();
        currentPosition = index;
        _timer = new Timer.periodic(Duration(seconds: 2), (time) {
          changePage();
        });
      },
    );
  }

  void changePage() {
    if (currentPosition != 0 && currentPosition % count == 0) {
      pageController.animateToPage(currentPosition % count,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);

      pageController.jumpToPage(0);
      //倒数第1页
    } else {
      pageController.animateToPage(currentPosition % count,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    }
    currentPosition++;
  }
}
