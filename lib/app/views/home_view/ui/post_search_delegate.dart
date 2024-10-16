import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/pokemon_list_model.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../controller/home_view_controller.dart';
import 'post_item.dart';

class PostSearchDelegate extends SearchDelegate {
  PostSearchDelegate();
  @override
  Widget buildResults(BuildContext context) {
    return GetBuilder<HomeViewController>(builder: (controller) {
      return FutureBuilder(
        future: controller.searchItemsList(query),
        builder: (context, AsyncSnapshot<List<PokemonModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.yellow,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Stack(
              children: [
                Center(child: Text("No Data Found")),
              ],
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 12 / 15,
                  mainAxisSpacing: 20.w),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final itemData = snapshot.data![index];
                return PostItemImage(
                  imageLink: itemData.images!.large.toString(),
                  key: ValueKey(itemData.hashCode),
                  onTap: () {
                    Get.toNamed(Routes.details, arguments: itemData);
                  },
                );
              },
            );
          }
        },
      );
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: AppColor.black),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColor.black),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GetBuilder<HomeViewController>(builder: (controller) {
      return FutureBuilder(
        future: controller.searchItemsList(query),
        builder: (context, AsyncSnapshot<List<PokemonModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.yellow,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Stack(
              children: [
                Center(child: Text("No Data Found")),
              ],
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 12 / 15,
                  mainAxisSpacing: 20.w),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final itemData = snapshot.data![index];
                return PostItemImage(
                  imageLink: itemData.images!.large.toString(),
                  key: ValueKey(itemData.hashCode),
                  onTap: () {
                    Get.toNamed(Routes.details, arguments: itemData);
                  },
                );
              },
            );
          }
        },
      );
    });
  }
}
