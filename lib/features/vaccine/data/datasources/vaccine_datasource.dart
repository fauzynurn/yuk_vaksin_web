import '../models/vaccine.dart';

abstract class VaccineDatasource {
  Future<List<Vaccine>> getVaccineList();

  Future<void> createVaccine(String vaccineName, int interval);

  Future<void> deleteVaccine(int vaccineId);

  Future<void> updateVaccine(int vaccineId, String vaccineName, int interval);
}
