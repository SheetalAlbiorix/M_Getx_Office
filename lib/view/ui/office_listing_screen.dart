import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:m_getx_office/Controller/staff_controller.dart';

import 'package:m_getx_office/utils/extensions/base_extensions.dart';

import '../../Controller/office_controller.dart';
import '../../routes/routes.dart';
import '../../utils/constants/base_assets.dart';
import '../../utils/constants/base_colors.dart';
import '../../utils/constants/base_strings.dart';
import '../../utils/functions/base_funcations.dart';
import '../../utils/widgets/detail_widgets.dart';


class OfficeListingScreen extends StatefulWidget {
  const OfficeListingScreen({super.key});

  @override
  State<OfficeListingScreen> createState() => _OfficeListingScreenState();
}

class _OfficeListingScreenState extends State<OfficeListingScreen> {
  final OfficeController officeController = Get.find<OfficeController>();



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    officeController.expanded.value = List<bool>.filled(6, false);
    officeController.fetchOffices();});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) =>  Scaffold
        (
        backgroundColor: BaseColors.canvasColor,
        floatingActionButtonLocation:
        FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            backgroundColor: const Color(0xff0D4477),
            onPressed: () {
              Get.toNamed(BaseRoute.newOfficeScreen,);
            },
            child: SvgPicture.asset(BaseAssets.addIcon),
          ),
        ),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0.0,
          backgroundColor: BaseColors.canvasColor,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                BaseStrings.allOffices,
                style: getTheme(context: context).textTheme.headlineMedium,
              ),
            ),
            Obx(() {
              if (officeController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
                return officeController.offices.isNotEmpty ?
                Expanded(
                  child: ListView.builder(
                    itemCount: officeController.offices.length,
                    itemBuilder: (context, index) {
                      final office = officeController.offices[index];
                      final color =
                      Color(int.parse(office.color.substring(6, 16)));
                      return Obx(
                          ()=> AnimatedContainer(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          height:  officeController.expanded[index] ? 270.h : 132.h,
                          duration: const Duration(milliseconds: 300),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  width: 10, // Adjust width as needed
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    gradient: LinearGradient(
                                      colors: [
                                        color,
                                        color.withOpacity(0.5),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 22, right: 16, top: 17),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                           Get.toNamed(
                                                BaseRoute.officeViewScreen,
                                                arguments: office);

                                          },
                                          child: Text(
                                            office.name,
                                            style: getTheme(context: context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                color: BaseColors
                                                    .allOfficeTextColor,
                                                fontSize: 24.sp,
                                                fontWeight:
                                                FontWeight.w800),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                BaseRoute.editOfficeScreen,
                                                arguments: office);
                                          },
                                          child: SvgPicture.asset(
                                              BaseAssets.editIcon),
                                        ),
                                      ],
                                    ),
                                    11.toVSB,
                                    Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                            BaseAssets.peopleOverView),
                                        12.toHSB,
                                        Text.rich(TextSpan(
                                            text:
                                            "${officeController.officeInStaff[office.id ?? 0].toString()}  ",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                               BaseStrings.staffMemberInOffice,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    color: BaseColors
                                                        .allOfficeTextColor,
                                                    fontFamily: BaseStrings
                                                        .interRegular),
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
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            officeController.expanded[index] = !officeController.expanded[index];
                                          },
                                          child: Text(
                                            "More info",
                                            style: getTheme(context: context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                color: BaseColors
                                                    .allOfficeTextColor,
                                                fontSize: 12.sp,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                        ),
                                        5.toHSB,
                                        SvgPicture.asset(
                                          officeController.expanded[index] == false
                                              ? BaseAssets.downArrow
                                              : BaseAssets.upArrow,
                                        ),
                                      ],
                                    ),
                                    if ( officeController.expanded[index]) ...[
                                      Expanded(
                                        child: ListView(
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          children: [
                                            12.toVSB,
                                            customIconWithText(
                                                BaseAssets.callIcon,
                                                office.phoneNumber,
                                                context),
                                            12.toVSB,
                                            customIconWithText(
                                                BaseAssets.mailIcon,
                                                office.email,
                                                context),
                                            12.toVSB,
                                            customIconWithText(
                                                BaseAssets.peopledIcon,
                                                "Office Capacity: ${office.capacity}",
                                                context),
                                            12.toVSB,
                                            customIconWithText(
                                                BaseAssets.locationIcon,
                                                office.address,
                                                context),
                                          ],
                                        ),
                                      )
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ).paddingSymmetric(horizontal: 17, vertical: 10),
                      );
                    },
                  ),
                ):
                const Center(child: Text('No Offices Found'));

            }),
          ],
        ),
      ),
    );
  }
}
