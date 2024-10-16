import 'dart:developer';

import 'package:get/get.dart';

import '../../../model/pokemon_list_model.dart';
import '../repository/home_repository.dart';

// Controller for the home view, responsible for fetching a list of Pokémon and handling pagination and search functionality
class HomeViewController extends GetxController {
  // Instance of HomeRepository to handle API calls
  final HomeRepository repository = HomeRepository();

  // RxList to store the list of Pokémon
  RxList<PokemonModel> postList = <PokemonModel>[].obs;

  // RxInt to keep track of the current page
  RxInt currentPage = 1.obs;

  // RxInt to store the page size
  RxInt pageSize = 1.obs;

  @override
  // Called when the controller is ready
  void onReady() {
    super.onReady();
    // Fetch the initial list of Pokémon
    fetchPostList("${currentPage.value}");
  }

  // Fetches the list of Pokémon for the given page
  Future<void> fetchPostList(page, {isRefresh = false}) async {
    try {
      // If refreshing, clear the post list
      if (isRefresh) {
        postList.clear();
      }
      // Make API call to fetch the list of Pokémon
      final response = await repository.getPostListCall(
        page: page,
      );
      // If the response is not null, add the Pokémon to the list
      if (response.postList != null) {
        // If not refreshing, increment the current page
        if (!isRefresh) {
          currentPage.value += 1;
        }
      }
      // Update the page size
      pageSize.value = response.pageSize ?? 0;
      // Add the fetched Pokémon to the list
      postList.addAll(response.postList ?? []);
    } catch (e) {
      // Print any errors
      log(e.toString());
    }
  }

  // Searches for Pokémon by query
  Future<List<PokemonModel>> searchItemsList(q) async {
    try {
      // Make API call to search for Pokémon
      final response = await repository.getPostSearchCall(
        query: q,
      );
      // Return the list of searched Pokémon
      return (response.postList ?? []);
    } catch (e) {
      // Print any errors
      log(e.toString());
    }
    // Return an empty list if no results
    return [];
  }
}
