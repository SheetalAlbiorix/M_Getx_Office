import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../../model/new_office_modle.dart';
import '../../../services/Database_services.dart';
import 'office_repository.dart';

class OfficeRepositoryImpl implements OfficeRepository {


  final OfficeDatabase officeDatabase = OfficeDatabase.instance;
  @override
  Future<OfficeModel?> createOffice(OfficeModel office) async {
    return await officeDatabase.create(office);
  }

  @override
  Future<List<OfficeModel>?> getAllOfficesData() async {
    try{
      final result = await officeDatabase.readAllOffices();
      return result.map((json) => OfficeModel.fromMap(json)).toList();
    }
    catch(e){
      GetSnackBar(message : "Error reading staff by office ID: $e");
      return null;
    }
  }


  @override
  Future<void> updateOffice(OfficeModel office) async {
    await officeDatabase.update(office);
  }

  @override
  Future<void> deleteOffice(int id) async {
    await officeDatabase.delete(id);
  }


}
