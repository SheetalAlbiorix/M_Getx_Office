import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/constants/base_assets.dart';

class StaffController extends GetxController {
  var currentPage = 0.obs;
  var selectedAvatarPath = ''.obs;
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController searchController = TextEditingController();
  final TextEditingController firstNameContr = TextEditingController();
  final TextEditingController lastNameContr = TextEditingController();
  final GlobalKey<FormState> addStaffFormKey = GlobalKey<FormState>();

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  List<String> avatarList = [
    BaseAssets.avtarOne,
    BaseAssets.avtarTwo,
    BaseAssets.avtarThree,
    BaseAssets.avtarFour,
    BaseAssets.avtarFive,
    BaseAssets.avtarSix,
    BaseAssets.avtarSeven,
  ];
}
