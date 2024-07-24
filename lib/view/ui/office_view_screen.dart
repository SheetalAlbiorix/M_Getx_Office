import 'package:flutter/material.dart';
import 'package:flutter_elastic_list_view/flutter_elastic_list_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_getx_office/Controller/staff_controller.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';
import 'package:m_getx_office/view/ui/staff_view/Add_staff_dailogWidgets.dart';
import 'package:m_getx_office/view/ui/staff_view/Edit_staff_dailoWidgets.dart';
import '../../model/new_office_modle.dart';
import '../../model/staff_model.dart';
import '../../routes/routes.dart';
import '../../utils/constants/base_assets.dart';
import '../../utils/constants/base_colors.dart';
import '../../utils/constants/base_strings.dart';
import '../../utils/functions/base_funcations.dart';
import '../../utils/widgets/custom_appbar.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/custom_textformfield.dart';
import '../../utils/widgets/detail_widgets.dart';

class OfficeViewScreen extends StatefulWidget {
  final OfficeModel? officeModel;

  const OfficeViewScreen({
    super.key,
    this.officeModel,
  });

  @override
  State<OfficeViewScreen> createState() => _OfficeViewScreenState();
}

class _OfficeViewScreenState extends State<OfficeViewScreen> {
  final StaffController staffController = Get.find();
  final TextEditingController searchController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
       fetchStaff();
    });
    super.initState();
  }

  Future<void> fetchStaff() async {
    await staffController.fetchStaff(
      officeId: widget.officeModel?.id ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(widget.officeModel!.color));
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          backgroundColor: const Color(0xff0D4477),
          onPressed: () {
            staffController.staffList.length  < (widget.officeModel?.capacity ?? 0) ?
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AddStaffDialogWidget(
                  officeModel: widget.officeModel ??
                      OfficeModel(
                          name: "",
                          address: "",
                          email: "",
                          phoneNumber: "",
                          capacity: 0,
                          color: ""),
                );
              },
            ) : Get.snackbar(BaseStrings.message, "Office capacity must be ${widget.officeModel?.capacity} Member",
                snackPosition: SnackPosition.BOTTOM);
          },
          child: SvgPicture.asset(BaseAssets.addIcon),
        ),
      ),
      appBar: CustomAppBar(
        customLeading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        customTitle: Text(
          BaseStrings.Office,
          style: getTheme(context: context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Obx(
            () => AnimatedContainer(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              height: staffController.expanded.value == true ? 250.h : 132.h,
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(1.0),
                            color.withOpacity(0.7),
                            color.withOpacity(0.5),
                            color.withOpacity(0.3),
                          ],
                          stops: const [
                            0.0,
                            0.33,
                            0.66,
                            1.0,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22, right: 16, top: 17),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.officeModel?.name ?? "",
                              style: getTheme(context: context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      color: BaseColors.allOfficeTextColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w800),
                            ),
                            InkWell(
                                onTap: () {
                                  Get.toNamed(BaseRoute.editOfficeScreen,
                                      arguments: widget.officeModel);
                                },
                                child: SvgPicture.asset(BaseAssets.editIcon)),
                          ],
                        ),
                        11.toVSB,
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(BaseAssets.peopleOverView),
                            12.toHSB,
                            Text.rich(TextSpan(
                                text:
                                    "${staffController.staffList.length ?? 0} ",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: BaseStrings.staffMembersInOffice,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: BaseColors.allOfficeTextColor,
                                        fontFamily: BaseStrings.interRegular),
                                  )
                                ])),
                          ],
                        ),
                        9.toVSB,
                        Divider(
                          indent: 5,
                          endIndent: 10,
                          height: 0.4.h,
                          color: const Color(0xff0D4477),
                        ),
                        11.toVSB,
                        InkWell(
                          onTap: () {
                            staffController.expanded.value =
                                !staffController.expanded.value;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "More info",
                                style: getTheme(context: context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: BaseColors.allOfficeTextColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                              ),
                              5.toHSB,
                              SvgPicture.asset(
                                staffController.expanded.value == false
                                    ? BaseAssets.downArrow
                                    : BaseAssets.upArrow,
                              ),
                            ],
                          ),
                        ),
                        if (staffController.expanded.value) ...[
                          Expanded(
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                12.toVSB,
                                customIconWithText(
                                    BaseAssets.callIcon,
                                    widget.officeModel?.phoneNumber
                                            .toString() ??
                                        "",
                                    context),
                                12.toVSB,
                                customIconWithText(
                                    BaseAssets.mailIcon,
                                    widget.officeModel?.email.toString() ?? "",
                                    context),
                                12.toVSB,
                                customIconWithText(
                                    BaseAssets.peopledIcon,
                                    "Office Capacity: ${widget.officeModel?.capacity.toString()}",
                                    context),
                                12.toVSB,
                                customIconWithText(
                                    BaseAssets.locationIcon,
                                    widget.officeModel?.address.toString() ??
                                        "",
                                    context),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: 17, vertical: 10),
          ),
          24.toVSB,
          CustomTextFormField(
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: BaseColors.blackColors,
                  )),
              labelText: BaseStrings.search,
              controller: searchController,
              onChanged: (val) {
                staffController.filterStaff(val);
              }).paddingSymmetric(horizontal: 16, vertical: 0),
          10.toVSB,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                BaseStrings.staffMemberInOffice,
                style: getTheme(context: context).textTheme.titleLarge,
              ),
              Obx(
    ()=> Text(
                  (staffController.staffList.length).toString(),
                  style: getTheme(context: context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 18.sp),
                ),
              )
            ],
          ).paddingOnly(left: 12, right: 24),
          13.toVSB,
          Obx(
            () => Expanded(
              child: staffController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ))
                  : staffController.filterStaffList.isNotEmpty && searchController.text.trim().isNotEmpty
                      ?
              ElasticListView.builder(
                          itemCount: staffController.filterStaffList.length,
                          itemBuilder: (context, index) {
                            final staff =
                                staffController.filterStaffList[index];
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return staffMemberMoreOptionDialog(
                                              context, staff);
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    size: 24,
                                  )),
                              leading: CircleAvatar(
                                child: SvgPicture.asset(staff.avtar),
                              ),
                              title: Text("${staff.name} ${staff.lastName} "),
                            );
                          },
                        )
                      : (searchController.text.isNotEmpty
                          ? const Center(
                              child: Text("No staff in office"),
                            )
                          : staffController.staffList.isNotEmpty
                              ? Obx(
                                  () => ListView.builder(
                                    itemCount: staffController.staffList.length,
                                    itemBuilder: (context, index) {
                                      final staff =
                                          staffController.staffList[index];
                                      return ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                        trailing: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return staffMemberMoreOptionDialog(
                                                        context, staff);
                                                  });
                                            },
                                            icon: const Icon(
                                              Icons.more_vert,
                                              size: 24,
                                            )),
                                        leading: CircleAvatar(
                                          child: SvgPicture.asset(staff.avtar),
                                        ),
                                        title: Text(
                                            "${staff.name} ${staff.lastName} "),
                                      );
                                    },
                                  ),
                                )
                              : const Center(
                                  child:
                                      Text(BaseStrings.noStaffMemberAvailable),
                                )),
            ),
          )
        ],
      ),
    );
  }

  ///staffMember more Option  staff Member
  Widget staffMemberMoreOptionDialog(
      BuildContext context, StaffModel staffModel) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color(0xffF8FAFC),
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      title: null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            labelText: BaseStrings.editStaff.toUpperCase(),
            onPressed: () {
              Navigator.of(context).pop();
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return EditStaffDailowidgets(
                      staffModel: staffModel,
                    );
                  });
            },
          ),
          10.toVSB,
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) {
                    return deleteStaffMemberMoreOptionDialog(
                        context, staffModel);
                  });
            },
            child: Text(
              BaseStrings.deleteStaff.toUpperCase(),
              style: getTheme(context: context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500, color: BaseColors.btnColor),
            ),
          )
        ],
      ),
    );
  }

  ///deleted  staff Member
  Widget deleteStaffMemberMoreOptionDialog(
      BuildContext context, StaffModel staff) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color(0xffF8FAFC),
      titlePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      title: Row(
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_sharp)),
          SizedBox(
            width: 230.w,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.left,
                  BaseStrings.deleteStaffTxt,
                  style: getTheme(context: context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        fontFamily: BaseStrings.interRegular,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            BackgroundColor: BaseColors.dltBtnColor,
            labelText: BaseStrings.deleteStaff.toUpperCase(),
            onPressed: () async {
              await staffController.deleteStaff(staff.id ?? 0).then(
                    (value) => fetchStaff(),
                  );
              Navigator.of(context).pop();
            },
          ),
          10.toVSB,
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              BaseStrings.keepOffice.toUpperCase(),
              style: getTheme(context: context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500, color: BaseColors.btnColor),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
