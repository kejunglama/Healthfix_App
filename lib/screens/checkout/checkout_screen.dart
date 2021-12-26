import 'package:flutter/material.dart';
import 'package:healthfix/components/default_button.dart';
import 'package:healthfix/components/nothingtoshow_container.dart';
import 'package:healthfix/models/Address.dart';
import 'package:healthfix/screens/manage_addresses/manage_addresses_screen.dart';
import 'package:healthfix/services/data_streams/addresses_stream.dart';
import 'package:healthfix/services/database/user_database_helper.dart';
import 'package:healthfix/size_config.dart';
import 'package:logger/logger.dart';

import '../../constants.dart';
import 'components/order_items.dart';
import 'components/total_amounts.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  num cartTotal;
  num deliveryCharge;
  final AddressesStream addressesStream = AddressesStream();
  final TextEditingController phoneFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressesStream.init();
  }

  @override
  void dispose() {
    super.dispose();
    phoneFieldController.dispose();
    emailFieldController.dispose();
    addressesStream.dispose();
  }

  fetchAddress(String addressID) async {
    var _ad = await UserDatabaseHelper().getAddressFromId(addressID);
    address = _ad;
    phoneFieldController.text = address.phone;
    emailFieldController.text = "kejunglama@gmail.com";
  }

  Address address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: cusHeadingStyle(),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: addressesStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List addresses = snapshot.data;
              // fetchAddress(addresses[0]);

              return FutureBuilder(
                  future: (address == null) ? fetchAddress(addresses[0]) : null,
                  builder: (context, snapshot) {
                    return Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              buildAddressSection(context),
                              sizedBoxOfHeight(12),
                              buildIconWithTextField(Icons.phone, "Your Number", phoneFieldController),
                              sizedBoxOfHeight(12),
                              buildIconWithTextField(Icons.mail_outline_rounded, "Your Email", emailFieldController),
                              sizedBoxOfHeight(12),
                              Divider(thickness: 0.1, color: Colors.cyan),
                              sizedBoxOfHeight(12),
                              // Order Items
                              OrderItems(),

                              sizedBoxOfHeight(12),
                              Divider(thickness: 0.1, color: Colors.cyan),
                              sizedBoxOfHeight(12),

                              FutureBuilder(
                                  future: UserDatabaseHelper().cartTotal,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      cartTotal = snapshot.data;
                                      deliveryCharge = 100;
                                      // print(cartTotal.runtimeType);
                                      return TotalAmounts(cartTotal, deliveryCharge);
                                    }
                                    return CircularProgressIndicator();
                                  }),
                            ],
                          ),
                          DefaultButton(
                            text: "Proceed to Payment",
                            press: () {
                              if (address.phone != phoneFieldController.text) address.phone = phoneFieldController.text;
                              print(address);
                              print(emailFieldController.text);
                              print("");
                              final totals = {"cartTotal": cartTotal, "deliveryCharge": deliveryCharge, "netTotal": cartTotal + deliveryCharge};
                              print(totals);
                            },
                          ),
                          // buildHintText("District"),
                          // buildTextFormField("1234 Forest Road"),
                        ],
                      ),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              final error = snapshot.error;
              Logger().w(error.toString());
            }
            return Center(
              child: NothingToShowContainer(
                iconPath: "assets/icons/network_error.svg",
                primaryMessage: "Something went wrong",
                secondaryMessage: "Unable to connect to Database",
              ),
            );
          }),
    );
  }

  Row buildIconWithTextField(IconData iconData, String hintText, TextEditingController textController) {
    return Row(
      children: [
        Icon(iconData, color: kPrimaryColor),
        sizedBoxOfWidth(12),
        Expanded(
          child: Container(
            height: getProportionateScreenHeight(34),
            child: buildTextFormField(
              textController,
              hintText,
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddressSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.my_location_rounded,
              color: kPrimaryColor,
            ),
            sizedBoxOfWidth(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address != null ? address.receiver : "Kejung Lama"),
                Row(
                  children: [
                    Text((address != null ? address.addresLine1 : "Baluwatar") + ", "),
                    Text(address != null ? address.city : "Kathmandu"),
                  ],
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            Address _address =
                await Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAddressesScreen(isSelectAddressScreen: true)));
            setState(() {
              address = _address;
              phoneFieldController.text = address.phone;
            });
            // print(address.receiver);
          },
          child: Text("EDIT"),
        ),
      ],
    );
  }

  TextFormField buildTextFormField(TextEditingController textController, String hint) {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      controller: textController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan, width: 0.1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        contentPadding: EdgeInsets.all(10),
        hintText: hint,
        hintStyle: cusHeadingStyle(14, Colors.grey, null, FontWeight.w400),
        // labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
