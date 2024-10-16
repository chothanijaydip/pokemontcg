import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_theme.dart';
import '../../home_view/ui/post_item.dart';
import '../controller/details_view_controller.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailsViewController controller = Get.find<DetailsViewController>();
  double titleSize = 100.w;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                Obx(() {
                  return controller.pokemonDetails.value.id
                              .toString()
                              .isNotEmpty &&
                          controller.pokemonDetails.value.images != null
                      ? FutureBuilder(
                          future: controller.getImagePalette(
                              CachedNetworkImageProvider(controller
                                  .pokemonDetails.value.images!.large
                                  .toString())),
                          builder: (context, builder) {
                            return SliverAppBar(
                              expandedHeight: Get.height * .4,
                              floating: false,
                              pinned: true,
                              elevation: 0,
                              backgroundColor: builder.data?.withOpacity(0.4),
                              iconTheme:
                                  const IconThemeData(color: AppColor.black),
                              flexibleSpace: FlexibleSpaceBar(
                                title: Text(
                                  controller.pokemonDetails.value.name
                                          .toString()
                                          .isNotEmpty
                                      ? controller.pokemonDetails.value.name
                                          .toString()
                                      : 'Pokemon Details',
                                  style: AppTextStyle.text25w600
                                      .copyWith(color: AppColor.black),
                                ),
                                titlePadding: EdgeInsets.only(bottom: 60.w),
                                background:
                                    controller.pokemonDetails.value.images !=
                                            null
                                        ? BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 36.0, sigmaY: 36.0),
                                            child: Container(
                                              height: Get.height * .3,
                                              margin: EdgeInsets.only(
                                                  top: 70.w, bottom: 100.w),
                                              child: PostItemImage(
                                                imageLink: controller
                                                    .pokemonDetails
                                                    .value
                                                    .images!
                                                    .large
                                                    .toString(),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: Get.height * .3,
                                          ),
                              ),
                              bottom: PreferredSize(
                                  preferredSize: Size(Get.width, 45.w),
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                        color: AppColor.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: TabBar(
                                                unselectedLabelColor:
                                                    Colors.black54,
                                                indicatorColor: AppColor.black,
                                                labelColor: AppColor.black,
                                                indicatorSize:
                                                    TabBarIndicatorSize.tab,
                                                isScrollable: true,
                                                labelPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16.w,
                                                        vertical: 16.w),
                                                automaticIndicatorColorAdjustment:
                                                    true,
                                                tabs: const [
                                                  Text("About"),
                                                  Text("Attacks"),
                                                  Text("Weaknesses"),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          })
                      : SliverAppBar(
                          expandedHeight: Get.height * .4,
                          floating: false,
                          pinned: true,
                          elevation: 0,
                          iconTheme: const IconThemeData(color: AppColor.black),
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(
                              controller.pokemonDetails.value.name
                                      .toString()
                                      .isNotEmpty
                                  ? controller.pokemonDetails.value.name
                                      .toString()
                                  : 'Pokemon Details',
                              style: AppTextStyle.text25w600
                                  .copyWith(color: AppColor.black),
                            ),
                            titlePadding: EdgeInsets.only(bottom: 25.w),
                            background:
                                controller.pokemonDetails.value.images != null
                                    ? Container(
                                        height: Get.height * .3,
                                        margin: EdgeInsets.all(70.w),
                                        child: PostItemImage(
                                          imageLink: controller.pokemonDetails
                                              .value.images!.large
                                              .toString(),
                                        ),
                                      )
                                    : Container(
                                        height: Get.height * .3,
                                      ),
                          ),
                        );
                }),
              ];
            },
            body: Obx(() {
              return controller.pokemonDetails.value.id.toString().isNotEmpty
                  ? TabBarView(
                      children: [
                        _aboutTab(),
                        _attackTab(),
                        _weaknessesTab(),
                      ],
                    )
                  : Container();
            }),
          ),
        ));
  }

  Widget _aboutTab() {
    return Wrap(
      runSpacing: 12.w,
      children: [
        if (controller.pokemonDetails.value.set != null)
          _setDataTile(
              title: "Name",
              body: controller.pokemonDetails.value.set!.name.toString()),
        _setDataTile(
            title: "Supertype",
            body: controller.pokemonDetails.value.supertype.toString()),
        if (controller.pokemonDetails.value.types != null)
          _setDataTile(
              title: "Type",
              body:
                  controller.pokemonDetails.value.types!.join(", ").toString()),
        if (controller.pokemonDetails.value.subtypes != null)
          _setDataTile(
              title: "Sub Type",
              body: controller.pokemonDetails.value.subtypes!
                  .join(", ")
                  .toString()),
        _setDataTile(
            title: "Hp", body: controller.pokemonDetails.value.hp.toString()),
        if (controller.pokemonDetails.value.set != null)
          _setDataTile(
              title: "Series",
              body: controller.pokemonDetails.value.set!.series.toString()),
        _setDataTile(
            title: "Evolves From",
            body: controller.pokemonDetails.value.evolvesFrom.toString()),
        if (controller.pokemonDetails.value.set != null)
          _setDataTile(
              title: "Artist",
              body: controller.pokemonDetails.value.artist.toString()),
        _setDataTile(
            title: "Rarity",
            body: controller.pokemonDetails.value.rarity.toString()),
        if (controller.pokemonDetails.value.flavorText.toString().isNotEmpty)
          SizedBox(
            width: titleSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "More",
                  style: AppTextStyle.text12w500
                      .copyWith(color: Colors.grey.shade700),
                ),
                Container(
                  height: 1.w,
                  width: 30.w,
                  margin: EdgeInsets.only(top: 10.w),
                  color: Colors.black,
                )
              ],
            ),
          ),
        if (controller.pokemonDetails.value.flavorText.toString().isNotEmpty)
          Text(
            controller.pokemonDetails.value.flavorText.toString(),
            textAlign: TextAlign.justify,
            style: AppTextStyle.text14w600,
          )
      ],
    ).paddingAll(16.w);
  }

  Widget _attackTab() {
    return Wrap(
      runSpacing: 12.w,
      children: [
        ...(controller.pokemonDetails.value.attacks ?? []).map(
          (e) {
            return Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                        color: Colors.grey.shade300)
                  ]),
              child: Wrap(
                runSpacing: 10.w,
                children: [
                  _setData2Tile(title: "Name", body: e.name.toString()),
                  _setData2Tile(
                      title: "Cost", body: e.cost!.join(", ").toString()),
                  _setData2Tile(title: "Damage", body: e.damage.toString()),
                  _setData2Tile(
                      title: "Converted Energy Cost",
                      body: e.convertedEnergyCost.toString()),
                  if (e.text.toString().isNotEmpty)
                    SizedBox(
                      width: titleSize,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "More",
                            style: AppTextStyle.text12w500
                                .copyWith(color: Colors.grey.shade700),
                          ),
                          Container(
                            height: 1.w,
                            width: 30.w,
                            margin: EdgeInsets.only(top: 10.w),
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  if (e.text.toString().isNotEmpty)
                    Text(
                      e.text.toString(),
                      textAlign: TextAlign.justify,
                      style: AppTextStyle.text14w600,
                    )
                ],
              ),
            );
          },
        )
      ],
    ).paddingAll(16.w);
  }

  Widget _weaknessesTab() {
    return Wrap(
      runSpacing: 12.w,
      children: [
        ...(controller.pokemonDetails.value.weaknesses ?? []).map(
          (e) {
            return Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                        color: Colors.grey.shade300)
                  ]),
              child: Wrap(
                runSpacing: 10.w,
                children: [
                  _setData2Tile(
                      title: "Weaknesses Type", body: e.type.toString()),
                  _setData2Tile(
                      title: "Weaknesses Power", body: e.value.toString()),
                ],
              ),
            );
          },
        )
      ],
    ).paddingAll(16.w);
  }

  Widget _setDataTile({required String title, required String body}) {
    return Row(
      children: [
        SizedBox(
          width: titleSize,
          child: Text(
            title,
            style:
                AppTextStyle.text12w500.copyWith(color: Colors.grey.shade700),
          ),
        ),
        Text(
          body,
          style: AppTextStyle.text14w600,
        )
      ],
    );
  }

  Widget _setData2Tile({required String title, required String body}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width * .5,
          child: Text(
            title,
            style:
                AppTextStyle.text12w500.copyWith(color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          child: Text(
            body,
            textAlign: TextAlign.end,
            style: AppTextStyle.text14w600,
          ),
        )
      ],
    );
  }
}
