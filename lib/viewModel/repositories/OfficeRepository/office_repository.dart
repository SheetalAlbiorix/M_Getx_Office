import '../../../model/new_office_modle.dart';

abstract class OfficeRepository {

  Future<OfficeModel?> createOffice(OfficeModel office);
  Future<List<OfficeModel>?> getAllOfficesData();
  Future<void> updateOffice(OfficeModel office);
  Future<void> deleteOffice(int id);


}
