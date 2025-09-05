import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rain_round/components/kcustom_button.dart';

import '../../../const/colors.dart';


class SongChangeBottomSheet extends StatefulWidget {
  const SongChangeBottomSheet({
    super.key
  });

  @override
  State<SongChangeBottomSheet> createState() => _SongChangeBottomSheetState();
}

class _SongChangeBottomSheetState extends State<SongChangeBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height/1.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 13.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                buildTitleSection("Select Address"),
                GestureDetector(
                  onTap: () {
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color:
                        kPrimaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      buildTitleSection("Add Address"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return  Container(
                    margin: const EdgeInsets.only(bottom: 13),

                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: ListTile(
                            title: Text(
                                'Address: '),
                            subtitle: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text('Contact No: '),
                                Text('Name: '),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: () {
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Icon(Icons.edit),
                            ),
                          ),
                        ),
                        /*Positioned(
                          right: 8,
                          bottom: 8,
                          child: Checkbox(
                            activeColor: kPrimaryColor,
                            value: isSelected,
                            onChanged: (value) {
                              searchSalonController.userAddressId.value = userAddressList[index].addressId;
                              log("Selected Address Id: ${searchSalonController.userAddressId.value}");
                            },
                          ),
                        ),*/
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: KCustomButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonText: "Cancel",
                        isOutline: true,
                        verticalPadding: 9,
                        textStyle: const TextStyle(
                            fontSize: 14, color: Colors.black),
                      ),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: KCustomButton(
                          onTap: () async {
                          },
                          buttonText: "Apply",
                          textStyle: const TextStyle(
                              fontSize: 14, color: Colors.white),
                          // buttonColor: const Color(0xff108045),
                          gradient: kPrimaryGradient),
                    )),
              ],
            ),
          ],
        ),
      )
    );
  }
}
Widget buildTitleSection(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  );
}

