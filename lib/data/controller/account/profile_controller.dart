import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/helper/shared_preference_helper.dart';
import 'package:viserpay/core/utils/my_strings.dart';
import 'package:viserpay/core/utils/url_container.dart';
import 'package:viserpay/data/model/global/user/user_model.dart';
import 'package:viserpay/data/model/profile/profile_response_model.dart';
import 'package:viserpay/data/model/user_post_model/user_post_model.dart';
import 'package:viserpay/data/repo/account/profile_repo.dart';
import 'package:viserpay/view/components/snack_bar/show_custom_snackbar.dart';

class ProfileController extends GetxController {
  ProfileRepo profileRepo;
  ProfileResponseModel model = ProfileResponseModel();

  ProfileController({required this.profileRepo});

  String imageUrl = '';

  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;

  loadProfileInfo() async {
    isLoading = true;
    update();
    model = await profileRepo.loadProfileInfo();
    if (model.data != null && model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      loadData(model);
    } else {
      isLoading = false;
      update();
    }
  }

  bool isSubmitLoading = false;
  updateProfile() async {
    isSubmitLoading = true;
    update();

    String firstName = firstNameController.text;
    String lastName = lastNameController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString();
    String zip = zipCodeController.text.toString();
    String state = stateController.text.toString();
    GlobalUser? user = model.data?.user;

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      isLoading = true;
      update();

      UserPostModel model = UserPostModel(firstname: firstName, lastName: lastName, mobile: user?.mobile ?? '',isic_num: user?.isic_num ?? '', email: user?.email ?? '', username: user?.username ?? '', countryCode: user?.countryCode ?? '', country: user?.country ?? '', mobileCode: '880', image: imageFile, address: address, state: state, zip: zip, city: city);

      bool b = await profileRepo.updateProfile(model, true);

      if (b) {
        await profileRepo.sendUserToken();
        await loadProfileInfo();
      }
    } else {
      if (firstName.isEmpty) {
        CustomSnackBar.error(errorList: [MyStrings.kFirstNameNullError.tr]);
      }
      if (lastName.isEmpty) {
        CustomSnackBar.error(errorList: [MyStrings.kLastNameNullError.tr]);
      }
    }

    isSubmitLoading = false;
    update();
  }

  bool user2faIsOne = false;

  void loadData(ProfileResponseModel? model) {
    firstNameController.text = model?.data?.user?.firstname ?? '';
    profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.username}');
    lastNameController.text = model?.data?.user?.lastname ?? '';
    emailController.text = model?.data?.user?.email ?? '';
    mobileNoController.text = model?.data?.user?.mobile ?? '';
    addressController.text = model?.data?.user?.address ?? '';
    stateController.text = model?.data?.user?.state ?? '';
    zipCodeController.text = model?.data?.user?.zip ?? '';
    cityController.text = model?.data?.user?.city ?? '';
    imageUrl = model?.data?.user?.image == null ? '' : '${model?.data?.user?.image}';
    user2faIsOne = model?.data?.user?.ts == '1' ? true : false;

    if (imageUrl.isNotEmpty && imageUrl != 'null') {
      imageUrl = '${UrlContainer.domainUrl}/assets/images/user/profile/$imageUrl';
    }

    isLoading = false;
    update();
  }
}
