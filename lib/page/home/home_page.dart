import 'package:animate_do/animate_do.dart';
import 'package:d_tv/model/video.dart';
import 'package:d_tv/page/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// 首页 轮播图 + 底部 缩略图
class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (value) {
        if (value is KeyDownEvent) {
          if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
            //debugPrint("左");
            FocusScope.of(context).focusInDirection(TraversalDirection.left);
          } else if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
            //debugPrint("右");
            FocusScope.of(context).focusInDirection(TraversalDirection.right);
          } else if (value.logicalKey == LogicalKeyboardKey.arrowUp) {
            //debugPrint("上");
            FocusScope.of(context).focusInDirection(TraversalDirection.up);
          } else if (value.logicalKey == LogicalKeyboardKey.arrowDown) {
            //debugPrint("下");
            FocusScope.of(context).focusInDirection(TraversalDirection.down);
          }
        }
      },
      child: FocusScope(
        child: Stack(
          fit: StackFit.expand,
          children: [
            buildBackground(),
            Positioned(
              left: 20,
              bottom: 20,
              right: 20,
              child: buildItems(),
            )
          ],
        ),
      ),
    );
  }

  /// 背景图区域 - 轮播
  Widget buildBackground() {
    return Obx(
      () => FadeIn(
        duration: Durations.extralong1,
        controller: (animate) {
          return controller.backgroundController = animate;
        },
        child: Image.asset(
          controller.videos[controller.selectIndex.value].image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// 底部选项
  Widget buildItems() {
    return FadeInUp(
      duration: Durations.extralong1,
      controller: (animate) {
        return controller.menuController = animate;
      },
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: controller.videos.length,
          itemBuilder: (context, index) {
            return buildItem(index, focus: index == 0);
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 20,
          ),
        ),
      ),
    );
  }

  /// 单项
  Widget buildItem(int index, {bool focus = false}) {
    Video video = controller.videos[index];
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.accept ||
              event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter) {
            controller.play(video);
            node.requestFocus();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      onFocusChange: (value) {
        if (value) {
          controller.select(index);
          debugPrint("获得焦点:${video.image}");
        }
      },
      autofocus: focus,
      child: Builder(
        builder: (context) {
          FocusNode node = Focus.of(context);
          return GestureDetector(
            onTap: () {
              if (!node.hasFocus) {
                node.requestFocus();
              } else {
                controller.play(video);
                node.requestFocus();
              }
            },
            child: AnimatedPadding(
              padding: node.hasFocus
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(top: 20),
              duration: Durations.short3,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(video.image),
                    ),
                  ),
                  child: node.hasFocus
                      ? const Icon(
                          Icons.play_circle,
                          size: 40,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
