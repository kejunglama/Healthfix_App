import 'package:healthfix/components/default_button.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/models/Address.dart';
import 'package:healthfix/services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:healthfix/size_config.dart';
import 'package:logger/logger.dart';

class AddressBox extends StatelessWidget {
  bool isSelectAddressScreen;
  AddressBox({
    Key key,
    @required this.addressId, this.isSelectAddressScreen,
  }) : super(key: key);

  final String addressId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: FutureBuilder<Address>(
                  future: UserDatabaseHelper().getAddressFromId(addressId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final address = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${address.title}",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${address.receiver}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${address.addresLine1}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          // Text(
                          //   "${address.addressLine2}",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //   ),
                          // ),
                          Text(
                            "City: ${address.city}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          // Text(
                          //   "District: ${address.district}",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //   ),
                          // ),
                          // Text(
                          //   "State: ${address.state}",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //   ),
                          // ),
                          Text(
                            "Landmark: ${address.landmark}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          // Text(
                          //   "PIN: ${address.pincode}",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //   ),
                          // ),
                          Text(
                            "Phone: ${address.phone}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          sizedBoxOfHeight(20),
                          Visibility(
                            visible: isSelectAddressScreen ?? false,
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.pop(context,address);
                                // print(address.runtimeType);
                              },
                              child: Text(
                                "Select Address",
                                style: cusHeadingLinkStyle,
                              ),
                            ),
                          ),
                          // DefaultButton(text: ,color: kPrimaryColor, press: (){},),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      final error = snapshot.error.toString();
                      Logger().e(error);
                    }
                    return Center(
                      child: Icon(
                        Icons.error,
                        color: kTextColor,
                        size: 60,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
