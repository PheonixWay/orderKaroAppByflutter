import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/consts/list.dart';
import 'package:meat_deliviry_app/controler/auth_controller.dart';
import 'package:meat_deliviry_app/controler/profile_controller.dart';
import 'package:meat_deliviry_app/design_widget/bg_widget_2.dart';
import 'package:meat_deliviry_app/screens/Address_screen/address_screen.dart';
import 'package:meat_deliviry_app/screens/account_screen/component_of_account_screen.dart';
import 'package:meat_deliviry_app/screens/account_screen/edit_profile.dart';
import 'package:meat_deliviry_app/screens/account_screen/my_profile.dart';
import 'package:meat_deliviry_app/screens/auth_screen/login_screen.dart';

import 'package:meat_deliviry_app/screens/order_screen/order_screen.dart';
import 'package:meat_deliviry_app/services/firestore_services.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(ProfileController());

    return bgWidget2(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(FirestoreServices.getUserUid()),
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
                controller.profileData = data;

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
                              // controller.nameController.text = data['name'];
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
                            data['imageUrl'] == ''
                                ? Image.asset(
                                    imgProfile2,
                                    width: 100,
                                    height: 85,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(
                                    data["imageUrl"],
                                    width: 100,
                                    fit: BoxFit.cover,
                                    height: 85,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            8.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data["name"]}"
                                      .text
                                      .white
                                      .size(20)
                                      .fontFamily(bold)
                                      .make(),
                                  "${data["email"]}".text.white.make(),
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
                        FutureBuilder(
                            future: FirestoreServices.getCount(
                                FirestoreServices.getUserUid()),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(redColor),
                                  ),
                                );
                              } else {
                                var countData = snapshot.data;

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCard(
                                      count: countData[0].toString(),
                                      title: mycart,
                                      width: context.screenWidth / 2.5,
                                    ),
                                    detailsCard(
                                      count: countData[1].toString(),
                                      title: myorder,
                                      width: context.screenWidth / 2.5,
                                    ),
                                  ],
                                );
                              }
                            }),
                        27.heightBox,
                        // button for mesages,orders,wishlist
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
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          VxToast.show(context,
                                              msg: "My Profile");
                                          Get.to(const MyProfile());
                                          break;

                                        case 1:
                                          VxToast.show(context,
                                              msg: "Addresses");
                                          Get.to(() => const AddressDetails());

                                          break;

                                        case 2:
                                          VxToast.show(context,
                                              msg: "My Orders");
                                          Get.to(() => const OrderScreen());
                                          break;

                                        case 3:
                                          VxToast.show(context,
                                              msg: "Need Help!");
                                          break;

                                        default:
                                      }
                                    },
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
