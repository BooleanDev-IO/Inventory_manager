import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_manager/config/contants.dart';
import '../../../repos/models/category.dart';
import '../../../repos/models/product.dart';

class AddPartner extends StatefulWidget {
  AddPartner({
    super.key,
  });

  @override
  State<AddPartner> createState() => _AddPartnerState();
}

class _AddPartnerState extends State<AddPartner> {
  TextEditingController name = TextEditingController(), email = TextEditingController(), phoneno = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
              clipBehavior: Clip.none,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("Add a partner"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Partner Name", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                        TextFormField(
                          controller: name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Enter partner name here",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Partner Phone Number", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                        TextFormField(
                          controller: phoneno,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Enter partner phone number here",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: BottomNavigationBar(
                currentIndex: 1,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.close),
                    label: "Cancel",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: "Add",
                  ),
                ],
                onTap: (value) {
                  switch (value) {
                    case 0:
                      Navigator.pop(context);
                      break;
                    case 1:
                      int length = allpartner!.length;

                      allpartner!.add(ProductPartner(partnerId: ++length, partnerName: name.text, partnerPhoneNumber: phoneno.text));
                      setState(() {});
                      Navigator.pop(context);
                      break;

                    default:
                      break;
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
