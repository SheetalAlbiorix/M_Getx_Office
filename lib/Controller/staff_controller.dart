import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:m_getx_office/utils/helpers/key.dart';
import 'package:m_getx_office/viewModel/repositories/staffRepositries/staff_repositoryImpl.dart';
import '../model/staff_model.dart';
import '../routes/routes.dart';
import '../utils/constants/base_assets.dart';
import '../utils/constants/base_strings.dart';


class StaffController extends GetxController {
  final StaffModel? staffModel;

  StaffController({this.staffModel});

  var currentPage = 0.obs;
  var officeInStaff = 0.obs;
  var selectedAvatarPath = ''.obs;

  RxBool expanded = false.obs;
  AllKey allKey = AllKey();
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController searchController = TextEditingController();
  final TextEditingController firstNameContr = TextEditingController();
  final TextEditingController lastNameContr = TextEditingController();
  final GlobalKey<FormState> addStaffFormKey = GlobalKey<FormState>();
  final StaffRepositoryImPleMention staffRepository =
      StaffRepositoryImPleMention();
  final

  RxList<StaffModel> staffList = <StaffModel>[].obs;
  RxList<StaffModel> filterStaffList = <StaffModel>[].obs;
  RxBool isLoading = false.obs;

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

  void clearData() {
    firstNameContr.clear();
    lastNameContr.clear();
    selectedAvatarPath.value = '';
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
      clearData();

      currentPage.value = 0;
    } catch (e) {
      Get.snackbar('Error', 'Failed to add office: $e');
    }
  }

  Future<void> fetchStaff({required int officeId}) async {
    isLoading.value = true;
    try {
      var fetchedStaff = await staffRepository.readAllStaffByOfficeId(officeId);
      staffList.clear();
      if (fetchedStaff != null && fetchedStaff.isNotEmpty) {
        staffList.addAll(fetchedStaff);
        staffList.refresh();
        filterStaffList.clear();
        filterStaffList.addAll(staffList
            .where(
                (staff) => (staff.name ?? "").toLowerCase().contains(searchController.text) || (staff.lastName ?? "").toLowerCase().contains(searchController.text)).toList());

      } else {
        Get.snackbar('Message', BaseStrings.noStaffMemberAvailable);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateStaff(StaffModel staff) async {
    try {
      await staffRepository.updateOfficeStaff(staff);
      clearData();
      currentPage.value = 0;
      int staffIndex = staffList.indexWhere((staff) => staff.id == staff.id);
      if (staffIndex != -1) {
        staffList[staffIndex] = staff;
        staffList.refresh();
      }
      int filterStaffIndex = filterStaffList.indexWhere((filterStaff) => filterStaff.id == staff.id);
      if (filterStaffIndex != -1) {
        filterStaffList[filterStaffIndex] = staff;
        filterStaffList.refresh();
      }
      Get.snackbar(BaseStrings.success, BaseStrings.staffUpdateSuccessfully,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update staff: $e');
    }
  }

  void filterStaff(String query) {
    if (query.isEmpty) {
      filterStaffList.clear();
    } else {
      filterStaffList.value = staffList.where((staff) {
        return (staff.name ?? "").contains(query) ||
            (staff.lastName ?? "").contains(query);
      }).toList();
    }
  }

  Future<void> deleteStaff(int id) async {
    isLoading.value = true;
    try {
      await staffRepository.deleteStaff(id);
      isLoading.value = false;
      Get.snackbar(BaseStrings.success, BaseStrings.staffDeletedSuccessfully,
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed(BaseRoute.officeViewScreen);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', "Failed to delete office. $e");
    }
  }
}
