import 'package:flutter/rendering.dart';
import 'package:music_app/imports_bindings.dart';

class RootController extends GetxController {
  //*scroll controller for hiding bottom nav
  Rx<ScrollController> offlineTracksController = ScrollController().obs;
  Rx<ScrollController> offlineAlbumCotroller = ScrollController().obs;
  //*initail bottom bar height
  RxBool visibleBottom = true.obs;
  //*pages
  final screens = const [OfflineScreen(), OnlineScreen(), SettingsScreen()];
  //*pages curresponding icons for bottomnav
  final icons = const [Icons.download_for_offline_outlined, Icons.podcasts, Icons.settings_outlined];
  //*pages curresponding selected icons for bottomnav
  final selectedIcons = const [Icons.download_for_offline, Icons.podcasts, Icons.settings];
  //*bottomnav current index
  final currentIndex = 0.obs;
  //*chnage page currespondinfg bottom nav
  void Function(int)? changeIndex(int? index) {
    currentIndex.value = index!;
    return null;
  }

  //*hide bottom nav
  void hideBottomNav(ScrollController scrollController) {
    scrollController.addListener(() {
      visibleBottom.value = scrollController.position.userScrollDirection == ScrollDirection.reverse ? false : true;
    });
  }

  @override
  void onInit() {
    hideBottomNav(offlineTracksController.value);
    hideBottomNav(offlineAlbumCotroller.value);
    super.onInit();
  }
}
