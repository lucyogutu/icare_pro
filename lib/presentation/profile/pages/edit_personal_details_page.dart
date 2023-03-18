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
import 'package:icare_pro/presentation/core/icare_text_button.dart';
import 'package:icare_pro/presentation/core/icare_text_form_field.dart';
import 'package:icare_pro/presentation/core/utils.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

class EditPersonalDetailsPage extends StatefulWidget {
  const EditPersonalDetailsPage({super.key, required this.getProfileDetails});

  final Future<User>? getProfileDetails;

  @override
  State<EditPersonalDetailsPage> createState() =>
      _EditPersonalDetailsPageState();
}

class _EditPersonalDetailsPageState extends State<EditPersonalDetailsPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  Gender? gender;
  TextEditingController dateinputController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController yrOfExpController = TextEditingController();
  TextEditingController clinicController = TextEditingController();
  TextEditingController addressControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate = DateTime.now();
  Future<User>? _editProfileDetails;

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _showConfirmPassword = false;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editPersonalDetailsString,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColor.withOpacity(0.25),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: widget.getProfileDetails,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                errorAlert(context);
              }
              firstNameController.text = snapshot.data!.firstName!;
              lastNameController.text = snapshot.data!.lastName!;
              emailController.text = snapshot.data!.email!;
              phoneNumberController.text = '0${snapshot.data!.phoneNumber}';
              // gender = snapshot.data!.gender as Gender;
              dateinputController.text = snapshot.data!.dateOfBirth!;
              bioController.text = snapshot.data!.bio!;
              specializationController.text = snapshot.data!.specialization!;
              yrOfExpController.text = '${snapshot.data!.yearsOfExperience!}';
              clinicController.text = snapshot.data!.clinic!;
              addressControler.text = snapshot.data!.address!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  smallVerticalSizedBox,
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.primaryColor.withOpacity(0.25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FittedBox(
                          child: SvgPicture.asset(userSvg),
                        ),
                      ),
                    ),
                  ),
                  smallVerticalSizedBox,
                  Text(
                    '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                    style: boldSize18Text(AppColors.blackColor),
                  ),
                  verySmallVerticalSizedBox,
                  Divider(
                    color: AppColors.primaryColor.withOpacity(0.25),
                  ),
                  verySmallVerticalSizedBox,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // first name
                        ICareTextFormField(
                          controller: firstNameController,
                          label: firstNameString,
                          prefixIcon: Icons.person,
                          hintText: firstNameHintString,
                          fillColor: AppColors.primaryColorLight,
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
                                  firstName: value!,
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
                        mediumVerticalSizedBox,
                        // last name
                        ICareTextFormField(
                          controller: lastNameController,
                          label: lastNameString,
                          prefixIcon: Icons.person,
                          hintText: lastNameHintString,
                          fillColor: AppColors.primaryColorLight,
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
                                  lastName: value!,
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
                          controller: emailController,
                          label: emailString,
                          prefixIcon: Icons.email,
                          hintText: emailHintString,
                          fillColor: AppColors.primaryColorLight,
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
                              email: value!,
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
                          controller: phoneNumberController,
                          label: phoneNumberString,
                          prefixIcon: Icons.phone,
                          hintText: phoneNumberHintString,
                          fillColor: AppColors.primaryColorLight,
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
                          controller: passwordController,
                          label: passwordString,
                          prefixIcon: Icons.lock,
                          hintText: passwordHintString,
                          fillColor: AppColors.primaryColorLight,
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
                                password: value!,
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
                          fillColor: AppColors.primaryColorLight,
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
                            } else if (value != passwordController.text) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          controller: dateinputController,
                          label: dateOfBirthString,
                          readOnly: true,
                          prefixIcon: Icons.calendar_today_rounded,
                          hintText: dateOfBirthHintString,
                          fillColor: AppColors.primaryColorLight,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    1950), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime.now());

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateinputController.text =
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
                                dateOfBirth: value!,
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
                        // bio
                        TextFormField(
                          controller: bioController,
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: AppColors.hintTextColor),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                            ),
                            labelText: bioString,
                            //lable style
                            labelStyle:
                                normalSize14Text(AppColors.primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.primaryColorLight,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: const EdgeInsets.all(8.0),
                          ),
                          style: const TextStyle(
                            color: AppColors.blackColor,
                          ),
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
                                  lastName: _user.lastName,
                                  email: _user.email,
                                  phoneNumber: _user.phoneNumber,
                                  gender: _user.gender,
                                  password: _user.password,
                                  dateOfBirth: _user.dateOfBirth,
                                  bio: value!,
                                  specialization: _user.specialization,
                                  yearsOfExperience: _user.yearsOfExperience,
                                  clinic: _user.clinic,
                                  address: _user.address,
                                );
                              },
                            );
                          },
                          maxLines: 3,
                        ),
                        mediumVerticalSizedBox,
                        // specialization
                        ICareTextFormField(
                          controller: specializationController,
                          label: specializationString,
                          prefixIcon: Icons.person,
                          fillColor: AppColors.primaryColorLight,
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
                                  lastName: _user.lastName,
                                  email: _user.email,
                                  phoneNumber: _user.phoneNumber,
                                  gender: _user.gender,
                                  password: _user.password,
                                  dateOfBirth: _user.dateOfBirth,
                                  bio: _user.bio,
                                  specialization: value!,
                                  yearsOfExperience: _user.yearsOfExperience,
                                  clinic: _user.clinic,
                                  address: _user.address,
                                );
                              },
                            );
                          },
                        ),
                        mediumVerticalSizedBox,
                        // years of experience
                        ICareTextFormField(
                          controller: yrOfExpController,
                          label: yearsOfExperienceString,
                          prefixIcon: Icons.person,
                          fillColor: AppColors.primaryColorLight,
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
                                  lastName: _user.lastName,
                                  email: _user.email,
                                  phoneNumber: _user.phoneNumber,
                                  gender: _user.gender,
                                  password: _user.password,
                                  dateOfBirth: _user.dateOfBirth,
                                  bio: _user.bio,
                                  specialization: _user.specialization,
                                  yearsOfExperience: int.parse(value!),
                                  clinic: _user.clinic,
                                  address: _user.address,
                                );
                              },
                            );
                          },
                        ),
                        mediumVerticalSizedBox,
                        // clinic
                        ICareTextFormField(
                          controller: clinicController,
                          label: clinicString,
                          prefixIcon: Icons.person,
                          fillColor: AppColors.primaryColorLight,
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
                                  lastName: _user.lastName,
                                  email: _user.email,
                                  phoneNumber: _user.phoneNumber,
                                  gender: _user.gender,
                                  password: _user.password,
                                  dateOfBirth: _user.dateOfBirth,
                                  bio: _user.bio,
                                  specialization: _user.specialization,
                                  yearsOfExperience: _user.yearsOfExperience,
                                  clinic: value!,
                                  address: _user.address,
                                );
                              },
                            );
                          },
                        ),
                        mediumVerticalSizedBox,
                        // address
                        ICareTextFormField(
                          controller: addressControler,
                          label: addressString,
                          prefixIcon: Icons.person,
                          fillColor: AppColors.primaryColorLight,
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
                                  address: value!,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  mediumVerticalSizedBox,
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ICareElevatedButton(
                      text: saveString,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          try {
                            final user = await editUserProfile(_user);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(successString),
                                    content: const Text(successProfileUpdated),
                                    actions: [
                                      ICareTextButton(
                                        onPressed: () {
                                          widget.getProfileDetails;
                                          Navigator.of(context).pop();
                                        },
                                        text: okString,
                                        style: boldSize14Text(
                                            AppColors.primaryColor),
                                      ),
                                    ],
                                  );
                                });
                            widget.getProfileDetails;
                            _formKey.currentState!.reset();
                            setState(() {
                              _editProfileDetails = Future.value(user);
                            });
                          } catch (error) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(somethingWentWrongString),
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
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
