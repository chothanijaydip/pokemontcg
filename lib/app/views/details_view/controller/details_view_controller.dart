
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../model/pokemon_list_model.dart';

class DetailsViewController extends GetxController {
  
  Rx<PokemonModel> pokemonDetails =  PokemonModel().obs;
  @override
  void onReady() {
    super.onReady();
    pokemonDetails.value = Get.arguments;
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.vibrantColor?.color;
  }

}
