import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_pro/application/api/api_services.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/application/core/spaces.dart';
import 'package:icare_pro/application/core/text_styles.dart';
import 'package:icare_pro/domain/entities/user.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';
import 'package:icare_pro/domain/value_objects/enums.dart';
import 'package:icare_pro/domain/value_objects/regex.dart';
import 'package:icare_pro/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_pro/presentation/core/icare_elevated_button.dart';
import 'package:icare_pro/presentation/core/icare_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.signIn,
  });
  final VoidCallback signIn;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  Gender? gender;
  TextEditingController dateinput = TextEditingController();
  final TextEditingController _password = TextEditingController();

  DateTime? selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  Future<User>? _registerUser;

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

  User _displayGender(Gender gender) {
    if (gender == Gender.male) {
      _user = User(
        firstName: _user.firstName,
        lastName: _user.lastName,
        email: _user.email,
        phoneNumber: _user.phoneNumber,
        gender: male,
        password: _user.password,
        dateOfBirth: _user.dateOfBirth,
        bio: _user.bio,
        specialization: _user.specialization,
        yearsOfExperience: _user.yearsOfExperience,
        clinic: _user.clinic,
        address: _user.address,
      );
      return _user;
    } else if (gender == Gender.female) {
      _user = User(
        firstName: _user.firstName,
        lastName: _user.lastName,
        email: _user.email,
        phoneNumber: _user.phoneNumber,
        gender: female,
        password: _user.password,
        dateOfBirth: _user.dateOfBirth,
        bio: _user.bio,
        specialization: _user.specialization,
        yearsOfExperience: _user.yearsOfExperience,
        clinic: _user.clinic,
        address: _user.address,
      );
      return _user;
    } else {
      _user = User(
        firstName: _user.firstName,
        lastName: _user.lastName,
        email: _user.email,
        phoneNumber: _user.phoneNumber,
        gender: other,
        password: _user.password,
        dateOfBirth: _user.dateOfBirth,
        bio: _user.bio,
        specialization: _user.specialization,
        yearsOfExperience: _user.yearsOfExperience,
        clinic: _user.clinic,
        address: _user.address,
      );
      return _user;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _registerUser = registerUser(_user);
    }
  }

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _showConfirmPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorLight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (_registerUser == null)
              ? Column(
                  children: [
                    largeVerticalSizedBox,
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            child: SvgPicture.asset(
                              userSvg,
                              fit: BoxFit.cover,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    mediumVerticalSizedBox,
                    Text(
                      registerString,
                      style: boldSize25Title(
                        AppColors.primaryColor,
                      ),
                    ),
                    mediumVerticalSizedBox,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // first name
                          ICareTextFormField(
                            label: firstNameString,
                            prefixIcon: Icons.person,
                            hintText: firstNameHintString,
                            fillColor: AppColors.whiteColor,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return fieldCannotBeEmptyString;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(
                                () {
                                  _user = User(
                                    firstName: value,
                                    lastName: _user.lastName,
                                    email: _user.email,
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
                              );
                            },
                          ),
                          // last name
                          ICareTextFormField(
                            label: lastNameString,
                            prefixIcon: Icons.person,
                            hintText: lastNameHintString,
                            fillColor: AppColors.whiteColor,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return fieldCannotBeEmptyString;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(
                                () {
                                  _user = User(
                                    firstName: _user.firstName,
                                    lastName: value,
                                    email: _user.email,
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
                              );
                            },
                          ),
                          mediumVerticalSizedBox,
                          // email
                          ICareTextFormField(
                            label: emailString,
                            prefixIcon: Icons.email,
                            hintText: emailHintString,
                            fillColor: AppColors.whiteColor,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (!emailRegex.hasMatch(value!) ||
                                  value.isEmpty) {
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
                          // phone number
                          ICareTextFormField(
                            label: phoneNumberString,
                            prefixIcon: Icons.phone,
                            hintText: phoneNumberHintString,
                            fillColor: AppColors.whiteColor,
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return fieldCannotBeEmptyString;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _user = User(
                                  firstName: _user.firstName,
                                  lastName: _user.lastName,
                                  email: _user.email,
                                  phoneNumber: int.parse(value!),
                                  gender: _user.gender,
                                  password: _user.password,
                                  dateOfBirth: _user.dateOfBirth,
                                  bio: _user.bio,
                                  specialization: _user.specialization,
                                  yearsOfExperience: _user.yearsOfExperience,
                                  clinic: _user.clinic,
                                  address: _user.address,
                                );
                              });
                            },
                          ),
                          mediumVerticalSizedBox,
                          // password
                          ICareTextFormField(
                            controller: _password,
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
                              setState(() {
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
                              });
                            },
                          ),
                          mediumVerticalSizedBox,
                          // confirm password
                          ICareTextFormField(
                            label: confirmPasswordString,
                            prefixIcon: Icons.lock,
                            hintText: confirmPasswordHintString,
                            fillColor: AppColors.whiteColor,
                            obscureText: !_showConfirmPassword,
                            suffixIcon: _showConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixOnPressed: () {
                              setState(() {
                                _showConfirmPassword = !_showConfirmPassword;
                              });
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return fieldCannotBeEmptyString;
                              } else if (value != _password.text) {
                                return passwordsMustMatch;
                              }
                              return null;
                            },
                          ),
                          mediumVerticalSizedBox,
                          // gender
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  genderString,
                                  style: boldSize14Text(AppColors.primaryColor),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: RadioListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text(
                                        male,
                                        style: normalSize14Text(
                                            AppColors.blackColor),
                                      ),
                                      value: Gender.male,
                                      groupValue: gender,
                                      activeColor: AppColors.primaryColor,
                                      onChanged: (Gender? genderValue) {
                                        setState(() {
                                          gender = genderValue;
                                          _user = _displayGender(gender!);
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: RadioListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text(
                                        female,
                                        style: normalSize14Text(
                                            AppColors.blackColor),
                                      ),
                                      value: Gender.female,
                                      groupValue: gender,
                                      activeColor: AppColors.primaryColor,
                                      onChanged: (Gender? genderValue) {
                                        setState(() {
                                          gender = genderValue;
                                          _user = _displayGender(gender!);
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: RadioListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text(
                                        other,
                                        style: normalSize14Text(
                                            AppColors.blackColor),
                                      ),
                                      value: Gender.other,
                                      groupValue: gender,
                                      activeColor: AppColors.primaryColor,
                                      onChanged: (Gender? genderValue) {
                                        setState(() {
                                          gender = genderValue;
                                          _user = _displayGender(gender!);
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          mediumVerticalSizedBox,
                          // date of birth
                          ICareTextFormField(
                            controller: dateinput,
                            label: dateOfBirthString,
                            readOnly: true,
                            prefixIcon: Icons.calendar_today_rounded,
                            hintText: dateOfBirthHintString,
                            fillColor: AppColors.whiteColor,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      1950), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now());

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                setState(() {
                                  dateinput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                const Text(dateOfBirthHintString);
                              }
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return fieldCannotBeEmptyString;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _user = User(
                                  firstName: _user.firstName,
                                  lastName: _user.lastName,
                                  email: _user.email,
                                  phoneNumber: _user.phoneNumber,
                                  gender: _user.gender,
                                  password: _user.password,
                                  dateOfBirth: value,
                                  bio: _user.bio,
                                  specialization: _user.specialization,
                                  yearsOfExperience: _user.yearsOfExperience,
                                  clinic: _user.clinic,
                                  address: _user.address,
                                );
                              });
                            },
                          ),
                          mediumVerticalSizedBox,
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ICareElevatedButton(
                              onPressed: () {
                                _submitForm();
                                widget.signIn;
                              },
                              text: signUpString,
                            ),
                          ),
                          smallVerticalSizedBox,
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: alreadyHaveAccountString,
                                  style: normalSize12Text(
                                    AppColors.blackColor,
                                  ),
                                ),
                                TextSpan(
                                  text: signInString,
                                  style: normalSize12Text(
                                    AppColors.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.signIn,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(child: buildFutureBuilder()),
        ),
      ),
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _registerUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return const SnackBar(
          //   content: Text('User registered successfully'),
          // );
          return const Center(
            child: Text(successUserRegistered),
          );
        } else if (snapshot.hasError) {
          return Flexible(
            child: Center(
              child: AlertDialog(
                title: const Text(errorString),
                content: Text('${snapshot.error}'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(retryString),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
