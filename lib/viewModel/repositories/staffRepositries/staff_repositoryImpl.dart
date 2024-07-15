import 'package:m_getx_office/viewModel/repositories/staffRepositries/staff_repository.dart';

import '../../../model/staff_model.dart';
import '../../../services/Database_services.dart';

class StaffRepositoryImPleMention implements StaffRepository {
  final OfficeDatabase? officeDatabase;

  StaffRepositoryImPleMention({this.officeDatabase});
  @override
  Future<StaffModel?> createStaff(StaffModel staff) async {
    return await officeDatabase?.createStaff(staff);
  }

  @override
  Future<List<StaffModel>?> readAllStaff() async {
    return await officeDatabase?.readAllStaff();
  }

  @override
  Future<List<StaffModel>?> readAllStaffByOfficeId(int officeId) async {
    return await officeDatabase?.readStaffByOffice(officeId);
  }

  @override
  Future<bool> updateOfficeStaff(StaffModel staff) async {
    try {
      await officeDatabase?.updateStaffByOffice(staff);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteStaff(int id) async {
    await officeDatabase?.deleteStaff(id);
  }

}