

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:m_getx_office/routes/routes.dart';
import 'package:m_getx_office/view/ui/staff_view/Edit_staff_dailoWidgets.dart';

import '../view/ui/office_listing_screen.dart';
import '../view/ui/office_view/Edit_office_screen.dart';
import '../view/ui/office_view/new_office_screen.dart';
import '../view/ui/office_view_screen.dart';



class AppPages {

  static List<GetPage> pages = [
    GetPage(
      name: BaseRoute.officeViewScreen,
      page: () => OfficeViewScreen(officeModel: Get.arguments,),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name:  BaseRoute.officeScreen,
      page: () => OfficeListingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name:  BaseRoute.newOfficeScreen,
      page: () => NewOfficeScreen(),
    ),
    GetPage(
      name:  BaseRoute.editOfficeScreen,
      page: () => EditOfficeScreen(office: Get.arguments,),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name:  BaseRoute.editStaffDailowidgets,
      page: () =>  EditStaffDailowidgets(staffModel: Get.arguments,),
      transition: Transition.fadeIn,
    ),
  ];
}
