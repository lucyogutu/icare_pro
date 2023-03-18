// import 'package:flutter/material.dart';
// import 'package:icare_pro/application/core/colors.dart';
// import 'package:icare_pro/application/core/spaces.dart';
// import 'package:icare_pro/application/core/text_styles.dart';
// import 'package:icare_pro/domain/entities/appointment.dart';
// import 'package:icare_pro/domain/value_objects/app_strings.dart';
// import 'package:icare_pro/presentation/home/widgets/appointment_list_item_widget.dart';

// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Appointment> appointments = [
//       Appointment(
//         date: DateTime.now(),
//         doctor: 'Dr. Yusuf',
//         profession: physicianString,
//       ),
//       Appointment(
//         date: DateTime.now(),
//         doctor: 'Dr. Ramires',
//         profession: nurseString,
//       ),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           notificationString,
//           style: boldSize16Text(AppColors.blackColor),
//         ),
//         foregroundColor: AppColors.blackColor,
//         backgroundColor: AppColors.whiteColor,
//         shadowColor: AppColors.primaryColorLight,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 upcomingAppointmentsString,
//                 style: boldSize18Text(AppColors.primaryColor),
//               ),
//               smallVerticalSizedBox,
//               ...appointments.map((appointment) {
//                 return AppointmentListItemWidget(
//                   doctorName: appointment.doctor,
//                   doctorProfession: appointment.profession,
//                   date: appointment.date,
//                 );
//               }).toList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
