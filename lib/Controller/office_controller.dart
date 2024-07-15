import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/new_office_modle.dart';
import '../routes/routes.dart';
import '../viewModel/repositories/OfficeRepository/office_repository.dart';



class OfficeController extends GetxController {
  final OfficeRepository? officeRepository;

   OfficeController({ this.officeRepository});

  var colorList = [
    const Color(0xffFFBE0B),
    const Color(0xffFF9B71),
    const Color(0xffFB5607),
    const Color(0xff97512C),
    const Color(0xffDBBADD),
    const Color(0xffFF006E),
    const Color(0xffA9F0D1),
    const Color(0xff00B402),
    const Color(0xff489DDA),
    const Color(0xff0072E8),
    const Color(0xff8338EC),
  ];

  var selectedColor = Rxn<Color>();
  var offices = <OfficeModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;


  final ofcNameController = TextEditingController();
  final ofcAddressController = TextEditingController();
  final ofcEmailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ofCapacityController = TextEditingController();

  @override
  void onClose() {
    ofcNameController.dispose();
    ofcAddressController.dispose();
    ofcEmailAddressController.dispose();
    phoneNumberController.dispose();
    ofCapacityController.dispose();
    super.onClose();
  }

  void selectColor(Color color) {
    selectedColor.value = color;
  }

  void addNewOffice() async {
    if (ofcNameController.text.isNotEmpty &&
        ofcAddressController.text.isNotEmpty &&
        ofcEmailAddressController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        ofCapacityController.text.isNotEmpty &&
        selectedColor.value != null) {
      final office = OfficeModel(
        name: ofcNameController.text,
        address: ofcAddressController.text,
        email: ofcEmailAddressController.text,
        phoneNumber: phoneNumberController.text,
        capacity: int.parse(ofCapacityController.text),
        color: selectedColor.value.toString(),
      );
      try {
        await officeRepository.createOffice(office);
        Get.snackbar('Success', 'Office Added Successfully');
        Get.toNamed(BaseRoute.officeScreen);
      } catch (e) {
        Get.snackbar('Error', 'Failed to add office: $e');
      }
    } else {
      Get.snackbar('Validation Error', 'Please fill all fields and select a color');
    }
  }
}
