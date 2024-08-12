import 'package:flutter/material.dart';
import 'package:dima_project_2023/src/logic/authentication/link_google.dart';
import 'package:dima_project_2023/src/widgets/text.dart';
import '../../assets/colors.dart';

const Color GOOGLE_BLUE = Color(0xFF4285F4);

class MyDynamicButton extends StatefulWidget {
  @override
  _MyDynamicButtonState createState() => _MyDynamicButtonState();
}

class _MyDynamicButtonState extends State<MyDynamicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async{
        setState(() {
          _isPressed = true;
        });
        if (isConnected()) {
         await unlinkGoogle();
        } else {
         await linkEmailGoogle();
        }
        // Call setState to rebuild the widget with the new state
        setState(() {
          _isPressed = false;
        });
      },
      style: TextButton.styleFrom(
        side: const BorderSide(color: GOOGLE_BLUE, width: 2), // Set border width and color
        backgroundColor: _isPressed ? GOOGLE_BLUE.withOpacity(0.5) : Colors.transparent, // Set the background color
        foregroundColor: _isPressed ? Colors.white : GOOGLE_BLUE, // Set the text color
        
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'lib/assets/images/icons8-google-48.png',
            width: 24, // Set the width of the icon
            height: 24, // Set the height of the icon
          ),
          SizedBox(width: 8), // Add some space between the icon and the text
          isConnected()
            ? Text('Unlink Google', style: MyTextStyle.get(size: 15, color: GOOGLE_BLUE))
            : Text('Link Google', style: MyTextStyle.get(size: 15, color: GOOGLE_BLUE)),
        ],
      ),
    );
  }
}