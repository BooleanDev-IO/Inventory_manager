import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_manager/repos/models/product.dart';
import 'package:inventory_manager/repos/repositories/category_table_source.dart';
import 'package:inventory_manager/repos/repositories/product_table_source%20copy.dart';
import 'package:inventory_manager/screens/home/views/profile_screen.dart';
import 'package:inventory_manager/screens/home/views/settings_screen.dart';
import 'package:inventory_manager/screens/home/views/transaction_screen.dart';
import 'package:inventory_manager/screens/home/widgets/add_partner.dart';
import 'package:inventory_manager/screens/home/widgets/add_product.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../config/contants.dart';
import '../../../repos/models/category.dart';
import '../widgets/add_catergory.dart';
import '../widgets/analytical_widget.dart';
import '../widgets/invoice_analytics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  RxBool dashboardMode = true.obs; // if True -> Analytics Mode  else -> Data Mode
  RxBool menuExpanded = false.obs;
  PageController controllerPage = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return Scaffold(
            body: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: menuExpanded.value ? 200 : 75,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.isCompleted) {
                                menuExpanded.value = false;
                                controller.reverse();
                              } else {
                                menuExpanded.value = true;
                                controller.forward();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: AnimatedIcon(
                                icon: AnimatedIcons.menu_close,
                                progress: animation,
                                size: 35.0,
                                semanticLabel: 'Show menu',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: CircleAvatar(
                                radius: menuExpanded.value ? 80 : 25,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: menuExpanded.value ? 77 : 23,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                controllerPage.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.home, size: 35),
                                    Visibility(
                                        child: const SizedBox(
                                          width: 8,
                                        ),
                                        visible: menuExpanded.value),
                                    Visibility(
                                        child: Expanded(
                                          child: Text(
                                            "Home",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        visible: menuExpanded.value)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                controllerPage.animateToPage(1, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.person, size: 35),
                                    Visibility(
                                        child: const SizedBox(
                                          width: 8,
                                        ),
                                        visible: menuExpanded.value),
                                    Visibility(
                                        child: Expanded(
                                          child: Text(
                                            "Profile",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        visible: menuExpanded.value)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                controllerPage.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.monetization_on, size: 35),
                                    Visibility(
                                        child: const SizedBox(
                                          width: 8,
                                        ),
                                        visible: menuExpanded.value),
                                    Visibility(
                                        child: Expanded(
                                          child: Text(
                                            "Transactions",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        visible: menuExpanded.value)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                if (AdaptiveTheme.of(context).mode.isDark) {
                                  AdaptiveTheme.of(context).setLight();
                                } else {
                                  AdaptiveTheme.of(context).setDark();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.brush, size: 35),
                                    Visibility(
                                        child: const SizedBox(
                                          width: 8,
                                        ),
                                        visible: menuExpanded.value),
                                    Visibility(
                                        child: Expanded(
                                          child: Text(
                                            "Theme",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        visible: menuExpanded.value)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                controllerPage.animateToPage(3, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.settings, size: 35),
                                    Visibility(
                                        child: const SizedBox(
                                          width: 8,
                                        ),
                                        visible: menuExpanded.value),
                                    Visibility(
                                        child: Expanded(
                                          child: Text(
                                            "Settings",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        visible: menuExpanded.value)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        padding: const EdgeInsets.all(36),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Wrap(children: [
                                    Obx(
                                      () => Badge(
                                        label: Text(dashboardMode.value ? "Analytic Mode" : "Data Mode"),
                                        child: IconButton(
                                          onPressed: () {
                                            dashboardMode.value = !dashboardMode.value;
                                          },
                                          icon: Icon(dashboardMode.value ? Icons.bar_chart : Icons.table_chart),
                                        ),
                                      ),
                                    )
                                  ]),
                                  PopupMenuButton(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(16)),
                                      child: Text(
                                        "Add +",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ),
                                    splashRadius: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        padding: EdgeInsets.all(12),
                                        onTap: () {
                                          Future.delayed(Duration(milliseconds: 300)).whenComplete(() => showDialog(
                                                context: context,
                                                builder: (context) => FractionallySizedBox(heightFactor: .23, widthFactor: .5, child: AddaCategory()),
                                              ).whenComplete(() => setState(() {})));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Add Category",
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        padding: EdgeInsets.all(12),
                                        onTap: () {
                                          Future.delayed(Duration(milliseconds: 300)).whenComplete(() => showDialog(
                                                context: context,
                                                builder: (context) => FractionallySizedBox(heightFactor: .65, widthFactor: .75, child: AddProduct()),
                                              ).whenComplete(() => setState(() {})));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Add Product",
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        padding: EdgeInsets.all(12),
                                        onTap: () {
                                          Future.delayed(Duration(milliseconds: 300)).whenComplete(() => showDialog(
                                                context: context,
                                                builder: (context) => FractionallySizedBox(heightFactor: .35, widthFactor: .5, child: AddPartner()),
                                              ).whenComplete(() => setState(() {})));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Add Partner",
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                height: 30,
                                width: 2,
                                color: Colors.white12,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(16),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("user@email.com"),
                                    Icon(Icons.keyboard_arrow_down),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          controller: controllerPage,
                          children: [
                            //DashBoard
                            Obx(
                              () => dashboardMode.value
                                  ? Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: AnalyticalWidget(screenType: sizingInformation.deviceScreenType),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: InvoiceAnalytics(
                                              products: allproducts,
                                              partners: allpartner,
                                            )),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                          padding: const EdgeInsets.all(36),
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
                                          child: Column(
                                            children: [
                                              Text("Category"),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width,
                                                    child: PaginatedDataTable(
                                                      rowsPerPage: 16,
                                                      columns: [DataColumn(label: Text("ID")), DataColumn(label: Text("Name"))],
                                                      source: CategoryTableRowSource(
                                                        count: allcategories!.length,
                                                        myData: allcategories!.map((e) => Category(categoryId: e.categoryId, categoryName: e.categoryName)).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                              padding: const EdgeInsets.all(36),
                                              decoration:
                                                  BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
                                              child: Column(
                                                children: [
                                                  Text("Products"),
                                                  Expanded(
                                                    child: SingleChildScrollView(
                                                      child: SizedBox(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: PaginatedDataTable(
                                                          rowsPerPage: 10,
                                                          dataRowMaxHeight: 100,
                                                          dataRowMinHeight: 60,
                                                          columns: {'product_id': "", 'category_id': "", 'product_name': "", 'quantity': "", 'price': "", 'description': "", 'product_partner': ""}
                                                              .keys
                                                              .map((e) => DataColumn(label: Text(e)))
                                                              .toList(),
                                                          source: ProductTableRowSource(
                                                            count: allproducts!.length,
                                                            myData: allproducts!
                                                                .map((e) => Product(
                                                                    productId: e.productId,
                                                                    categoryId: e.categoryId,
                                                                    productName: e.productName,
                                                                    description: e.description,
                                                                    price: e.price,
                                                                    quantity: e.quantity,
                                                                    productPartner: e.productPartner))
                                                                .toList(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                            ),
                            //Profile
                            ProfilePage(),
                            //Transactions
                            TransactionScreen(),
                            //Settings
                            SettingsScreen()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
