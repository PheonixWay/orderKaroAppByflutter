import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/screens/order_screen/order_detail.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: "My Orders".text.color(redColor).fontFamily(semibold).make(),
      ),
      backgroundColor: lightGrey,
      body: StreamBuilder(
          stream: FirestoreServices.getOrders(FirestoreServices.getUserUid()),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No order's Yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    minLeadingWidth: 10,
                    leading:
                        "${index + 1}".text.fontFamily(bold).size(16).make(),
                    title: data[index]["order_code"]
                        .toString()
                        .text
                        .fontFamily(semibold)
                        .make(),
                    subtitle: data[index]["totall_amount"]
                        .toString()
                        .numCurrency
                        .text
                        .fontFamily(bold)
                        .color(Vx.green500)
                        .make(),
                    trailing: IconButton(
                      onPressed: () {
                        Get.to(() => OrderDetails(
                              data: data.elementAt(index),
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: redColor,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => OrderDetails(
                            data: data.elementAt(index),
                          ));
                    },
                  )
                      .box
                      .roundedSM
                      .color(whiteColor)
                      .shadowSm
                      .margin(
                          const EdgeInsets.only(top: 10, left: 15, right: 15))
                      .make();
                },
                itemCount: data.length,
              );
            }
          }),
    );
  }
}
