import 'package:image_picker/image_picker.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/event_session.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/vaccine_place.dart';

import '../../detail/vaccine_schedule_session/detail/data/models/user_vaccine_registration.dart';
import '../models/lat_long.dart';
import '../models/location.dart';

abstract class VaccinePlaceDataSource {
  Future<List<VaccinePlace>> getVaccinePlaceList(
    String startDate,
    String endDate,
    int page,
    int size,
  );

  Future<List<Location>> getPlaceList(
    String query,
  );

  Future<String> getCompleteAddress(
    double latitude,
    double longitude,
  );

  Future<LatLong> getLatLong(
    String placeId,
  );

  Future<String> uploadPhoto(
    XFile imageFile,
  );

  Future<bool> addVaccinePlace(
    String locationName,
    String address,
    double latitude,
    double longitude,
    String startDate,
    String endDate,
    String imageUrl,
  );

  Future<void> deleteVaccinePlace(
    int eventId,
  );

  Future<List<EventSession>> getEventSessionList(
    int eventScheduleId,
  );

  Future<void> updateVaccinePlace(
    int vaccinePlaceId,
    String locationName,
    String address,
    double latitude,
    double longitude,
    String startDate,
    String endDate,
    String imageUrl,
  );

  Future<void> createEventSession(
    int eventId,
    int vaccineId,
    int quota,
    String startTime,
    String endTime,
    int session,
    int vaccineType,
  );

  Future<void> updateEventSession(
    int eventScheduleId,
    int eventId,
    int vaccineId,
    int quota,
    String startTime,
    String endTime,
    int session,
    int vaccineType,
  );

  Future<void> deleteEventSession(int eventScheduleId);

  Future<List<UserVaccineRegistration>> getUserVaccineRegistrationList(
    int eventScheduleId,
    int eventId,
    int offset,
    int limit,
    String orderNumber,
  );

  Future<void> uploadCertificate(
    int userId,
    int orderId,
    String certificateUrl,
  );
}
