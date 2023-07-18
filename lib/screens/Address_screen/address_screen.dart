import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/controler/address_details_controller.dart';
import 'package:meat_deliviry_app/design_widget/button_design.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';
import '../../design_widget/custom_text_input.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    var controller = Get.put(AddressDetailsController());
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redColor),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            sleep(const Duration(milliseconds: 200));
            Navigator.of(context).pop();
          },
        ),
        title: "My Addresses".text.color(redColor).fontFamily(semibold).make(),
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
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Align(
                            alignment: Alignment.center,
                            child: ourButton(
                                onPress: () async {
                                  if (formkey.currentState!.validate()) {
                                    await controller.addAddress();
                                    // ignore: use_build_context_synchronously
                                    VxToast.show(context,
                                        msg: "Address Added Succesfully");
                                  } else {
                                    VxToast.show(context,
                                        msg: "Fill all details");
                                  }
                                },
                                color: redColor,
                                textcolor: whiteColor,
                                data: "Add Address"),
                          ),
                          10.heightBox,
                          "Added Addresses"
                              .text
                              .fontFamily(bold)
                              .size(16)
                              .make(),
                          10.heightBox,
                        ]),
                  ),
                ),
              );
            } else {
              var data = snapshot.data!.docs;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Align(
                          alignment: Alignment.center,
                          child: ourButton(
                              onPress: () async {
                                if (formkey.currentState!.validate()) {
                                  await controller.addAddress();
                                  // ignore: use_build_context_synchronously
                                  VxToast.show(context,
                                      msg: "Address Added Succesfully");
                                } else {
                                  VxToast.show(context,
                                      msg: "Fill all details");
                                }
                              },
                              color: redColor,
                              textcolor: whiteColor,
                              data: "Add Address"),
                        ),
                        10.heightBox,
                        "Added Addresses".text.fontFamily(bold).size(16).make(),
                        //added adress section
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(data.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 5, left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "${index + 1}"
                                          .text
                                          .fontFamily(bold)
                                          .make(),
                                      const Icon(
                                        Icons.delete,
                                        color: redColor,
                                      ).onTap(() {
                                        FirestoreServices.deleteAddress(
                                            data[index].id);
                                        VxToast.show(context, msg: "Deleted");
                                      }),
                                    ],
                                  ),
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
                                      data[index]["city"]
                                          .toString()
                                          .text
                                          .make(),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      "State: "
                                          .text
                                          .fontFamily(semibold)
                                          .make(),
                                      data[index]["state"]
                                          .toString()
                                          .text
                                          .make(),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      "Phone: "
                                          .text
                                          .fontFamily(semibold)
                                          .make(),
                                      data[index]["phone"]
                                          .toString()
                                          .text
                                          .make(),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      "Postal Code: "
                                          .text
                                          .fontFamily(semibold)
                                          .make(),
                                      data[index]["code"]
                                          .toString()
                                          .text
                                          .make(),
                                    ],
                                  ),
                                ],
                              )
                                  .box
                                  .roundedSM
                                  .white
                                  .shadowXs
                                  .padding(const EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5))
                                  .make(),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
