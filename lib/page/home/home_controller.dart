import 'package:d_tv/model/video.dart';
import 'package:d_tv/page/player/player_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 首页 -  控制器
class HomePageController extends GetxController
    with StateMixin, GetTickerProviderStateMixin {
  RxInt selectIndex = 0.obs;

  List<Video> videos = [
    Video(url: 'asset:///assets/video/hsh.mp4', image: 'assets/image/bg1.jpg'),
    Video(url: 'asset:///assets/video/hsh.mp4', image: 'assets/image/bg2.jpg'),
    Video(url: 'asset:///assets/video/afd.mp4', image: 'assets/image/bg3.jpg'),
    Video(url: 'asset:///assets/video/tuzi.mp4', image: 'assets/image/bg4.jpg')
  ];

  /// 背景动画切换
  AnimationController? backgroundController;

  /// 菜单控制器
  AnimationController? menuController;

  @override
  void onClose() {
    super.onClose();
    menuController?.dispose();
    backgroundController?.dispose();
  }

  /// 菜单切换
  void select(int index) {
    backgroundController?.reset();
    selectIndex.value = index;
  }

  void play(Video video) async {
    /// 让背景 黑下去 ，让菜单 隐藏
    menuController?.reverse();
    await backgroundController?.reverse();
    ////跳转到播放页面
    await Get.to(
      () => const PlayerPage(),
      transition: Transition.fadeIn,
      arguments: video,
    );
    await Future.delayed(Durations.short4);
    menuController?.forward();
    backgroundController?.forward();
  }
}
