import 'package:budget/providers/data_provider.dart';
import 'package:budget/providers/image_provider.dart';
import 'package:budget/widgets/costume_button.dart';
import 'package:budget/widgets/costume_text_filed.dart';
import 'package:budget/widgets/user_pfp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final String pfpUrl;
  final String userName;
  const EditProfile({required this.pfpUrl, required this.userName, super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //* controllers
  final TextEditingController _userNameController = TextEditingController();
  //* vars
  bool isEditing = false;
  String pfpUrlString = "";

  //* functions
  bool isChangeAccrues({required String userName, required String currentPfp}) {
    return _userNameController.text != userName || pfpUrlString != currentPfp;
  }

  //* instances
  final ImageProviderService _imageProviderService = ImageProviderService();
  @override
  void initState() {
    pfpUrlString = widget.pfpUrl;
    _userNameController.text = widget.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(builder: (context, budgetProvider, child) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    String? pfpPath =
                        await _imageProviderService.pickAndSaveImage(context);
                    if (pfpPath != null) {
                      setState(() {
                        pfpUrlString = pfpPath;
                      });
                    }
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      userPfp(
                          path: pfpUrlString,
                          name: budgetProvider.loadedUser.userName,
                          radius: 60),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(.5)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //* user name
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Column(
                    children: [
                      costumeTextFiled(
                          controller: _userNameController,
                          hint: "",
                          maxLength: 15,
                          isReadOnly: !isEditing,
                          isOnlyNumbers: false,
                          isAdd: null,
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = !isEditing;
                                });
                              },
                              icon: Icon(
                                  isEditing ? Icons.done : Icons.edit_rounded)),
                          onChangeAccrue: (value) {
                            setState(() {
                              _userNameController.text = value;
                            });
                          }),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Without saving all the changes will be discard, the name should stay under the 15 characters long, so please consider that while choosing",
                            style: TextStyle(
                                fontFamily: "Quick",
                                fontWeight: FontWeight.w300,
                                fontSize: 14)),
                      )
                    ],
                  ),
                ),
                //* buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      costumeButton(
                          title: "Cancel",
                          isActive: true,
                          color: Colors.grey.withOpacity(.5)),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            budgetProvider.userProfileEdit(
                                newUserName: _userNameController.text,
                                newPfp: pfpUrlString);
                            Navigator.pop(context);
                          },
                          child: costumeButton(
                              title: "Save Changes",
                              isActive: isChangeAccrues(
                                  userName: budgetProvider.loadedUser.userName,
                                  currentPfp: budgetProvider.loadedUser.pfp),
                              color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

void showEditProfileSheet(
    BuildContext context, String pfpUrl, String userName) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: EditProfile(
                userName: userName,
                pfpUrl: pfpUrl,
              )),
        );
      });
}
