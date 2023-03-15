import 'dart:io';

class APIEndpoints {
  static String baseUrl = Platform.isAndroid ? 'http://192.168.188.104:8000/' :'http://127.0.0.1:8000/';

  //patients
  static const  String registerDoctor = 'doctors/register-doctor/';
  static const  String loginDoctor = 'doctors/login-doctor/';
  static const  String logoutDoctor = 'doctors/logout-doctor/';
  static const  String optoutDoctor = 'doctors/optout-doctor/';
  static const  String profileView = 'doctors/profile-view/';
  static const  String editProfileView = 'doctors/edit-profile-view/';

  //not implemented yet
  static const  String viewAppointments = 'doctors/view-appointments/';
  static const  String viewCanceledAppointments = 'doctors/view-canceled-appointments/';
  static const  String viewPastAppointments = 'doctors/view-past-appointments/';
  // // appointments
  // static const  String bookAppointment = 'appointments/';
  // static const  String rescheduleAppointment = 'appointments/reschedule-appointment/';
  // static const  String cancelAppointment = 'appointments/cancel-appointment/';

}