

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:m_getx_office/routes/routes.dart';


class AppPages {

  static List<GetPage> pages = [
    GetPage(
      name: BaseRoute.officeViewScreen,
      page: () => OfficeViewScreen(),
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
      transition: Transition.fadeIn,
    ),
    GetPage(
      name:  BaseRoute.editOfficeScreen,
      page: () => EditOfficeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name:  BaseRoute.editStaffDialogWidgets,
      page: () => EditStaffDialogWidgets(),
      transition: Transition.fadeIn,
    ),
  ];
}
