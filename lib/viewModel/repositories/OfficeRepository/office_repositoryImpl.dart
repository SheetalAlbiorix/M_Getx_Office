import '../../../model/new_office_modle.dart';
import '../../../services/Database_services.dart';
import 'office_repository.dart';

class OfficeRepositoryImpl implements OfficeRepository {
  final OfficeDatabase? officeDatabase;

  OfficeRepositoryImpl({this.officeDatabase});

  @override
  Future<OfficeModel?> createOffice(OfficeModel office) async {
    return await officeDatabase?.create(office);
  }

  @override
  Future<List<OfficeModel>?> getAllOfficesData() async {
    return await officeDatabase?.readAllOffices();
  }

  @override
  Future<void> updateOffice(OfficeModel office) async {
    await officeDatabase?.update(office);
  }

  @override
  Future<void> deleteOffice(int id) async {
    await officeDatabase?.delete(id);
  }


}
