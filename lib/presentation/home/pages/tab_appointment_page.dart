import 'package:flutter/material.dart';
import 'package:icare_pro/application/api/api_services.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/entities/user.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/presentation/core/routes.dart';
import 'package:icare_pro/presentation/core/utils.dart';
import 'package:icare_pro/presentation/home/pages/canceled_appointments_page.dart';
import 'package:icare_pro/presentation/home/pages/past_appointment_page.dart';
import 'package:icare_pro/presentation/home/pages/upcoming_appointment_page.dart';

class TabAppointmentPage extends StatefulWidget {
  const TabAppointmentPage({super.key});

  @override
  State<TabAppointmentPage> createState() => _TabAppointmentPageState();
}

class _TabAppointmentPageState extends State<TabAppointmentPage> {
  Future<User>? _getUser;

  @override
  void initState() {
    super.initState();
    _getUser = getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.profile),
                  splashColor: AppColors.primaryColor,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FutureBuilder(
                        future: _getUser,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            errorAlert(context);
                          }
                          String fullName =
                              "${snapshot.data?.firstName!} ${snapshot.data?.lastName!}";
                          String initials = fullName
                              .split(' ')
                              .map((word) => word[0])
                              .join('');
                          return Text(
                            initials,
                            style: heavySize14Text(AppColors.primaryColor),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                appointmentString,
                style: heavySize20Text(AppColors.whiteColor),
              ),
              floating: true,
              pinned: true,
              backgroundColor: AppColors.primaryColor,
              bottom: const TabBar(
                indicatorColor: AppColors.whiteColor,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    text: upcomingString,
                  ),
                  Tab(
                    text: pastString,
                  ),
                  Tab(
                    text: cancelString,
                  ),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: [
            UpcomingAppointmentsPage(),
            PastAppointmentsPage(),
            CancelAppointmentsPage(),
          ],
        ),
      ),
    );
  }
}
