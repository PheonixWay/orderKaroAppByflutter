import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/consts/list.dart';
import 'package:meat_deliviry_app/controler/auth_controller.dart';
import 'package:meat_deliviry_app/controler/profile_controller.dart';

import 'package:meat_deliviry_app/design_widget/bg_widget_2.dart';
import 'package:meat_deliviry_app/screens/account_screen/component_of_account_screen.dart';
import 'package:meat_deliviry_app/screens/account_screen/edit_profile.dart';
import 'package:meat_deliviry_app/screens/auth_screen/login_screen.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget2(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        //edit button
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Get.to(() => EditProfile(
                                    data: data,
                                  ));
                            },
                            child: const Icon(
                              Icons.edit,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        //profile image name and email and logout button
                        Row(
                          children: [
                            Image.asset(
                              imgProfile2,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                            8.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .white
                                      .size(20)
                                      .fontFamily(bold)
                                      .make(),
                                  "${data['email']}".text.white.make(),
                                ],
                              ),
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor)),
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signoutMethod(context: context);
                                  Get.offAll(() => const MyLogin());
                                },
                                child: logout.text.white
                                    .fontFamily(semibold)
                                    .make())
                          ],
                        ),
                        15.heightBox,
                        //my count details of cart,wishlist,orders
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                              count: "${data['cart_count']}",
                              title: mycart,
                              width: context.screenWidth / 3.4,
                            ),
                            detailsCard(
                              count: "${data['wishlist_count']}",
                              title: wishlist,
                              width: context.screenWidth / 3.4,
                            ),
                            detailsCard(
                              count: "${data['order_count']}",
                              title: myorder,
                              width: context.screenWidth / 3.4,
                            ),
                          ],
                        ),
                        27.heightBox,
                        //button for mesages,orders,wishlist
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Material(
                            color: whiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      leading: Image.asset(
                                        profilebuttonicon.elementAt(index),
                                        width: 22,
                                      ),
                                      title: profilebuttonlist
                                          .elementAt(index)
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: Colors.grey,
                                  );
                                },
                                itemCount: profilebuttonlist.length),
                          ).box.shadow.make(),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
