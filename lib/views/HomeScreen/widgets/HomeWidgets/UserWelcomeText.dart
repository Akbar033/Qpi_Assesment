import 'package:flutter/material.dart';

class Userwelcometext extends StatelessWidget {
  const Userwelcometext({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // rich text
        RichText(
          text: TextSpan(
            text: 'Welc ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: '0',
                style: TextStyle(
                  color: const Color.fromARGB(255, 70, 99, 232),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' me',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: 'Note:-',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text:
                    '\n\nthis account is the user created\n which is created by admin so\nuser cane mske maintenance\n and then wait admin respose whether\n he reject or accept',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
