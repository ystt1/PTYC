import 'package:get_it/get_it.dart';
import 'package:health_online_admin/data/doctor/repository_imp/doctor_repository_imp.dart';
import 'package:health_online_admin/data/doctor/service/doctor_service.dart';
import 'package:health_online_admin/data/medical/repository_imp/medical_repository_imp.dart';
import 'package:health_online_admin/data/medical/service/medical_service.dart';
import 'package:health_online_admin/data/patient/repository_imp/patient_repository_imp.dart';
import 'package:health_online_admin/data/patient/service/patient_service.dart';
import 'package:health_online_admin/domain/doctor/repository/doctor_repository.dart';
import 'package:health_online_admin/domain/doctor/usecase/add_doctor_usecase.dart';
import 'package:health_online_admin/domain/doctor/usecase/delete_doctor_usecase.dart';
import 'package:health_online_admin/domain/doctor/usecase/get_doctor_usecase.dart';
import 'package:health_online_admin/domain/doctor/usecase/update_doctor_usecase.dart';
import 'package:health_online_admin/domain/medicine/repository/medical_repository.dart';
import 'package:health_online_admin/domain/medicine/usecase/add_medical_usecase.dart';
import 'package:health_online_admin/domain/medicine/usecase/delete_medical_usecase.dart';
import 'package:health_online_admin/domain/medicine/usecase/get_medical_usecase.dart';
import 'package:health_online_admin/domain/medicine/usecase/update_medical_usecase.dart';
import 'package:health_online_admin/domain/patient/repository/patient_repository.dart';
import 'package:health_online_admin/domain/patient/usecase/add_patient_usecase.dart';
import 'package:health_online_admin/domain/patient/usecase/delete_patient_usecase.dart';
import 'package:health_online_admin/domain/patient/usecase/get_patient_usecase.dart';
import 'package:health_online_admin/domain/patient/usecase/update_patient_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
//service
  sl.registerSingleton<PatientService>(PatientServiceImp());
  sl.registerSingleton<MedicalService>(MedicalServiceImp());
  sl.registerSingleton<DoctorService>(DoctorServiceImp());
//repository
  sl.registerSingleton<PatientRepository>(PatientRepositoryImp());
  sl.registerSingleton<MedicalRepository>(MedicalRepositoryImp());
  sl.registerSingleton<DoctorRepository>(DoctorRepositoryImp());
//usecase
  sl.registerSingleton<GetPatientUseCase>(GetPatientUseCase());
  sl.registerSingleton<AddPatientUseCase>(AddPatientUseCase());
  sl.registerSingleton<UpdatePatientUsecase>(UpdatePatientUsecase());
  sl.registerSingleton<DeletePatientUseCase>(DeletePatientUseCase());

  sl.registerSingleton<GetMedicalUseCase>(GetMedicalUseCase());
  sl.registerSingleton<AddMedicalUseCase>(AddMedicalUseCase());
  sl.registerSingleton<UpdateMedicalUseCase>(UpdateMedicalUseCase());
  sl.registerSingleton<DeleteMedicalUseCase>(DeleteMedicalUseCase());

  sl.registerSingleton<GetDoctorUseCase>(GetDoctorUseCase());
  sl.registerSingleton<AddDoctorUseCase>(AddDoctorUseCase());
  sl.registerSingleton<UpdateDoctorUseCase>(UpdateDoctorUseCase());
  sl.registerSingleton<DeleteDoctorUseCase>(DeleteDoctorUseCase());
}
