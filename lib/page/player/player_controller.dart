import 'package:d_tv/model/video.dart' as model;
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

/// TV端(电视机) - 电视直播页面控制器
class PlayerPageController extends GetxController with StateMixin {
  // 播放器
  late final player = Player();

  // 播放控制器
  late final mediaKitController = VideoController(player);

  @override
  void onInit() {
    super.onInit();
    //Media('asset:///assets/videos/sample.mp4')
    model.Video source = Get.arguments;
    player.open(Media(source.url));
  }

  @override
  void onClose() {
    super.onClose();
    player.stop();
    player.dispose();
  }
}
