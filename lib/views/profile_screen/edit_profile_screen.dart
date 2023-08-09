import 'dart:convert' show jsonDecode;
import 'package:get/get.dart';
import 'package:impulse/consts/consts.dart';
import 'package:impulse/controllers/user_controller/user_controller.dart';
import 'package:impulse/models/user.dart';
import 'package:impulse/services/auth_service.dart';
import 'package:impulse/widget_common/bg_widget.dart';
import 'package:impulse/widget_common/custom_button.dart';
import 'package:impulse/widget_common/custom_textfield.dart';
import 'package:impulse/widget_common/dialog_boxs.dart';
import 'package:impulse/widget_common/loading/loading_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _userController = Get.find<UserController>();
  final _authService = AuthService();
  final loader = LoadingScreen.instance();
  late User _currUser;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _currUser = _userController.currentUser!;
    _nameController.text = _currUser.name;
    _emailController.text = _currUser.email;
    _numberController.text = "+92xxxxxxxxxx";
    _addressController.text = _currUser.address;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void showError({required String message, required String title}) =>
      errorDialogue(
        context: context,
        message: message,
        title: title,
      );

  void saveProfile() async {
    if (_formKey.currentState!.validate()) {
      loader.show(
        context: context,
        text: "Please wait...",
        title: "Saving Changes",
      );
      _currUser = _currUser.copyWith(
        name: _nameController.text,
        address: _addressController.text,
      );
      final response = await _authService.updateUser(user: _currUser);
      unFocus();
      loader.hide();
      if (response['status'] == 200) {
        final data = jsonDecode(response['body']);
        await _userController.setUser(data);
        setState(() => isEditing = false);
        return;
      }
      showError(
        message: jsonDecode(response['body'])['msg'] ??
            jsonDecode(response['body'])['error'] ??
            "An Error Occured",
        title: "Error",
      );
    }
  }

  void handleChange(String value1, String value2) {
    if (value1.trim() != value2.trim() && !isEditing) {
      setState(() => isEditing = true);
    }
    if (value1.trim() == value2.trim() && isEditing) {
      setState(() => isEditing = false);
    }
  }

  void unFocus() {
    if (!FocusScope.of(context).hasPrimaryFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white, fontFamily: semibold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const Icon(Icons.person, size: 70)
                      .box
                      .color(mehroonColor)
                      .roundedFull
                      .size(120, 120)
                      .clip(Clip.antiAlias)
                      .make(),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: const Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: whiteColor,
                    ).box.outerShadowSm.make(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          yourDetails,
                          style: TextStyle(
                            color: mehroonColor,
                            fontFamily: bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(editDescription),
                      ],
                    ),
                    const SizedBox(height: 10),
                    customTextField(
                      hintText: "Name",
                      hint: "Name",
                      onChange: (value) => handleChange(value, _currUser.name),
                      controller: _nameController,
                    ),
                    const SizedBox(height: 10),
                    customTextField(
                      hintText: "Contact",
                      hint: "Contact",
                      controller: _numberController,
                    ),
                    const SizedBox(height: 10),
                    customTextField(
                      hintText: "Email",
                      hint: "Email",
                      enabled: false,
                      controller: _emailController,
                    ),
                    const Text(
                      "Email address cannot be changed",
                      style: TextStyle(color: darkFontGrey, fontSize: 11),
                    ),
                    const SizedBox(height: 10),
                    customTextField(
                      hintText: "Address",
                      hint: "Address",
                      controller: _addressController,
                      onChange: (value) =>
                          handleChange(value, _currUser.address),
                    ),
                    const SizedBox(height: 10),
                    customButton(
                      onPress: isEditing ? saveProfile : () => null,
                      title: "Save",
                      textColor: isEditing ? whiteColor : lightGrey,
                      btnColor: isEditing ? mehroonColor : lightGolden,
                    ),
                  ],
                ),
              ),
            ],
          )
              .box
              .rounded
              .p24
              .margin(EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: context.screenHeight * 0.06))
              .shadowSm
              .white
              .make(),
        ),
      ).onTap(unFocus),
    );
  }
}
