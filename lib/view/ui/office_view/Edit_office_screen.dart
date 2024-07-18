import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:m_getx_office/Controller/office_controller.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';

import '../../../model/new_office_modle.dart';
import '../../../utils/constants/base_colors.dart';
import '../../../utils/constants/base_strings.dart';
import '../../../utils/functions/base_funcations.dart';
import '../../../utils/helpers/key.dart';
import '../../../utils/helpers/validators.dart';
import '../../../utils/widgets/custom_appbar.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_textformfield.dart';


class EditOfficeScreen extends StatefulWidget {
  final OfficeModel? office;

  const EditOfficeScreen({super.key, required this.office});

  @override
  State<EditOfficeScreen> createState() => _EditOfficeScreenState();
}

class _EditOfficeScreenState extends State<EditOfficeScreen> {
  final OfficeController officeController = Get.find();



  final FocusNode ofcName = FocusNode();
  final FocusNode ofcemail = FocusNode();
  final FocusNode ofcAddress = FocusNode();
  final FocusNode ofcmobilenumber = FocusNode();
  final FocusNode ofcCapacity = FocusNode();



  AllKey allKey = AllKey();

  @override
  void initState() {
    if (widget.office != null) {
      officeController.ofcNameController.text = widget.office?.name ?? "";
      officeController.phoneNumberController.text = widget.office?.phoneNumber ?? "";
      officeController.ofCapacityController.text = widget.office?.capacity.toString() ?? "";
      officeController.ofcAddressController.text = widget.office?.address ?? "";
      officeController.ofcEmailAddressController.text = widget.office?.email ?? "";
      String? colorString = widget.office?.color;
      if (colorString != null) {
        officeController.selectedColor.value = Color(int.parse(colorString.substring(6, 16)));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BaseColors.canvasColor,
        appBar: CustomAppBar(
          customBackgroundColor: BaseColors.canvasColor,
          centerTitle: true,
          titleSpacing: 0,
          customTitle: Text(
            BaseStrings.editOffice,
            style: getTheme(context: context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Obx(
          ()=> Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: allKey.editOfficeFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                      focusNode: ofcName,
                      height: 48.h,
                      validator: (val) {
                        return validateOfficeName(val);
                      },
                      labelText: BaseStrings.officeName,
                      controller:  officeController.ofcNameController,
                      onChanged: (val) {}),
                  15.toVSB,
                  CustomTextFormField(
                      focusNode: ofcAddress,
                      validator: (val) {
                        return validateOfficeAddress(val);
                      },
                      labelText: BaseStrings.physicalAddress,
                      controller:  officeController.ofcAddressController,
                      onChanged: (val) {}),
                  15.toVSB,
                  CustomTextFormField(
                      focusNode: ofcemail,
                      validator: (val) {
                        return validateEmail(val);
                      },
                      labelText: BaseStrings.EmailAdd,
                      controller:  officeController.ofcEmailAddressController,
                      onChanged: (val) {}),
                  15.toVSB,
                  CustomTextFormField(
                      focusNode: ofcmobilenumber,
                      validator: (val) {
                        return validatePhoneNumber(val);
                      },
                      labelText: BaseStrings.phoneNumber,
                      controller:  officeController.phoneNumberController,
                      onChanged: (val) {}),
                  15.toVSB,
                  CustomTextFormField(
                      focusNode: ofcCapacity,
                      validator: (val) {
                        return validateOfficeCapacity(val);
                      },
                      labelText: BaseStrings.maximumCapacity,
                      controller:  officeController.ofCapacityController,
                      onChanged: (val) {}),
                  15.toVSB,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      BaseStrings.officeColour,
                      style: getTheme(context: context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                          color: BaseColors.blackColors,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  15.toVSB,
                  SizedBox(
                    width: (24.w * 10) * 6 - 11,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 9,
                          runSpacing: 11,
                          children: List.generate(11, (index) {
                            return GestureDetector(
                              onTap: () {
                                officeController.selectColor(officeController.colorList[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                    officeController.selectedColor ==  officeController.colorList[index]
                                        ? BaseColors.selectColorBorder
                                        : Colors.transparent,
                                    width: 3.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                    backgroundColor:  officeController.colorList[index],
                                    radius: 19.w,
                                    child: null),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  20.toVSB,
                  CustomButton(
                      labelText: BaseStrings.updateOffice.toUpperCase(),
                      onPressed: () {
                        if (allKey.editOfficeFormKey.currentState!.validate()) {
                          final updatedOffice = OfficeModel(
                              id:int.parse (widget.office?.id.toString() ??""),
                              name:  officeController.ofcNameController.text,
                              phoneNumber:  officeController.phoneNumberController.text,
                              email:  officeController.ofcEmailAddressController.text,
                              address:  officeController.ofcAddressController.text,
                              capacity: int.tryParse(
                                  officeController.ofCapacityController.text) ??
                                  (widget.office?.capacity ?? 5),color:  officeController.selectedColor.toString());
                          officeController.updateOffice(officeModel:updatedOffice);
                        }
                      }),
                  TextButton(
                    onPressed: () {
                      officeController.deleteOfficeData(widget.office?.id ?? 0);
                      // context.read<NewOfficeBloc>().add(DeleteOffice(int.parse(widget.office?.id.toString() ?? "")));
                    },
                    child: Text(
                      BaseStrings.deleteOffice.toUpperCase(),
                      style: getTheme(context: context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: BaseColors.btnColor),
                    ),
                  )
                ],
              ).paddingSymmetric(horizontal: 19),
            ),
          ),
        ));
  }

}
