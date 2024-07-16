import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m_getx_office/utils/helpers/key.dart';
import 'package:m_getx_office/viewModel/repositories/staffRepositries/staff_repositoryImpl.dart';
import '../model/staff_model.dart';
import '../routes/routes.dart';
import '../utils/constants/base_assets.dart';
import '../utils/constants/base_strings.dart';
import '../viewModel/repositories/staffRepositries/staff_repository.dart';

class StaffController extends GetxController {
  final StaffModel? staffModel;

  StaffController({this.staffModel});

  var currentPage = 0.obs;
  var selectedAvatarPath = ''.obs;

  AllKey allKey = AllKey();
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController searchController = TextEditingController();
  final TextEditingController firstNameContr = TextEditingController();
  final TextEditingController lastNameContr = TextEditingController();
  final GlobalKey<FormState> addStaffFormKey = GlobalKey<FormState>();
  final StaffRepositoryImPleMention staffRepository =
      StaffRepositoryImPleMention();

  var staffList = <StaffModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    currentPage.value = 0;
    super.onInit();
  }

  @override
  void onClose() {
    firstNameContr.dispose();
    lastNameContr.dispose();
    selectedAvatarPath.value = '';
    super.onClose();
  }

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

  Future<void> addStaff({required StaffModel staffModel}) async {
    try {
      await staffRepository.createStaff(staffModel);
      Get.snackbar(BaseStrings.success, BaseStrings.staffAddedSuccessfully,
          snackPosition: SnackPosition.BOTTOM);

      onClose();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add office: $e');
    }
  }

  Future<void> fetchStaff({required int officeId}) async {
    staffList.clear();
    isLoading.value = true;
    try {

      var fetchedStaff = await staffRepository.readAllStaffByOfficeId(officeId);
      if (fetchedStaff != null) {
        staffList.addAll(fetchedStaff);
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading.value = false;
    }
  }

  void updateStaff(StaffModel staff) async {
    try {
      await staffRepository.updateOfficeStaff(staff);
      Get.snackbar(BaseStrings.success, BaseStrings.staffUpdateSuccessfully,
          snackPosition: SnackPosition.BOTTOM);
      onClose();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add office: $e');
    }
  }
}
