class AppointmentEntity{
  final String id;
  final String userId;
  final String dayBooking;
  final int hourBooking;
  final String victimName;
  final String description;
  final int age;
  final int status;

  AppointmentEntity({required this.id, required this.userId, required this.dayBooking, required this.hourBooking, required this.victimName, required this.description, required this.age, required this.status});


}