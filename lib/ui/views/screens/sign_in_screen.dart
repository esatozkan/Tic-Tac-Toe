import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/data/constants/constants.dart';
import 'package:tic_tac_toe/ui/providers/theme_provider.dart';
import 'package:tic_tac_toe/ui/views/screens/game_screen.dart';
import 'package:tic_tac_toe/ui/views/widgets/sign_in_screen_widgets/custom_text_field_widget.dart';
import 'package:tic_tac_toe/ui/views/widgets/snackbar_information.dart';
import '../../providers/text_field_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController player1Controller = TextEditingController();
  TextEditingController player2Controller = TextEditingController();
  FocusNode player1FocusNode = FocusNode();
  FocusNode player2FocusNode = FocusNode();

  @override
  void initState() {
    TextFieldProvider textFieldProvider =
        Provider.of<TextFieldProvider>(context, listen: false);
    textFieldProvider.resetFocus();
    player1FocusNode.addListener(() {
      textFieldProvider.setFocus(player1FocusNode.hasFocus);
    });
    player2FocusNode.addListener(() {
      textFieldProvider.setFocus(player2FocusNode.hasFocus);
    });
    player1Controller.clear();
    player2Controller.clear();
    super.initState();
  }

  @override
  void dispose() {
    player1FocusNode.dispose();
    player2FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SizedBox(
          height: height,
          width: width,
          child: SafeArea(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Switch(
                          value: themeProvider.getThemeData == darkMode,
                          onChanged: (value) {
                            setState(() {
                              themeProvider.toggleTheme();
                            });
                          })
                    ],
                  ),
                ),
                SizedBox(height: height / 8),
                const Text(
                  "Tic  Tac  Toe",
                  style: TextStyle(
                      fontSize: 60,
                      fontFamily: "playlistScript",
                      letterSpacing: 2),
                ),
                SizedBox(height: height / 10),
                CustomTextFieldWidget(
                  text: "Oyuncu 1",
                  textEditingController: player1Controller,
                  focusNode: player1FocusNode,
                ),
                CustomTextFieldWidget(
                  text: "Oyuncu 2",
                  textEditingController: player2Controller,
                  focusNode: player2FocusNode,
                ),
              ],
            ),
          )),
        ),
        floatingActionButton: Visibility(
          visible: !Provider.of<TextFieldProvider>(context, listen: false)
              .getIsTextFieldFocused,
          child: GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              if (player1Controller.text.isNotEmpty &&
                  player2Controller.text.isNotEmpty) {
                if (player1Controller.text != player2Controller.text) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameScreen(),
                    ),
                  );
                } else {
                  snackbarInformation(context, "Oyuncu adları aynı olamaz");
                }
              } else {
                snackbarInformation(
                    context, "Kullanıcı adları boş bırakılamaz");
              }
            },
            child: Container(
              height: height * 0.07,
              width: width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              child: Center(
                child: Text(
                  "Başla",
                  style: TextStyle(
                      fontFamily: "carterOne",
                      letterSpacing: 1,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
