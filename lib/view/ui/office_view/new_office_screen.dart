import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';
import '../../../Controller/office_controller.dart';
import '../../../utils/constants/base_colors.dart';
import '../../../utils/constants/base_strings.dart';
import '../../../utils/functions/base_funcations.dart';
import '../../../utils/helpers/key.dart';
import '../../../utils/helpers/validators.dart';
import '../../../utils/widgets/custom_appbar.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_textformfield.dart';

class NewOfficeScreen extends StatefulWidget {

  NewOfficeScreen({super.key});

  @override
  State<NewOfficeScreen> createState() => _NewOfficeScreenState();
}

class _NewOfficeScreenState extends State<NewOfficeScreen> {
  final OfficeController controller = Get.find<OfficeController>();

  AllKey allKey = AllKey();

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
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: allKey.newOfficeFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  focusNode: FocusNode(),
                  height: 48.h,
                  validator: validateOfficeName,
                  labelText: BaseStrings.officeName,
                  controller: controller.ofcNameController,
                  onChanged: (val) {},
                ),
                15.toVSB,
                CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.streetAddress,
                  focusNode: FocusNode(),
                  validator: (val) => validateOfficeAddress(val),
                  labelText: BaseStrings.physicalAddress,
                  controller: controller.ofcAddressController,
                  onChanged: (val) {},
                ),
                15.toVSB,
                CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: FocusNode(),
                  validator: (val) => validateEmail(val),
                  labelText: BaseStrings.EmailAdd,
                  controller: controller.ofcEmailAddressController,
                  onChanged: (val) {},
                ),
                15.toVSB,
                CustomTextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],

                  keyboardType: TextInputType.number,
                  focusNode: FocusNode(),
                  validator: (val) => validatePhoneNumber(val),
                  labelText: BaseStrings.phoneNumber,
                  controller: controller.phoneNumberController,
                  onChanged: (val) {},
                ),
                15.toVSB,
                CustomTextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                  ],
                   textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
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
              width: (24.w * 10) * 6 - 11, // Width for 6 avatars + spacing
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 11,
                    runSpacing: 16,
                    children: List.generate(11, (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectColors(  controller.colorLists[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: controller.selectedColors.value ==
                                  controller.colorLists[index]
                                  ? BaseColors.selectColorBorder
                                  : Colors.transparent,
                              width: 3.0,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Color(int.parse(controller.colorLists[index])),
                            radius: 19.w,
                            child: null,
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
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (allKey.newOfficeFormKey.currentState!
                        .validate()) {
                      controller.addNewOffice();
                    }
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 19),
          ),
        ),
      ),
    );
  }
}
