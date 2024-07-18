import 'package:get/get.dart';
import 'package:m_getx_office/viewModel/repositories/staffRepositries/staff_repository.dart';
import '../../../model/staff_model.dart';
import '../../../services/Database_services.dart';

class StaffRepositoryImPleMention implements StaffRepository {
  final OfficeDatabase officeDatabase = OfficeDatabase.instance;

  @override
  Future<StaffModel?> createStaff(StaffModel staff) async {
    return await officeDatabase.createStaff(staff);
  }

  @override
  Future<List<StaffModel>?> readAllStaffByOfficeId(int officeId) async {
    try {
      final result = await officeDatabase.readStaffByOffice(officeId);
      return result.map((json) => StaffModel.fromMap(json)).toList();
    } catch (e) {
     GetSnackBar(message : "Error reading staff by office ID: $e");
      return null;
    }
  }

  @override
  Future<bool> updateOfficeStaff(StaffModel staff) async {
    try {
      await officeDatabase.updateStaffByOffice(staff);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteStaff(int id) async {
    await officeDatabase.deleteStaff(id);
  }

}