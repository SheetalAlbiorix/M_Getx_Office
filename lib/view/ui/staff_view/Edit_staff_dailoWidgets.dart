import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_getx_office/Controller/staff_controller.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';
import '../../../model/staff_model.dart';
import '../../../utils/constants/base_assets.dart';
import '../../../utils/constants/base_colors.dart';
import '../../../utils/constants/base_strings.dart';
import '../../../utils/functions/base_funcations.dart';

import '../../../utils/helpers/validators.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_textformfield.dart';


class EditStaffDailowidgets extends StatefulWidget {

   final  StaffModel? staffModel;

  const EditStaffDailowidgets({super.key,this.staffModel});

  @override
  EditStaffDailowidgetState createState() => EditStaffDailowidgetState();
}

class EditStaffDailowidgetState extends State<EditStaffDailowidgets> {



  final StaffController staffController =  Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      if (widget.staffModel != null) {
        staffController.firstNameContr.text =
            widget.staffModel?.name?.split(" ")[0] ?? "";
        staffController.lastNameContr.text = widget.staffModel?.lastName ?? "";
        staffController.selectedAvatarPath.value =
            widget.staffModel?.avtar ?? "";
      }
      super.initState();
    });}

  final TextEditingController searchController = TextEditingController();
  final TextEditingController firstNameContr = TextEditingController();
  final TextEditingController lastNameContr = TextEditingController();




  bool expanded = false;


  String selectedAvatarPath = '';




  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xffF8FAFC),
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        title: ListTile(
          horizontalTitleGap: 1,
          contentPadding: const EdgeInsets.only(left: 8, right: 10),
          leading: Visibility(
            child: staffController.currentPage.value == 1
                ? IconButton(
                onPressed: () {
                  staffController.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
                icon: const Icon(Icons.arrow_back_sharp))
                : const SizedBox.shrink(),
          ),
          title: Text(
            textAlign: TextAlign.left,
            BaseStrings.editStaffMember,
            style: getTheme(context: context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800, fontSize: 18.sp),
          ),
          trailing: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(BaseAssets.closeCircle)),
        ),
        content:
        Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: staffController.allKey.editStaffFormKey,
            child:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 136.h,
                  child: PageView(
                    controller: staffController.pageController,
                    onPageChanged: (int page) {

                      staffController.currentPage.value = page;

                    },
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFormField(
                              labelText: BaseStrings.firstName,
                              controller: staffController.firstNameContr,
                              validator:validateFirstName,
                              onChanged: (val) {}),
                          10.toVSB,
                          CustomTextFormField(
                            labelText: BaseStrings.lastName,
                            controller: staffController.lastNameContr,
                            onChanged: (val) {},
                            validator: validateLastName
                          )
                        ],
                      ),
                      Obx(
                        ()=> SizedBox(
                          height: 52.h,
                          width: 52.w, // 5 avatars * (radius * 2 + spacing)
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10, // Space between avatars
                            runSpacing: 20, // Space between rows
                            children: List.generate(7, (index) {
                              final avatarPath = staffController.avatarList[index];
                              return GestureDetector(
                                onTap: () {
                                  staffController.selectedAvatarPath(staffController.avatarList[index]);

                                },
                                child: CircleAvatar(
                                  radius: 24.w,
                                  backgroundColor:   staffController.selectedAvatarPath.value == avatarPath
                                      ? Colors.blue.withOpacity(0.3)
                                      : Colors.transparent,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:  staffController.selectedAvatarPath.value == avatarPath
                                              ? BaseColors.selectColorBorder
                                              : Colors.transparent,
                                          width: 4,
                                        ),),
                                      child: SvgPicture.asset(avatarPath)),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                10.toVSB,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(2, (int index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: staffController.currentPage.value == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

        actions: [
          Obx(
          ()=> staffController.currentPage.value == 0
                ? CustomButton(
              labelText: BaseStrings.next,
              onPressed: () {
                if (staffController.allKey.editStaffFormKey.currentState!.validate()) {
                  staffController.nextPage();
                }
              },
            )
                : CustomButton(
                labelText: BaseStrings.updateStaffMember,
                onPressed: () {
                  if (staffController.allKey.editStaffFormKey.currentState!.validate() &&
                      staffController.selectedAvatarPath.isNotEmpty) {
                    final staff = StaffModel(
                      id: int.parse((widget.staffModel?.id ??0).toString()),
                      lastName: staffController.lastNameContr.text,
                      name: staffController.firstNameContr.text,
                      avtar: staffController.selectedAvatarPath.value,
                      officeId: int.parse((widget.staffModel?.officeId ?? "").toString()),
                    );
                 staffController.updateStaff(staff).then((value) => staffController.fetchStaff(officeId: (widget.staffModel?.officeId ?? 0),));
staffController.staffList.refresh();

                    Navigator.pop(context);
                  }
                }),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    staffController.pageController.dispose();
    staffController.currentPage.value =0;
        super.dispose();
  }

}
