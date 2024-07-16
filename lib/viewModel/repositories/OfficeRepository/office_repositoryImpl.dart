import '../../../model/new_office_modle.dart';
import '../../../services/Database_services.dart';
import 'office_repository.dart';

class OfficeRepositoryImpl implements OfficeRepository {

  OfficeRepositoryImpl();


  @override
  Future<OfficeModel?> createOffice(OfficeModel office) async {
    return await OfficeDatabase.instance.create(office);
  }

  @override
  Future<List<OfficeModel>?> getAllOfficesData() async {
    return await OfficeDatabase.instance.readAllOffices();
  }

  @override
  Future<void> updateOffice(OfficeModel office) async {
    await OfficeDatabase.instance.update(office);
  }

  @override
  Future<void> deleteOffice(int id) async {
    await OfficeDatabase.instance.delete(id);
  }


}
