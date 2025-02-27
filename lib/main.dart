import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:m_getx_office/Controller/staff_controller.dart';
import 'package:m_getx_office/routes/pages.dart';
import 'package:m_getx_office/routes/routes.dart';
import 'package:m_getx_office/services/Database_services.dart';
import 'package:m_getx_office/view/ui/office_listing_screen.dart';
import 'package:m_getx_office/viewModel/repositories/OfficeRepository/office_repository.dart';
import 'package:m_getx_office/viewModel/repositories/OfficeRepository/office_repositoryImpl.dart';
import 'package:m_getx_office/viewModel/repositories/staffRepositries/staff_repository.dart';
import 'package:m_getx_office/viewModel/repositories/staffRepositries/staff_repositoryImpl.dart';

import 'Controller/office_controller.dart';


Future<void> main() async {
  Get.put<OfficeRepository>(
    OfficeRepositoryImpl(),
  );
  Get.put<StaffRepository>(
    StaffRepositoryImPleMention(),
  );
 Get.put(OfficeController(officeRepository:  Get.find<OfficeRepository>(),staffRepository:  Get.find<StaffRepository>()));
 Get.put(StaffController());

 runApp(ScreenUtilInit( builder: (context, child) =>
       const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      initialRoute: BaseRoute.officeScreen,
      debugShowCheckedModeBanner: false,
      home:  const OfficeListingScreenWithExitPrompt()
    );
  }
}

class OfficeListingScreenWithExitPrompt extends StatelessWidget {
  const OfficeListingScreenWithExitPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('Exit'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );
        return shouldExit;
      },
      child: const OfficeListingScreen(),
    );
  }
}