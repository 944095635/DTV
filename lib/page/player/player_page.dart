import 'package:d_tv/page/player/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlayerPage extends GetView<PlayerPageController> {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlayerPageController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (value) {
          if (value is KeyDownEvent) {
            if (value.logicalKey == LogicalKeyboardKey.backspace ||
                value.logicalKey == LogicalKeyboardKey.escape) {
              Get.back();
            }
          }
        },
        child: SizedBox.expand(
          child: buildMediaKit(),
        ),
      ),
    );
  }

  /// 播放器主体
  buildMediaKit({bool showController = true}) {
    Video video = Video(
      controller: controller.mediaKitController,
    );
    if (!showController) {
      return video;
    }
    return MaterialVideoControlsTheme(
      normal: MaterialVideoControlsThemeData(
        volumeGesture: true,
        brightnessGesture: true,
        displaySeekBar: false,
        seekOnDoubleTap: false,
        buttonBarButtonSize: 32.0,
        buttonBarButtonColor: Colors.white,
        primaryButtonBar: [],
        topButtonBar: [
          MaterialCustomButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          const Spacer(),
          MaterialCustomButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
        bottomButtonBar: [
          const MaterialDesktopPlayOrPauseButton(),
          const Spacer(),
          const MaterialFullscreenButton(),
        ],
      ),
      fullscreen: const MaterialVideoControlsThemeData(
        // Modify theme options:
        displaySeekBar: false,
        primaryButtonBar: [
          MaterialPlayOrPauseButton(
            iconSize: 48,
          )
        ],
        automaticallyImplySkipNextButton: false,
        automaticallyImplySkipPreviousButton: false,
      ),
      child: video,
    );
  }
}
