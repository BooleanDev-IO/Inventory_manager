import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../config/contants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  RxBool appLockEnabled = false.obs;
  RxString accountSettings = "Public".obs;
  RxBool accountSettingsBool = false.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: Obx(
            () => Theme(
              data: AdaptiveTheme.of(context).theme,
              child: SettingsList(
                lightTheme: SettingsThemeData(
                  dividerColor: Colors.grey,
                  settingsListBackground: Colors.deepPurple.shade100,
                  settingsSectionBackground: Colors.white,
                ),
                darkTheme: SettingsThemeData(
                  dividerColor: Colors.white,
                  settingsListBackground: AdaptiveTheme.of(context).darkTheme.primaryColorDark,
                  settingsSectionBackground: AdaptiveTheme.of(context).darkTheme.primaryColor,
                ),
                sections: [
                  SettingsSection(
                    title: Text('Common'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(leading: Icon(Icons.text_fields), title: Text('Language'), value: Text('English'), trailing: Text("English")),
                    ],
                  ),
                  SettingsSection(
                    title: Text('Security'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: Icon(Icons.language),
                        onPressed: (context) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (accountSettings.value == "Private") {
                                        accountSettings.value = "Public";
                                        accountSettingsBool.value = false;
                                      } else {
                                        accountSettings.value = "Private";
                                        accountSettingsBool.value = true;
                                      }
                                    },
                                    child: Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                                title: Text("Are you sure?"),
                                content: Obx(() => Text("Do you want your account to be ${accountSettingsBool.value ? "Public" : "Private"}?")),
                              );
                            },
                          );
                        },
                        title: Text('Account Settings'),
                        value: Text(accountSettings.value),
                      ),
                      SettingsTile.switchTile(
                        onToggle: (value) {
                          appLockEnabled.value = value;

                          if (value) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Confirm"),
                                  ),
                                ],
                                title: Text("Set a pin"),
                                content: TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  maxLength: 4,
                                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      hintText: "Enter a 4 digit PIN"),
                                ),
                              ),
                            );
                          }
                        },
                        initialValue: appLockEnabled.value,
                        leading: Icon(Icons.screen_lock_portrait_rounded),
                        title: Text('App Lock'),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: Text("Help & Information"),
                    tiles: [
                      SettingsTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: LottieBuilder.asset(
                            "assets/lottiefiles/logo.json",
                            height: 100,
                            width: 100,
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "InventoHub",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text("v.1.0.0 (1)")
                          ],
                        ),
                      ),
                      SettingsTile.navigation(
                        leading: Icon(Icons.help),
                        onPressed: (context) {
                          showAboutDialog(
                              applicationLegalese: "InventoHub, 2023 © All Rights Reserved.",
                              context: context,
                              applicationIcon: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: LottieBuilder.asset(
                                  "assets/lottiefiles/logo.json",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              applicationName: "InventoHub",
                              applicationVersion: "v.1.0.0 (1)",
                              children: [
                                Divider(),
                                ListTile(
                                  title: Text("Email Us"),
                                  subtitle: Text("InventoHub@email.com"),
                                )
                              ]);
                        },
                        title: Text('Help'),
                      ),
                      SettingsTile.navigation(
                        leading: Icon(Icons.info),
                        onPressed: (context) {
                          showAboutDialog(
                              applicationLegalese: "InventoHub, 2023 © All Rights Reserved.",
                              context: context,
                              applicationIcon: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: LottieBuilder.asset(
                                  "assets/lottiefiles/logo.json",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              applicationName: "InventoHub",
                              applicationVersion: "v.1.0.0 (1)",
                              children: [
                                Divider(),
                                Text(
                                  stringLorem,
                                  textAlign: TextAlign.justify,
                                )
                              ]);
                        },
                        title: Text('About Us'),
                      ),
                    ],
                  ),
                ],
                applicationType: ApplicationType.cupertino,
              ),
            ),
          ),
        ));
  }
}
