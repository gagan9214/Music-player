import 'package:music_app/imports_bindings.dart';

class AlbumsTab extends GetView<OfflineController> {
  const AlbumsTab({required this.scrollController, Key? key}) : super(key: key);
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
                  initialValue: controller.albumsSortType.value,
                  child: Button.label(label: controller.albumsSortType.value.label, icon: controller.albumsSortType.value.icon),
                  onSelected: (sortType) => controller.sortSongs(sortTypeModel: sortType, isAlbum: true),
                  itemBuilder: (context) => AppData.sortTypeOptions
                      .map((e) => PopupMenuItem<SortTypeModel>(
                          value: e, child: Button.label(label: e.label, icon: e.icon, iconColor: context.theme.scaffoldBackgroundColor, labelColor: context.theme.scaffoldBackgroundColor)))
                      .toList()).paddingSymmetric(horizontal: 8.r),
              PopupMenuButton<SortOrderModel>(
                  initialValue: controller.albumsSortOrder.value,
                  child: Button.label(label: controller.albumsSortOrder.value.label, icon: controller.tracksSortOrder.value.icon),
                  onSelected: (sortOrder) => controller.sortSongs(sortOrderModel: sortOrder, isAlbum: true),
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
                  itemCount: controller.albums.length,
                  shrinkWrap: true,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Obx(() => SongTile(
                        isSelected: controller.playerController.isSelected(index: index, songModels: controller.albums),
                        onTap: () => controller.playerController.selectedSong.value?.id == controller.albums[index].id
                            ? Get.toNamed(Routes.playerScreen)
                            : controller.playerController.playSong(songsModels: controller.albums, index: index),
                        songModel: controller.albums[index],
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
