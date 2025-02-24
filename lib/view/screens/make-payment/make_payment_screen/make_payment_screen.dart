import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viserpay/core/utils/dimensions.dart';
import 'package:viserpay/core/utils/my_color.dart';
import 'package:viserpay/core/utils/my_strings.dart';
import 'package:viserpay/core/utils/user_inactivity.dart';
import 'package:viserpay/core/utils/util.dart';
import 'package:viserpay/data/controller/cash_out/cash_out_controller.dart';
import 'package:viserpay/data/repo/cashout/cashout_repo.dart';
import 'package:viserpay/data/services/api_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:viserpay/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay/view/components/global/history_icon_widget.dart';

import '../../../../core/route/route.dart';
 
class MakePaymentScreen extends StatefulWidget {
  const MakePaymentScreen({super.key});

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  final InActivityTimer timer = InActivityTimer();
String? storedValue;
 String? type;
 FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {

    final args = Get.arguments; 
   

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CashoutRepo(apiClient: Get.find()));
    final controller = Get.put(CashOutController(cashoutRepo: Get.find()));
    super.initState();
      type = MyUtils().generateTransactionId();
    

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          getIsicNum();

      controller.initialValue();
    });

     timer.startTimer(context);
   if (args != null && args.isNotEmpty) {
  type = args[0];
  String transactionId =  args[0] ?? ""; 

  if (transactionId.isNotEmpty) {
    listenToTransaction(transactionId).listen((transaction) {
      if (transaction.exists) {
        final data = transaction.data() as Map<String, dynamic>?;

        print("Transaction reçue: $data"); 

        if (data != null && data.containsKey('idTrans')) {
          if (data['idTrans'] == transactionId) {
            double amount = data['amount']?.toDouble() ?? 0.0; 


            MyUtils().showSuccessDialog(context,data['title'], data['msg'], amount);
          }
        }
      }
    }, onError: (error) {
      print("Erreur Firestore: $error"); 
    });
  }
}

  }

  Stream<DocumentSnapshot> listenToTransaction(String transactionId) {
  return firestore.collection('transactions').doc(transactionId).snapshots();
}

  void getIsicNum() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  
   setState(() {
      storedValue = sharedPreferences.getString('isic_num');
    });
}
@override
void dispose() {
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
            onNotification: (_) {
          timer.handleUserInteraction(context);
          return false;
        },
      child: WillPopScope(
     onWillPop: () async {
        setState(() {});

        return true;
  },
        child: GestureDetector(
           onTap: () => timer.handleUserInteraction(context),
           onPanUpdate: (_) => timer.handleUserInteraction(context),
          child: Scaffold(
            backgroundColor: MyColor.colorWhite,
            appBar: CustomAppBar(
              title: "Paiement",
              isTitleCenter: true,
              elevation: 0.03,
              action: [
                HistoryWidget(routeName: RouteHelper.cashOutHistoryScreen),
                const SizedBox(
                  width: Dimensions.space20,
                ),
              ],
            ),
            body: GetBuilder<CashOutController>(builder: (controller) {
              return controller.isLoading
                  ? const CustomLoader()
                  : StatefulBuilder(builder: (context, setState) {
                   
                      return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Scannez ce code QR pour effectuer le paiement',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 100),
                     storedValue != null
                                  ? QrImageView(
                                      data: "$storedValue - $type",
                                      version: 5,
                                      size: 300,
                                      foregroundColor: Colors.black,
                                      gapless: false,
                                      
                                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                                       embeddedImageStyle: QrEmbeddedImageStyle(
                                        size: Size(320, 320), // Ajouter une bordure blanche autour
                                           ),
                                      errorStateBuilder: (cxt, err) {
                                        return Container(
                                          child: const Center(
                                            child: Text(
                                              "Une erreur s'est produite lors du scannage",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : const CircularProgressIndicator(), 
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () { 
                        timer.startTimer(context);
                        Navigator.pop(context);
                      },
                      child: Text('Retour'),
                    ),
                  ],
                ),
              ),
            );
                    }
                    );
            }),
          ),
        ),
      ),
    );
  }
}
