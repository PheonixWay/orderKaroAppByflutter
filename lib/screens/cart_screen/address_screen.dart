import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:meat_deliviry_app/consts/consts.dart";
import "package:meat_deliviry_app/controler/cart_controller.dart";
import "package:meat_deliviry_app/design_widget/button_design.dart";
import "package:meat_deliviry_app/design_widget/custom_text_input.dart";
import "package:meat_deliviry_app/screens/cart_screen/payment_option_screen.dart";

import "package:meat_deliviry_app/services/firestore_services.dart";
// import "package:meat_deliviry_app/screens/cart_screen/payment_screen.dart";

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    var controller = Get.find<CartController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkFontGrey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: "Address Info".text.color(darkFontGrey).fontFamily(bold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAddress(FirestoreServices.getUserUid()),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: redColor,
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      customTextField(
                          title: "Address",
                          hint: "Address",
                          ispass: false,
                          controller: controller.adresscontroller),
                      customTextField(
                          title: "city",
                          hint: "City",
                          ispass: false,
                          controller: controller.citycontroller),
                      customTextField(
                          title: "State",
                          hint: "state",
                          ispass: false,
                          controller: controller.statecontroller),
                      customTextField(
                          title: "Code",
                          hint: "postal code",
                          ispass: false,
                          controller: controller.codecontroller),
                      customTextField(
                          title: "Phone",
                          hint: "phone",
                          ispass: false,
                          controller: controller.phonecontroller),
                      10.heightBox,
                      ourButton(
                          onPress: () {
                            if (formkey.currentState!.validate()) {
                              controller.addAddress();
                            } else {
                              VxToast.show(context, msg: "Fill all details");
                            }
                          },
                          data: "Save",
                          color: redColor,
                          textcolor: whiteColor),
                    ],
                  ),
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              return Column(children: [
                ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(data.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedAddress(index);
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.all(12),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: controller.selectedAddress.value == index
                                    ? redColor
                                    : Colors.transparent,
                                width: 3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${index + 1}".text.fontFamily(bold).make(),
                              5.heightBox,
                              data[index]["Address"]
                                  .toString()
                                  .text
                                  .size(16)
                                  .bold
                                  .overflow(TextOverflow.ellipsis)
                                  .make(),
                              Row(
                                children: [
                                  "City: ".text.fontFamily(semibold).make(),
                                  data[index]["city"].toString().text.make(),
                                ],
                              ),
                              Row(
                                children: [
                                  "State: ".text.fontFamily(semibold).make(),
                                  data[index]["state"].toString().text.make(),
                                ],
                              ),
                              Row(
                                children: [
                                  "Phone: ".text.fontFamily(semibold).make(),
                                  data[index]["phone"].toString().text.make(),
                                ],
                              ),
                              Row(
                                children: [
                                  "Postal Code: "
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                  data[index]["code"].toString().text.make(),
                                ],
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(10)).make(),
                        ),
                      ),
                    );
                  }),
                ),
                const Spacer(),
                ourButton(
                        onPress: () {
                          controller.addressData(
                              data[controller.selectedAddress.value]);
                          Get.to(() => const PaymentOption());
                        },
                        data: "Continue",
                        textcolor: whiteColor,
                        color: redColor)
                    .box
                    .width(controller.getScreenWidth(context))
                    .height(40)
                    .make(),
                2.heightBox,
              ]);
            }
          }),
    );
  }
}
