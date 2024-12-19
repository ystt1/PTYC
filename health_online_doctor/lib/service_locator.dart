import 'package:get_it/get_it.dart';
import 'package:health_online_doctor/data/appointment/repository_imp/appointment_repository_imp.dart';
import 'package:health_online_doctor/data/appointment/service/appointment_springboot_service.dart';
import 'package:health_online_doctor/data/auth/repository_imp/auth_repository_imp.dart';
import 'package:health_online_doctor/data/auth/service/auth_service_springboot.dart';
import 'package:health_online_doctor/data/prescription/repository_imp/prescription_repository_imp.dart';
import 'package:health_online_doctor/data/prescription/service/prescription_springboot_service.dart';
import 'package:health_online_doctor/data/review/repository_imp/review_repository_imp.dart';
import 'package:health_online_doctor/data/review/service/review_springboot_service.dart';
import 'package:health_online_doctor/domain/appointment/repository/appointment_repository.dart';
import 'package:health_online_doctor/domain/appointment/usecase/get_appointment_today_usecase.dart';
import 'package:health_online_doctor/domain/prescription/repository/prescription_repository.dart';
import 'package:health_online_doctor/domain/prescription/usecase/add_prescription_usecase.dart';
import 'package:health_online_doctor/domain/prescription/usecase/find_medical_usecase.dart';
import 'package:health_online_doctor/domain/prescription/usecase/get_prescription_usecase.dart';
import 'package:health_online_doctor/domain/review/repository/review_repository.dart';
import 'package:health_online_doctor/domain/review/usecase/get_review_usecase.dart';

import 'domain/auth/repository/auth_repository.dart';
import 'domain/auth/usecase/login_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
//service
  sl.registerSingleton<AuthServiceSpringboot>(AuthServiceSpringbootImp());
  sl.registerSingleton<AppointmentSpringbootService>(
      AppointmentSpringbootServiceImp());
  sl.registerSingleton<ReviewSpringbootService>(ReviewSpringbootServiceImp());
  sl.registerSingleton<PrescriptionSpringbootService>(PrescriptionSpringbootServiceImp());
//repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp());
  sl.registerSingleton<AppointmentRepository>(AppointmentRepositoryImp());
  sl.registerSingleton<ReviewRepository>(ReviewRepositoryImp());
  sl.registerSingleton<PrescriptionRepository>(PrescriptionRepositoryImp());
//usecase
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
  sl.registerSingleton<GetAppointmentTodayUseCase>(
      GetAppointmentTodayUseCase());
  sl.registerSingleton<GetReviewUseCase>(GetReviewUseCase());
  sl.registerSingleton<GetPrescriptionUseCase>(GetPrescriptionUseCase());
  sl.registerSingleton<FindMedicalUseCase>(FindMedicalUseCase());
  sl.registerSingleton<AddPrescriptionUseCase>(AddPrescriptionUseCase());
}
