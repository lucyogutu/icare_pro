import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_pro/application/api/api_services.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/entities/user.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/domain/value_objects/regex.dart';
import 'package:icare_pro/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_pro/presentation/core/icare_elevated_button.dart';
import 'package:icare_pro/presentation/core/icare_text_button.dart';
import 'package:icare_pro/presentation/core/icare_text_form_field.dart';
import 'package:icare_pro/presentation/core/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.signUp,
  }) : super(key: key);
  final VoidCallback signUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _showPassword;

  Future<User>? _loginUser;
  final _formKey = GlobalKey<FormState>();

  User _user = User(
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: 0,
    gender: '',
    password: '',
    dateOfBirth: '',
    bio: '',
    specialization: '',
    yearsOfExperience: 0,
    clinic: '',
    address: '',
  );

  @override
  void initState() {
    super.initState();
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorLight,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                smallVerticalSizedBox,
                Center(
                  child: SvgPicture.asset(accessAccountSvg),
                ),
                largeVerticalSizedBox,
                Text(
                  welcomeString,
                  style: boldSize30Text(
                    AppColors.primaryColor,
                  ),
                ),
                largeVerticalSizedBox,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ICareTextFormField(
                        label: emailString,
                        prefixIcon: Icons.mail,
                        hintText: emailHintString,
                        fillColor: AppColors.whiteColor,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (!emailRegex.hasMatch(value!) || value.isEmpty) {
                            return inputValidEmailString;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _user = User(
                            firstName: _user.firstName,
                            lastName: _user.lastName,
                            email: value,
                            phoneNumber: _user.phoneNumber,
                            gender: _user.gender,
                            password: _user.password,
                            dateOfBirth: _user.dateOfBirth,
                            bio: _user.bio,
                            specialization: _user.specialization,
                            yearsOfExperience: _user.yearsOfExperience,
                            clinic: _user.clinic,
                            address: _user.address,
                          );
                        },
                      ),
                      mediumVerticalSizedBox,
                      ICareTextFormField(
                        label: passwordString,
                        prefixIcon: Icons.lock,
                        hintText: passwordHintString,
                        fillColor: AppColors.whiteColor,
                        obscureText: !_showPassword,
                        suffixIcon: _showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixOnPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return fieldCannotBeEmptyString;
                          } else if (value.length < 8) {
                            return passwordHave8Characters;
                          } else if (isNumeric(value)) {
                            return passwordCannotContainNumbersOnly;
                          } else if (!value.contains(passwordRegex) ||
                              !value.contains(numericRegex)) {
                            return passwordTooCommonString;
                          }

                          return null;
                        },
                        onSaved: (value) {
                          setState(
                            () {
                              _user = User(
                                firstName: _user.firstName,
                                lastName: _user.lastName,
                                email: _user.email,
                                phoneNumber: _user.phoneNumber,
                                gender: _user.gender,
                                password: value,
                                dateOfBirth: _user.dateOfBirth,
                                bio: _user.bio,
                                specialization: _user.specialization,
                                yearsOfExperience: _user.yearsOfExperience,
                                clinic: _user.clinic,
                                address: _user.address,
                              );
                            },
                          );
                        },
                      ),
                      smallVerticalSizedBox,
                      ICareTextButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(AppRoutes.forgotPassword),
                        text: forgotPasswordString,
                        style: boldSize16Text(AppColors.primaryColor),
                      ),
                      smallVerticalSizedBox,
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ICareElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('showHome', true);
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              try {
                                final user = await loginUser(_user);
                                Navigator.of(context).pushReplacementNamed(
                                    AppRoutes.tabAppointment);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(successLogin),
                                  backgroundColor: (Colors.black87),
                                  duration: const Duration(seconds: 5),
                                  action: SnackBarAction(
                                    label: dismissString,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ));
                                setState(() {
                                  _loginUser = Future.value(user);
                                });
                              } catch (error) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text(somethingWentWrongString),
                                        content: Text(error.toString()),
                                        actions: [
                                          ICareTextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            text: okString,
                                            style: boldSize14Text(
                                                AppColors.primaryColor),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          text: signInString,
                        ),
                      ),
                      smallVerticalSizedBox,
                      Text(
                        orString,
                        textAlign: TextAlign.center,
                        style: normalSize14Text(AppColors.greyTextColor),
                      ),
                      smallVerticalSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(googleIconSvg),
                            onPressed: () {},
                          ),
                          largeHorizontalSizedBox,
                          IconButton(
                            icon: SvgPicture.asset(facebookIconSvg),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      smallVerticalSizedBox,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: dontHaveAccountString,
                              style: normalSize12Text(
                                AppColors.blackColor,
                              ),
                            ),
                            TextSpan(
                              text: signUpString,
                              style: normalSize12Text(
                                AppColors.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.signUp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