/*
Future showAddressBottomSheet({required BuildContext context,required SearchSalonController searchSalonController})async{

  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (s) {
      searchSalonController.userAddressId.value = 0;
      return FutureBuilder<List<UserAddressModel>>(
          future: UserAddressApi.getUserAddress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: KCustomCircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData  && snapshot.data!.isNotEmpty) {
              log("User address ${snapshot.data}");
              List<UserAddressModel>userAddressList = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 13.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        buildTitleSection("Select Address"),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.addressSelectionView,
                            arguments: {
                              'fromSearchSalonPage':true,
                            });
                *//*            Navigator.pushNamed(
                                context,
                                Routes.userAddressViewRoute,
                                arguments: {
                                  'fromCheckOutPage': false,
                                  'fromMyAccountPage': false,
                                  'fromDashboardPage': false,
                                  'fromSearchSalonPage':true
                                });*//*
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add_circle,
                                color:
                                kPrimaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              buildTitleSection("Add Address"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: userAddressList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            log("User Address Id: ${searchSalonController.userAddressId.value}");
                            log("Address Id: ${userAddressList[index].addressId}");
                            bool isSelected = searchSalonController.userAddressId.value == userAddressList[index].addressId;
                            /// If no address has been explicitly selected, use the default one
                            if (searchSalonController.userAddressId.value == 0 && userAddressList[index].isDefault == 1) {
                              isSelected = true;
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                searchSalonController.userAddressId.value= userAddressList[index].addressId;
                           *//*     SelectedAddressModel selectedAddressModel = SelectedAddressModel(
                                    streetAddress:"${userAddressList[index].area} ${userAddressList[index].state} ${userAddressList[index].country} ${userAddressList[index].pincode}",
                                    state: userAddressList[index].state.toString(),
                                    city: userAddressList[index].city.toString(),
                                    pincode: userAddressList[index].pincode.toString(),
                                    position: LatLng(double.parse(userAddressList[index].latitude), double.parse(userAddressList[index].longitude)));
                                addressController.updateSelectedAddress(address: selectedAddressModel);*//*
                              });
                            }
                            log("IsSelected: ${isSelected.toString()}");

                            return Container(
                              margin: const EdgeInsets.only(bottom: 13),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Stack(
                                children: [
                                  ListTile(
                                    title: Text(
                                        'Address: ${userAddressList[index].area} ${userAddressList[index].state} ${userAddressList[index].country} ${userAddressList[index].pincode}'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('Contact No: ${userAddressList[index].contactMobile}'),
                                        Text('Name: ${userAddressList[index].contactPerson}'),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.userAddressViewRoute,
                                            arguments: {
                                              "fromCheckOutPage": false,
                                              'fromMyAccountPage': false,
                                              "fromDashboardPage": false,
                                              "fromSearchSalonPage": true,
                                              'userMobileNumber': userAddressList[index].contactMobile,
                                              "isShowLeadingIcon": true,
                                              "userAddressModel": userAddressList[index]
                                            });
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.edit,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    bottom: 8,
                                    child: Checkbox(
                                      activeColor: kPrimaryColor,
                                      value: isSelected,
                                      onChanged: (value) {
                                        searchSalonController.userAddressId.value = userAddressList[index].addressId;
                                        log("Selected Address Id: ${searchSalonController.userAddressId.value}");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );

                              *//*Container(
                              margin: const EdgeInsets.only(bottom: 13),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                title: Text(
                                  'Address: ${userAddressList[index].area} ${userAddressList[index].city}  ${userAddressList[index].state} ${userAddressList[index].country}',
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Contact No: ${userAddressList[index].contactMobile}'),
                                    Text('Name: ${userAddressList[index].contactPerson}'),
                                  ],
                                ),
                                trailing: Checkbox(
                                  activeColor: kPrimaryColor,
                                  value: isSelected,
                                  onChanged: (value) {
                                    searchSalonController.userAddressId.value = userAddressList[index].addressId;
                                    log("Selected Address Id: ${searchSalonController.userAddressId.value}");
                                  },
                                ),
                              ),
                            );*//*

                          });
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: KCustomButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                buttonText: "Cancel",
                                isOutline: true,
                                verticalPadding: 9,
                                textStyle: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: KCustomButton(
                                  onTap: () async {
                                    CustomPopups.showCustomLoadingPopup(
                                        context: context);
                                    var response =
                                    await UserAddressApi.updateUserAddress(
                                        data: {
                                          "id": searchSalonController
                                              .userAddressId.value,
                                          "isDefault": 1
                                        });
                                    Navigator.pop(context);
                                    log("Response $response");
                                    if (response) {
                                      Navigator.pop(context);
                                      UserAddressModel selectedAddress = userAddressList.firstWhere((element) => element.addressId == searchSalonController.userAddressId.value);
                                      searchSalonController.selectedAddress.value = "${selectedAddress.area} ${selectedAddress.city} ${selectedAddress.state} ${selectedAddress.country} ${selectedAddress.pincode}";
                                    }
                                  },
                                  buttonText: "Apply",
                                  textStyle: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                  buttonColor: const Color(0xff108045),
                                  gradient: kPrimaryGradient),
                            )),
                      ],
                    ),
                  ],
                ),
              );
            } else if( snapshot.data!.isEmpty){
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No Address Added yet. To add address tap below!!!",textAlign: TextAlign.center,),
                      const SizedBox(height: 20,),
                      KCustomButton(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.addressSelectionView,
                          arguments: {
                            'fromSearchSalonPage':true,
                          });
              *//*            Navigator.pushNamed(
                              context, Routes.userAddressViewRoute,
                              arguments: {
                                'fromCheckOutPage': false,
                                'fromMyAccountPage':false,
                                'fromSearchSalonPage':true,
                                'fromDashboardPage': false,
                              });*//*
                        },
                        buttonText: "Add Address",
                        iconChild: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }
            else {
              return const Center(
                  child: Text("No Address Found"));
            }
          });
    },
  );
}*/
