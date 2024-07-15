import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';
import '../../../Controller/office_controller.dart';
import '../../../utils/constants/base_colors.dart';
import '../../../utils/constants/base_strings.dart';
import '../../../utils/functions/base_funcations.dart';
import '../../../utils/helpers/validators.dart';
import '../../../utils/widgets/custom_appbar.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_textformfield.dart';



class NewOfficeScreen extends StatelessWidget {
  final controller = Get.put(OfficeController());

   NewOfficeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: BaseColors.canvasColor,
      appBar: CustomAppBar(
        customBackgroundColor: BaseColors.canvasColor,
        centerTitle: true,
        titleSpacing: 0,
        customTitle: Text(
          BaseStrings.newOffice,
          style: getTheme(context: context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Obx(
            () => SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                focusNode: FocusNode(),
                height: 48.h,
                validator: (val) => validateOfficeName(val),
                labelText: BaseStrings.officeName,
                controller: controller.ofcNameController,
                onChanged: (val) {},
              ),
              15.toVSB,
              CustomTextFormField(
                focusNode: FocusNode(),
                validator: (val) => validateOfficeAddress(val),
                labelText: BaseStrings.physicalAddress,
                controller: controller.ofcAddressController,
                onChanged: (val) {},
              ),
              15.toVSB,
              CustomTextFormField(
                focusNode: FocusNode(),
                validator: (val) => validateEmail(val),
                labelText: BaseStrings.EmailAdd,
                controller: controller.ofcEmailAddressController,
                onChanged: (val) {},
              ),
              15.toVSB,
              CustomTextFormField(
                focusNode: FocusNode(),
                validator: (val) => validatePhoneNumber(val),
                labelText: BaseStrings.phoneNumber,
                controller: controller.phoneNumberController,
                onChanged: (val) {},
              ),
              15.toVSB,
              CustomTextFormField(
                focusNode: FocusNode(),
                validator: (val) => validateOfficeCapacity(val),
                labelText: BaseStrings.maximumCapacity,
                controller: controller.ofCapacityController,
                onChanged: (val) {},
              ),
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
                // Width for 6 avatars + spacing
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 18,
                      runSpacing: 15, // Vertical space between rows
                      children: List.generate(11, (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectColor(controller.colorList[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: controller.selectedColor.value == controller.colorList[index]
                                    ? BaseColors.selectColorBorder
                                    : Colors.transparent,
                                width: 3.0,
                              ),
                            ),
                            child: CircleAvatar(
                                backgroundColor: controller.colorList[index],
                                radius: 19.w,
                                child: null
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              20.toVSB,
              CustomButton(
                labelText: BaseStrings.addOffice.toUpperCase(),
                onPressed: () {
                  controller.addNewOffice();
                },
              ),
            ],
          ).paddingSymmetric(horizontal: 19),
        ),
      ),
    );
  }
}
