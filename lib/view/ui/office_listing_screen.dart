import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../Controller/office_controller.dart';
import '../../routes/routes.dart';
import '../../utils/constants/base_assets.dart';
import '../../utils/constants/base_colors.dart';
import '../../utils/constants/base_strings.dart';
import '../../utils/functions/base_funcations.dart';
import '../../utils/widgets/detail_widgets.dart';
import '../../viewModel/repositories/OfficeRepository/office_repository.dart';

class OfficeListingScreen extends StatefulWidget {
  const OfficeListingScreen({super.key});

  @override
  State<OfficeListingScreen> createState() => _OfficeListingScreenState();
}

class _OfficeListingScreenState extends State<OfficeListingScreen> {
  final OfficeController officeController =  Get.find<OfficeController>();
  List<TargetFocus> targets = [];
  TutorialCoachMark? tutorialCoachMark;
  final GlobalKey addButtonKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!officeController.startAnimation.value) {
        await officeController.fetchOffices();
        Future.delayed(const Duration(milliseconds: 300), () {
          officeController.startAnimation.value = true;
        });

        showTutorialIsDone();
      }
    });
  }

  Future<void> showTutorialIsDone() async {
    officeController.tutorialCoachIsDone.value = true;
    if(officeController.tutorialCoachIsDone.value == false){
      createTutorial();
   await   Future.delayed(Duration.zero,
          showTutorial
      );
    }
  }
  void showTutorial() {
    tutorialCoachMark?.show(context: context);
    officeController.tutorialCoachIsDone.value = true;
  }
  List<TargetFocus> _createTargets() {
    targets.add(
      TargetFocus(
        identify: "unique_target_1",
        keyTarget: addButtonKey,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Create New Office",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }
  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.red,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onClickTargetWithTapPosition: (target, tapDetails) {
      },
      onSkip: () {
        return true;
      },
    );
  }

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: BaseColors.canvasColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          key: addButtonKey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          backgroundColor: const Color(0xff0D4477),
          onPressed: () {
            Get.toNamed(preventDuplicates: false, BaseRoute.newOfficeScreen);
          },
          child: SvgPicture.asset(BaseAssets.addIcon,),
        ),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0.0,
        backgroundColor: BaseColors.canvasColor,
        automaticallyImplyLeading: false,
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  officeController.startAnimation.value = true;
                });
              },
              child: Text(
                BaseStrings.allOffices,
                style: getTheme(context: context).textTheme.headlineMedium,
              ),
            ),
          ),
          Obx(() {
            if (officeController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (officeController.expanded.length !=
                officeController.offices.length) {
              officeController.expanded.value =
                  List.filled(officeController.offices.length, false);
              officeController.screenWidth =  MediaQuery.of(context).size.width;
            }
            return officeController.offices.isNotEmpty
                ? Expanded(
                    child:ListView.builder(
                      itemCount: officeController.offices.length,
                      itemBuilder: ( context, int index,) {
                        final office = officeController.offices[index];
                        Future.delayed(const Duration(milliseconds: 300), () {
                          officeController.startAnimation.value = true;
                        });
                        return AnimatedContainer(
                          width: double.infinity,
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          height: officeController.expanded[index] ? 270.h : 132.h,
                          duration:  Duration(milliseconds: 300 + (index*300)),
                          transform: Matrix4.translationValues(
                            officeController.startAnimation.value ? 0 : officeController.screenWidth,
                            0,
                            0,
                          ),
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
                                        bottomLeft: Radius.circular(10)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(int.parse(office.color)),
                                        Color(int.parse(office.color))
                                            .withOpacity(0.5)
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
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            BaseRoute.officeViewScreen,
                                            arguments: office);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
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
                                          InkWell(
                                            radius: 15,
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
                                    ),
                                    10.toVSB,
                                    InkWell(
                                      onTap: (){
                                        Get.toNamed(
                                            BaseRoute.officeViewScreen,
                                            arguments: office);
                                      },
                                      child: Row(
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
                                                  text: BaseStrings
                                                      .staffMemberInOffice,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: BaseColors
                                                          .allOfficeTextColor,
                                                      fontFamily: BaseStrings
                                                          .interRegular),
                                                )
                                              ])),
                                        ],
                                      ),
                                    ),
                                    9.toVSB,
                                    Divider(
                                      indent: 5,
                                      endIndent: 10,
                                      height: 0.4.h,
                                      color: const Color(0xff0D4477),
                                    ),
                                    10.toVSB,
                                    InkWell(
                                      onTap: () {
                                        officeController.expanded[index] =
                                            !officeController.expanded[index];
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
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
                                          5.toHSB,
                                          SvgPicture.asset(
                                            officeController.expanded[index] ==
                                                    false
                                                ? BaseAssets.downArrow
                                                : BaseAssets.upArrow,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (officeController.expanded[index]) ...[
                                      Expanded(
                                        child: ListView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            12.toVSB,
                                            GestureDetector(
                                               onTap:() => officeController.makingPhoneCall( office.phoneNumber)
                                              ,child: customIconWithText(
                                                  BaseAssets.callIcon,
                                                  office.phoneNumber,
                                                  context),
                                            ),
                                            12.toVSB,
                                            GestureDetector(
                                              onTap: () => officeController.makingGmailID(office.email),
                                              child: customIconWithText(
                                                  BaseAssets.mailIcon,
                                                  office.email,
                                                  context),
                                            ),
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
                        ).paddingSymmetric(horizontal: 17, vertical: 10);
                      },
                    ),
                  )
                : const Center(child: Text('No Offices Found'));
          }),
        ],
      ),
    );
  }
}
