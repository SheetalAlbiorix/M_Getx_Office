import '../../../model/staff_model.dart';

abstract class StaffRepository {
  Future<StaffModel?> createStaff(StaffModel staff);

  Future<List<StaffModel>?> readAllStaff();

  Future<List<StaffModel>?> readAllStaffByOfficeId(int officeId);

  Future<bool> updateOfficeStaff(StaffModel staff);

  Future<void> deleteStaff(int id);
}
