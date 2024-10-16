import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pokemontcg/app/theme/app_colors.dart';

import '../../../routes/app_pages.dart';
import '../controller/home_view_controller.dart';
import 'post_item.dart';
import 'post_search_delegate.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewController controller = Get.find<HomeViewController>();
  var scrollController = ScrollController();
  RxBool isLoading = false.obs;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(pagination);
  }

  void setOrderList() async {
    isLoading.value = true;
    await controller.fetchPostList(controller.currentPage.value.toString(),
        isRefresh: false);
    isLoading.value = false;
    isLoading.refresh();
  }

  void pagination() {
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        (controller.currentPage.value < controller.pageSize.value)) {
      if (!isLoading.value) setOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.yellow,
        title: SvgPicture.asset(
          "assets/svg/appbar_logo.svg",
          semanticsLabel: 'Pokemon Logo',
          height: 30.w,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: PostSearchDelegate());
              },
              icon: const Icon(
                Icons.search,
                color: AppColor.black,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.currentPage.value = 1;
          controller.fetchPostList("1", isRefresh: true);
        },
        child: Obx(() {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 12 / 15,
                mainAxisSpacing: 20.w),
            shrinkWrap: true,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.postList.length,
            itemBuilder: (BuildContext context, int index) {
              var postObj = controller.postList[index];
              return PostItemImage(
                imageLink: postObj.images!.large.toString(),
                key: ValueKey(postObj.hashCode),
                onTap: () {
                  Get.toNamed(Routes.details, arguments: postObj);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
