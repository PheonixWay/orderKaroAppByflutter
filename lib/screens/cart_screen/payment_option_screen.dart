import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/consts/list.dart';
import 'package:meat_deliviry_app/controler/cart_controller.dart';
import 'package:meat_deliviry_app/screens/home_screen/home.dart';

import '../../design_widget/button_design.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
        bottomNavigationBar: Obx(
          () => controller.placingOrder.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyorder(
                        paymentMode.elementAt(controller.paymentIndex.value),
                        controller.tprice.value);

                    await controller.clearCart();
                    // ignore: use_build_context_synchronously
                    VxToast.show(context, msg: "Succefully placed Order");
                    Get.offAll(const Home());
                    // Get.to(() => const UpiPaymentScreen());
                    // Get.to(() => const PaymentOption());
                  },
                  data: "Continue",
                  textcolor: whiteColor,
                  color: redColor),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: darkFontGrey),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title:
              "Choose Payment Method".text.color(darkFontGrey).semiBold.make(),
        ),
        body: Column(
          children: List.generate(paymentMode.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.changePaymentIndex(index);
              },
              child: Obx(
                () => Container(
                  margin: const EdgeInsets.all(12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 3),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image.asset(
                          paymentModeimg.elementAt(index),
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.contain,
                          // we can use it for shaodw effect
                          // colorBlendMode:
                          //     controller.paymentIndex.value == index
                          //         ? BlendMode.darken
                          //         : BlendMode.color,
                          // color: controller.paymentIndex.value == index
                          //     ? Colors.black.withOpacity(0.2)
                          //     : Colors.transparent,
                        ),
                      ),
                      Obx(
                        () => controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 5,
                        child: paymentMode
                            .elementAt(index)
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .color(darkFontGrey)
                            .make(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
