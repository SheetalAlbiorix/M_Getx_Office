import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';
import '../../../Controller/staff_controller.dart';
import '../../../model/new_office_modle.dart';
import '../../../model/staff_model.dart';
import '../../../utils/constants/base_assets.dart';
import '../../../utils/constants/base_colors.dart';
import '../../../utils/constants/base_strings.dart';
import '../../../utils/functions/base_funcations.dart';
import '../../../utils/helpers/validators.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_textformfield.dart';

class AddStaffDialogWidget extends StatefulWidget {
  final OfficeModel? officeModel;
  final StaffModel? staffModel;

  AddStaffDialogWidget({super.key, this.officeModel, this.staffModel});

  @override
  State<AddStaffDialogWidget> createState() => _AddStaffDialogWidgetState();
}

class _AddStaffDialogWidgetState extends State<AddStaffDialogWidget> {
 final StaffController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color(0xffF8FAFC),
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      title: ListTile(
        horizontalTitleGap: 1,
        contentPadding: const EdgeInsets.only(left: 8, right: 10),
        leading: Obx(() {
          return Visibility(
            visible: controller.currentPage.value == 1,
            child: IconButton(
              onPressed: () {
                controller.previousPage();
              },
              icon: const Icon(Icons.arrow_back_sharp),
            ),
          );
        }),
        title: Text(
          textAlign: TextAlign.left,
          BaseStrings.newStaffMember,
          style: getTheme(context: context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800, fontSize: 18.sp),
        ),
        trailing: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(BaseAssets.closeCircle),
        ),
      ),
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: controller.addStaffFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 134.h,
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (int page) {
                  controller.currentPage.value = page;
                },
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                          labelText: BaseStrings.firstName,
                          controller: controller.firstNameContr,
                          validator: (val) {
                            return validateFirstName(val);
                          },
                          onChanged: (val) {}),
                      10.toVSB,
                      CustomTextFormField(
                        labelText: BaseStrings.lastName,
                        controller: controller.lastNameContr,
                        onChanged: (val) {},
                        validator: (val) {
                          return validateLastName(val);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 52.h,
                    width: 52.w,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 20,
                      children: List.generate(7, (index) {
                        final avatarPath = controller.avatarList[index];
                        return GestureDetector(
                          onTap: () {
                            controller.selectedAvatarPath.value = avatarPath;
                          },
                          child: Obx(() {
                            return CircleAvatar(
                              radius: 24.w,
                              backgroundColor: controller.selectedAvatarPath.value == avatarPath
                                  ? Colors.blue.withOpacity(0.3)
                                  : Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: controller.selectedAvatarPath.value == avatarPath
                                        ? BaseColors.selectColorBorder
                                        : Colors.transparent,
                                    width: 4,
                                  ),
                                ),
                                child: SvgPicture.asset(avatarPath),
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            10.toVSB,
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(2, (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentPage.value == index ? Colors.blue : Colors.grey,
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
      actions: [
        Obx(() {
          return controller.currentPage.value == 0
              ? CustomButton(
            labelText: BaseStrings.next,
            onPressed: () {
              if (controller.addStaffFormKey.currentState!.validate()) {
                controller.nextPage();
              }
            },
          )
              : CustomButton(
            labelText: BaseStrings.addstaffmember,
            onPressed: ()  {
              if (controller.addStaffFormKey.currentState!.validate() &&
                  controller.selectedAvatarPath.value.isNotEmpty) {
                final staff = StaffModel(
                  lastName: controller.lastNameContr.text,
                  name: controller.firstNameContr.text,
                  avtar: controller.selectedAvatarPath.value,
                  officeId: int.parse((widget.officeModel?.id ?? "").toString()),
                );
             controller.addStaff(staffModel: staff).then((value) => controller.fetchStaff(officeId: int.parse((widget.officeModel?.id ?? 0).toString())).toString(),);
              }
              Navigator.of(context).pop();
            },
          );
        }),
      ],
    );
  }
  @override
  void dispose() {
    controller.firstNameContr.clear();
    controller.lastNameContr.clear();
    controller.pageController.dispose();
    controller.currentPage.value =0;
    super.dispose();



  }
}
