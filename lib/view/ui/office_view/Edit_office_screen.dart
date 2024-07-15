import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  List<Color> colorList = [
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
  Color? selectedColor;
  final TextEditingController ofcNameController = TextEditingController();
  final TextEditingController ofcAddressController = TextEditingController();
  final TextEditingController ofcEmailAddressController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ofCapacityController = TextEditingController();

  final FocusNode ofcName = FocusNode();
  final FocusNode ofcemail = FocusNode();
  final FocusNode ofcAddress = FocusNode();
  final FocusNode ofcmobilenumber = FocusNode();
  final FocusNode ofcCapacity = FocusNode();

  void disposeController() {
    ofcNameController.dispose();
    phoneNumberController.dispose();
    ofcEmailAddressController.dispose();
    ofCapacityController.dispose();
  }

  AllKey allKey = AllKey();

  @override
  void initState() {
    if (widget.office != null) {
      ofcNameController.text = widget.office?.name ?? "";
      phoneNumberController.text = widget.office?.phoneNumber ?? "";
      ofCapacityController.text = widget.office?.capacity.toString() ?? "";
      ofcAddressController.text = widget.office?.address ?? "";
      ofcEmailAddressController.text = widget.office?.email ?? "";
      String? colorString = widget.office?.color;
      if (colorString != null) {
        selectedColor = Color(int.parse(colorString.substring(6, 16)));
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
        body: Form(
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
                    controller: ofcNameController,
                    onChanged: (val) {}),
                15.toVSB,
                CustomTextFormField(
                    focusNode: ofcAddress,
                    validator: (val) {
                      return validateOfficeAddress(val);
                    },
                    labelText: BaseStrings.physicalAddress,
                    controller: ofcAddressController,
                    onChanged: (val) {}),
                15.toVSB,
                CustomTextFormField(
                    focusNode: ofcemail,
                    validator: (val) {
                      return validateEmail(val);
                    },
                    labelText: BaseStrings.EmailAdd,
                    controller: ofcEmailAddressController,
                    onChanged: (val) {}),
                15.toVSB,
                CustomTextFormField(
                    focusNode: ofcmobilenumber,
                    validator: (val) {
                      return validatePhoneNumber(val);
                    },
                    labelText: BaseStrings.phoneNumber,
                    controller: phoneNumberController,
                    onChanged: (val) {}),
                15.toVSB,
                CustomTextFormField(
                    focusNode: ofcCapacity,
                    validator: (val) {
                      return validateOfficeCapacity(val);
                    },
                    labelText: BaseStrings.maximumCapacity,
                    controller: ofCapacityController,
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
                              // context
                              //     .read<NewOfficeBloc>()
                              //     .add(SelectColor(colorList[index]));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                  selectedColor == colorList[index]
                                      ? BaseColors.selectColorBorder
                                      : Colors.transparent,
                                  width: 3.0,
                                ),
                              ),
                              child: CircleAvatar(
                                  backgroundColor: colorList[index],
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
                            name: ofcNameController.text,
                            phoneNumber: phoneNumberController.text,
                            email: ofcEmailAddressController.text,
                            address: ofcAddressController.text,
                            capacity: int.tryParse(
                                ofCapacityController.text) ??
                                (widget.office?.capacity ?? 5),color: selectedColor.toString());
                        // context.read<NewOfficeBloc>().add(UpdateOfficeEvent(updatedOffice));
                      }
                    }),
                TextButton(
                  onPressed: () {
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
        ));
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }
}
