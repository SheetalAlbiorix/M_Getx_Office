import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:m_getx_office/utils/constants/base_strings.dart';
import 'package:path/path.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/new_office_modle.dart';
import '../routes/routes.dart';
import '../viewModel/repositories/OfficeRepository/office_repository.dart';
import '../viewModel/repositories/staffRepositries/staff_repository.dart';
import 'package:url_launcher/url_launcher.dart' as UL;

class OfficeController extends GetxController {
  final OfficeRepository officeRepository;
  final StaffRepository? staffRepository;

  OfficeController({required this.officeRepository, this.staffRepository});

  List<String> colorLists = [
    '0xffFFBE0B',
    '0xffFF9B71',
    '0xffFB5607',
    '0xff97512C',
    '0xffDBBADD',
    '0xffFF006E',
    '0xffA9F0D1',
    '0xff00B402',
    '0xff489DDA',
    '0xff0072E8',
    '0xff8338EC',
  ];

  var officeInStaff = <int, int>{}.obs;

  var expanded = <bool>[].obs;
  var selectedColor = Rxn<Color>();
  var selectedColors = Rxn<String>();
  var offices = <OfficeModel>[].obs;
  var isLoading = false.obs;
  var tutorialCoachIsDone = false.obs;
  var errorMessage = ''.obs;
  final RxBool startAnimation = false.obs;

  TutorialCoachMark? tutorialCoachMark;

  double screenWidth =0;

  final ofcNameController = TextEditingController();
  final ofcAddressController = TextEditingController();
  final ofcEmailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ofCapacityController = TextEditingController();

  void onClearFiled() {
    ofcNameController.clear();
    ofcAddressController.clear();
    ofcEmailAddressController.clear();
    phoneNumberController.clear();
    ofCapacityController.clear();
    selectedColors.value = '';
  }

  void selectColors(String colorHex) {
    selectedColors.value = colorHex;
  }

  Future<void> addNewOffice() async {
    if (ofcNameController.text.isNotEmpty &&
        ofcAddressController.text.isNotEmpty &&
        ofcEmailAddressController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        ofCapacityController.text.isNotEmpty &&
        selectedColors.value != null) {
      final office = OfficeModel(
        name: ofcNameController.text.trim(),
        address: ofcAddressController.text.trim(),
        email: ofcEmailAddressController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        capacity: int.parse(ofCapacityController.text.trim()),
        color: selectedColors.value.toString(),
      );
      try {
        await officeRepository.createOffice(office).then(
              (value) => fetchOffices(),
            );
        Get.snackbar(BaseStrings.success, BaseStrings.officeAddedSuccessfully,
            snackPosition: SnackPosition.BOTTOM);
        Navigator.of(Get.context!).pushNamedAndRemoveUntil(
            BaseRoute.officeScreen, (Route<dynamic> route) => false);
        onClearFiled();
      } catch (e) {
        Get.snackbar('Error', 'Failed to add office: $e');
      }
    } else {
      Get.snackbar(
          'Validation Error', 'Please fill all fields and select a color');
    }
  }

  Future<void> fetchOffices() async {
    try {
      isLoading(true);
      var fetchedOffices = await officeRepository.getAllOfficesData();
      expanded = List<bool>.filled(offices.length, false).obs;
      if (fetchedOffices != null) {
        await Future.delayed(const Duration(milliseconds: 300)); // Delay between each item
        offices(fetchedOffices);
      }
      for (var office in offices) {
        int officeId = office.id ?? 0;
        var fetchedStaff =
            await staffRepository?.readAllStaffByOfficeId(officeId);
        if (fetchedStaff != null) {
          officeInStaff[officeId] = fetchedStaff.length;
        } else {
          officeInStaff[officeId] = 0;
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateOffice({required OfficeModel officeModel}) async {
    try {
      await officeRepository.updateOffice(officeModel);
      Get.snackbar(BaseStrings.success, BaseStrings.officeUpdateSuccessfully,
          snackPosition: SnackPosition.BOTTOM);
      Navigator.of(Get.context!).pushNamedAndRemoveUntil(
          BaseRoute.officeScreen, (Route<dynamic> route) => false);
      onClearFiled();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add office: $e');
    }
  }

  Future<void> deleteOfficeData(int id) async {
    try {
      await officeRepository.deleteOffice(id);
      Get.snackbar(BaseStrings.success, BaseStrings.officeUpdateSuccessfully,
          snackPosition: SnackPosition.BOTTOM);
      Navigator.of(Get.context!).pushNamedAndRemoveUntil(
          BaseRoute.officeScreen, (Route<dynamic> route) => false);
      onClearFiled();
    } catch (e) {
      Get.snackbar(BaseStrings.error, e.toString());
    }
  }

  makingPhoneCall(String phoneNumber) async {
    var url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void makingGmailID(String mailId) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: mailId,
    );
    String  url = params.toString();
    if (await  canLaunchUrl( Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print( 'Could not launch $url');
    }
  }
}


