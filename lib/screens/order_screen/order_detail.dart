import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;
import 'package:meat_deliviry_app/consts/consts.dart';
import 'package:meat_deliviry_app/screens/order_screen/widget.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;

  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: redColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: "My Orders".text.color(redColor).fontFamily(semibold).make(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //status section
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: "Status".text.size(16).fontFamily(bold).make()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      orderStatus(
                          title: "Placed",
                          colors: Colors.green,
                          icons: Icons.download_done,
                          showDone: true),
                      orderStatus(
                          title: "Confirmed",
                          colors: Colors.blue,
                          icons: Icons.thumb_up_alt_outlined,
                          showDone: true),
                      orderStatus(
                          title: "On Delivery",
                          colors: Colors.yellow,
                          icons: Icons.car_crash_rounded,
                          showDone: true),
                      orderStatus(
                          title: "Delivered",
                          colors: Colors.purple,
                          icons: Icons.water_damage_outlined,
                          showDone: true),
                    ],
                  )
                      .box
                      .margin(const EdgeInsets.all(10))
                      .roundedSM
                      .shadowXs
                      .white
                      .make(),

                  // Details section
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: "Detail".text.size(16).fontFamily(bold).make()),
                  Column(
                    children: [
                      orderPlaceDetails(
                          name1: "Order Code",
                          name2: "Shipping Method",
                          data1: data["order_code"],
                          data2: data["shipping_method"]),
                      orderPlaceDetails(
                          name1: "Order Date",
                          name2: "Payment Method",
                          data1: intl.DateFormat()
                              .add_yMd()
                              .format(data["order_date"].toDate()),
                          data2: data["payment_method"]),
                      orderPlaceDetails(
                        name1: "Payment Status",
                        name2: "Delivery Status",
                        data1: "Un Paid",
                        data2: "Placed",
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Shipping Address"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                  2.heightBox,
                                  "${data["order_by_address"]}"
                                      .text
                                      .overflow(TextOverflow.ellipsis)
                                      .make(),
                                  "Name: ${data["order_by_name"]}".text.make(),
                                  "Email: ${data["order_by_email"]}"
                                      .text
                                      .make(),
                                  "City: ${data["order_by_city"]}".text.make(),
                                  "State: ${data["order_by_state"]}"
                                      .text
                                      .make(),
                                  "Phone: ${data["order_by_phone"]}"
                                      .text
                                      .make(),
                                  "Postal Code: ${data["order_by_code"]}"
                                      .text
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.heightBox,
                    ],
                  )
                      .box
                      .margin(const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 10))
                      .roundedSM
                      .shadowXs
                      .white
                      .make(),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: "Product's".text.size(16).fontFamily(bold).make()),

                  //Products list section
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(data["orders"].length, (index) {
                      return ListTile(
                        minLeadingWidth: 10,
                        leading: "${index + 1}"
                            .text
                            .fontFamily(bold)
                            .size(16)
                            .make(),
                        title: data["orders"][index]["title"]
                            .toString()
                            .text
                            .fontFamily(semibold)
                            .make(),
                        subtitle: "${data["orders"][index]["qty"]}x"
                            .toString()
                            .text
                            .fontFamily(bold)
                            .make(),
                        trailing: "₹ ${data["orders"][index]["price"]}"
                            .toString()
                            .text
                            .fontFamily(bold)
                            .color(Vx.green500)
                            .make(),
                        onTap: () {},
                      )
                          .box
                          .roundedSM
                          .white
                          .shadowXs
                          .margin(const EdgeInsets.only(
                              top: 10, left: 10, right: 10))
                          .make();
                    }),
                  ),
                  10.heightBox,
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: "Totall".text.size(16).fontFamily(bold).make()),
                  Column(children: [
                    totalDetails(
                      name1: "Sub Totall",
                      data1: data["totall_amount"],
                    ),
                    totalDetails(
                      name1: "Delivery Charge",
                      data1: "40",
                    ),
                    const Divider(
                      height: 10,
                      indent: 16,
                      endIndent: 16,
                      thickness: 2,
                      color: Vx.black,
                    ),
                    totalDetails(
                      name1: "Grand Totall",
                      data1: data["totall_amount"] + 40,
                    ),
                    10.heightBox,
                  ])
                      .box
                      .margin(const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 10))
                      .roundedSM
                      .shadowXs
                      .white
                      .make(),
                ],
              )
            ],
          ),
        ));
  }
}
