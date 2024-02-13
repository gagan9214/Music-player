import 'package:music_app/imports_bindings.dart';

class TracksTab extends GetView<OfflineController> {
  const TracksTab({required this.scrollController, Key? key}) : super(key: key);
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<SortTypeModel>(
                  initialValue: controller.tracksSortType.value,
                  child: Button.label(label: controller.tracksSortType.value.label, icon: controller.tracksSortType.value.icon),
                  onSelected: (sortType) => controller.sortSongs(sortTypeModel: sortType, isAlbum: false),
                  itemBuilder: (context) => AppData.sortTypeOptions
                      .map((e) => PopupMenuItem<SortTypeModel>(
                          value: e, child: Button.label(label: e.label, icon: e.icon, iconColor: context.theme.scaffoldBackgroundColor, labelColor: context.theme.scaffoldBackgroundColor)))
                      .toList()).paddingSymmetric(horizontal: 8.r),
              PopupMenuButton<SortOrderModel>(
                  initialValue: controller.tracksSortOrder.value,
                  child: Button.label(label: controller.tracksSortOrder.value.label, icon: controller.tracksSortOrder.value.icon),
                  onSelected: (sortOrder) => controller.sortSongs(sortOrderModel: sortOrder, isAlbum: false),
                  itemBuilder: (context) => AppData.sortOrderOPtions
                      .map((e) => PopupMenuItem<SortOrderModel>(
                          value: e, child: Button.label(label: e.label, icon: e.icon, iconColor: context.theme.scaffoldBackgroundColor, labelColor: context.theme.scaffoldBackgroundColor)))
                      .toList()).paddingSymmetric(horizontal: 8.r),
            ],
          ).paddingSymmetric(horizontal: 24.r),
          Expanded(
            child: controller.obx(
              onLoading: Center(child: Kwidgets.loading),
              (state) {
                if (controller.tracks.isEmpty) {
                  return Center(child: Kwidgets.noAudios);
                }
                return ListView.builder(
                  itemCount: controller.tracks.length,
                  shrinkWrap: true,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Obx(() => SongTile(
                        isSelected: controller.playerController.isSelected(index: index, songModels: controller.tracks),
                        onTap: () => controller.playerController.selectedSong.value?.id == controller.tracks[index].id
                            ? Get.toNamed(Routes.playerScreen)
                            : controller.playerController.playSong(songsModels: controller.tracks, index: index),
                        songModel: controller.tracks[index],
                      )),
                ).paddingSymmetric(vertical: 8.r);
              },
            ),
          ),
        ],
      ),
    );
  }
}
