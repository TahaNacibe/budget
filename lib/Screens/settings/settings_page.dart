import 'package:budget/Screens/settings/edit_profile.dart';
import 'package:budget/dialogs/confirm_delete.dart';
import 'package:budget/dialogs/confirm_load_buckup.dart';
import 'package:budget/dialogs/fast_snack_bar.dart';
import 'package:budget/dialogs/loading_dialog.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/widgets/card_title_and_button.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:budget/widgets/setting_item.dart';
import 'package:budget/widgets/user_pfp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return Consumer<BudgetProvider>(builder: (context, budgetProvider, child) {
      return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          backgroundColor: scaffoldColor,
          title: const Text("Settings",
              style: TextStyle(
                fontFamily: "Quick",
                fontWeight: FontWeight.bold,
              )),
        ),
        body: ListView(
          children: [
            GestureDetector(
              onTap: () {
                showEditProfileSheet(context, budgetProvider.loadedUser.pfp,
                    budgetProvider.loadedUser.userName);
              },
              child: settingItem(
                  title: "Edit Profile",
                  hint:
                      "Change user Profile and display Name from this section",
                  trailing: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(.5)),
                    child: userPfp(
                        path: budgetProvider.loadedUser.pfp,
                        name: budgetProvider.loadedUser.userName,
                        radius: 25),
                  )),
            ),
            displaySection(budgetProvider: budgetProvider),
            dataSection(budgetProvider),
            supportSection(),
            detailsSection(),
          ],
        ),
      );
    });
  }

  Widget displaySection({required BudgetProvider budgetProvider}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleDivider("Display"),
        settingItem(
            title: "Change Theme",
            hint: "Change app Theme",
            trailing: Switch(
                activeTrackColor: Theme.of(context).iconTheme.color,
                activeColor: Theme.of(context).scaffoldBackgroundColor,
                value: budgetProvider.isDarkTheme,
                onChanged: (value) {
                  budgetProvider.toggleTheme();
                })),
      ],
    );
  }

  Widget dataSection(BudgetProvider budgetProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleDivider("Data and Transfer"),
        GestureDetector(
          onTap: () {
            showCustomProgressDialog(context);
            budgetProvider.createBuckUp(context).then((answer) {
              Navigator.pop(context);
              if (answer) {
                informationBar(context, "BuckUp Loading Complete");
              }
            });
          },
          child: settingItem(
            title: "BackUp your data",
            hint: "Create a a safe backUp file to transfer your data",
          ),
        ),
        GestureDetector(
          onTap: () async {
            bool? answer = await showConfirmLoad(context);
            if (answer != null && answer) {
              showCustomProgressDialog(context);
              budgetProvider.loadBuckUpFile(context).then((answer) {
                Navigator.pop(context);
                if (answer != null) {
                  if (answer) {
                    informationBar(context, "Applying BackUp Completed");
                  }
                }
              });
            }
          },
          child: settingItem(
            title: "Load Saved Data",
            hint: "The current data will be erased and replaced by the new one",
          ),
        ),
        GestureDetector(
          onTap: () async {
            bool? answer = await showDeleteConfirm(context, "All Data");
            showCustomProgressDialog(context);
            if (answer != null) {
              if (answer) {
                budgetProvider.clearAllData().then((result) {
                  if (result) {
                    informationBar(context, "All Data was Wiped");
                    // Exit the app
                    SystemNavigator.pop();
                  } else {
                    informationBar(context, "Something Went Wrong");
                  }
                });
              }
              Navigator.pop(context);
            }
          },
          child: settingItem(
            title: "Clear All data",
            hint: "Remove all saved data in the app",
          ),
        ),
      ],
    );
  }

  Widget detailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleDivider("Details and Information"),
        settingItem(
          title: "About the app",
        ),
        settingItem(
          title: "Version",
          hint: "1.0.0",
        ),
      ],
    );
  }

  Widget supportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleDivider("Support"),
        settingItem(
          title: "Send Feedback",
        ),
        settingItem(
          title: "Report a Problem",
        ),
        settingItem(
          title: "User agreement",
        ),
      ],
    );
  }

  Widget titleDivider(String title) {
    return Builder(builder: (context) {
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          dashedDivider(),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: cardTitle(title: title),
            ),
          ),
        ],
      );
    });
  }
}
