import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m_getx_office/Controller/staff_controller.dart';
import 'package:m_getx_office/utils/constants/base_strings.dart';

import 'package:m_getx_office/utils/helpers/key.dart';

import '../model/new_office_modle.dart';
import '../routes/routes.dart';
import '../viewModel/repositories/OfficeRepository/office_repository.dart';
import '../viewModel/repositories/staffRepositries/staff_repository.dart';



class OfficeController extends GetxController {
  final OfficeRepository officeRepository;
  final StaffRepository? staffRepository;

   OfficeController({ required  this.officeRepository,this.staffRepository});

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
  var officeInStaff = <int,int>{}.obs;
  var expanded = <bool>[].obs;
  var selectedColor = Rxn<Color>();
  var offices = <OfficeModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  AllKey allKey  = AllKey();

  final ofcNameController = TextEditingController();
  final ofcAddressController = TextEditingController();
  final ofcEmailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ofCapacityController = TextEditingController();


 void onClearFiled(){
   ofcNameController.clear();
   ofcAddressController.clear();
   ofcEmailAddressController.clear();
   phoneNumberController.clear();
   ofCapacityController.clear();
 }
  void selectColor(Color color) {
    selectedColor.value = color;
  }

  Future<void> addNewOffice() async {
    if (ofcNameController.text.isNotEmpty &&
        ofcAddressController.text.isNotEmpty &&
        ofcEmailAddressController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        ofCapacityController.text.isNotEmpty &&
        selectedColor.value != null) {
      final office = OfficeModel(
        name: ofcNameController.text.trim(),
        address: ofcAddressController.text.trim(),
        email: ofcEmailAddressController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        capacity: int.parse(ofCapacityController.text.trim()),
        color: selectedColor.value.toString(),
      );
      try {
        await officeRepository.createOffice(office).then((value) => fetchOffices(),);
        Get.snackbar(BaseStrings.success, BaseStrings.officeAddedSuccessfully, snackPosition: SnackPosition.BOTTOM);
        Get.toNamed(BaseRoute.officeScreen);
        onClearFiled();
      } catch (e) {
        Get.snackbar('Error', 'Failed to add office: $e');
      }
    } else {
      Get.snackbar('Validation Error', 'Please fill all fields and select a color');
    }
  }

  Future<void> fetchOffices() async {
    try {
      isLoading(true);
      var fetchedOffices = await officeRepository.getAllOfficesData();
      expanded = List<bool>.filled(offices.length, false).obs;
      if (fetchedOffices != null) {
        offices(fetchedOffices);
      }
      for (var office in offices) {
        int officeId = office.id ?? 0;
        var fetchedStaff = await staffRepository?.readAllStaffByOfficeId(officeId);
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
        Get.snackbar(BaseStrings.success, BaseStrings.officeUpdateSuccessfully, snackPosition: SnackPosition.BOTTOM);
        Get.toNamed(BaseRoute.officeScreen);
        onClearFiled();
      } catch (e) {
        Get.snackbar('Error', 'Failed to add office: $e');
      }
    }

  Future<void> deleteOfficeData( int id) async {
    try {
      await officeRepository.deleteOffice(id);
      Get.snackbar(BaseStrings.success, BaseStrings.officeUpdateSuccessfully, snackPosition: SnackPosition.BOTTOM);
      Get.toNamed(BaseRoute.officeViewScreen);
      onClearFiled();
    } catch (e) {
      Get.snackbar('Error', "Failed to delete office. $e");

    }
  }
}
