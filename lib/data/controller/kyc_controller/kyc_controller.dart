import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/helper/date_converter.dart';
import 'package:viserpay/core/utils/my_strings.dart';
import 'package:viserpay/data/model/authorization/authorization_response_model.dart';
import 'package:viserpay/data/model/kyc/kyc_response_model.dart';
import 'package:viserpay/data/repo/kyc/kyc_repo.dart';
import 'package:viserpay/view/components/snack_bar/show_custom_snackbar.dart';

class KycController extends GetxController {
  KycRepo repo;
  KycController({required this.repo});
  File? imageFile;

  bool isLoading = true;
  List<FormModel> formList = [];
  String selectOne = MyStrings.selectOne;

  KycResponseModel model = KycResponseModel();
  bool isNoDataFound = false;
  bool isAlreadyVerified = false;
  bool isAlreadyPending = false;
  List<KycPendingData> pendingData = [];
  String path = "";

  beforeInitLoadKycData() async {
    path = "";
    setStatusTrue();
    try {
      model = await repo.getKycData();
      if (model.data != null && model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        path = model.data?.path ?? '';
        List<KycPendingData>? pList = model.data?.kycPendingData;
        if (pList != null && pList.isNotEmpty) {
          pendingData.addAll(pList);
        }

        List<FormModel>? tList = model.data?.form?.list;
        if (tList != null && tList.isNotEmpty) {
          formList.clear();
          for (var element in tList) {
            if (element.type == 'select') {
              bool? isEmpty = element.options?.isEmpty;
              bool empty = isEmpty ?? true;
              if (element.options != null && empty != true) {
                element.options?.insert(0, selectOne);
                element.selectedValue = element.options?.first;
                formList.add(element);
              }
            } else {
              formList.add(element);
            }
          }
        }

        isNoDataFound = false;
      } else {
        if (model.remark?.toLowerCase() == 'already_verified') {
          isAlreadyVerified = true;
        } else if (model.remark?.toLowerCase() == 'under_review') {
          path = model.data?.path ?? '';

          List<KycPendingData>? pList = model.data?.kycPendingData;
          if (pList != null && pList.isNotEmpty) {
            pendingData.clear();
            pendingData.addAll(pList);
          }
          isAlreadyPending = true;
        } else {
          isNoDataFound = true;
        }
      }
    } finally {
      setStatusFalse();
    }
    setStatusFalse();
  }

  setStatusTrue() {
    isLoading = true;
    update();
  }

  setStatusFalse() {
    isLoading = false;
    update();
  }

  bool submitLoading = false;
  submitKycData() async {
    List<String> list = hasError();

    if (list.isNotEmpty) {
      CustomSnackBar.error(errorList: list);
      return;
    }
    submitLoading = true;
    update();

    AuthorizationResponseModel response = await repo.submitKycData(formList);

    if (response.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      // isAlreadyPending = true;
      CustomSnackBar.success(successList: response.message?.success ?? [MyStrings.success.tr]);
      beforeInitLoadKycData();
    } else {
      CustomSnackBar.error(errorList: response.message?.error ?? [MyStrings.requestFail.tr]);
    }

    submitLoading = false;
    update();
  }

  List<String> hasError() {
    List<String> errorList = [];
    errorList.clear();
    for (var element in formList) {
      if (element.isRequired == 'required') {
        if (element.type == 'checkbox') {
          if (element.cbSelected == null || element.cbSelected!.isEmpty) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        } else if (element.type == 'file') {
          if (element.imageFile == null) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        } else {
          if (element.selectedValue == '' || element.selectedValue == selectOne) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }
      }
    }
    return errorList;
  }

// date time v2.00
  //NEW DATE TIME
  void changeSelectedDateTimeValue(int index, BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        formList[index].selectedValue = DateConverter.estimatedDateTime(selectedDateTime);
        formList[index].textEditingController?.text = DateConverter.estimatedDateTime(selectedDateTime);

        update();
      }
    }

    update();
  }

  void changeSelectedDateOnlyValue(int index, BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );

      formList[index].selectedValue = DateConverter.estimatedDate(selectedDateTime);
      formList[index].textEditingController?.text = DateConverter.estimatedDate(selectedDateTime);
      update();
    }

    update();
  }

  void changeSelectedTimeOnlyValue(int index, BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      formList[index].selectedValue = DateConverter.estimatedTime(selectedDateTime);
      formList[index].textEditingController?.text = DateConverter.estimatedTime(selectedDateTime);
      print(formList[index].textEditingController?.text);
      print(formList[index].selectedValue);
      update();
    }

    update();
  }

// end date time function
  void changeSelectedValue(value, int index) {
    formList[index].selectedValue = value;
    update();
  }

  void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
    formList[listIndex].selectedValue = formList[listIndex].options?[selectedIndex];
    update();
  }

  void changeSelectedCheckBoxValue(int listIndex, String value) {
    List<String> list = value.split('_');
    int index = int.parse(list[0]);
    bool status = list[1] == 'true' ? true : false;

    List<String>? selectedValue = formList[listIndex].cbSelected;

    if (selectedValue != null) {
      String? value = formList[listIndex].options?[index];
      if (status) {
        if (!selectedValue.contains(value)) {
          selectedValue.add(value!);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      } else {
        if (selectedValue.contains(value)) {
          selectedValue.removeWhere((element) => element == value);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      }
    } else {
      selectedValue = [];
      String? value = formList[listIndex].options?[index];
      if (status) {
        if (!selectedValue.contains(value)) {
          selectedValue.add(value!);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      } else {
        if (selectedValue.contains(value)) {
          selectedValue.removeWhere((element) => element == value);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      }
    }
  }

  void pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']);

    if (result == null) return;

    formList[index].imageFile = File(result.files.single.path!);
    String fileName = result.files.single.name;
    formList[index].selectedValue = fileName;
    update();
    return;
  }
}
