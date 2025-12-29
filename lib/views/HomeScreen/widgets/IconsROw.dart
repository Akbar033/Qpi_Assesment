import 'package:flutter/material.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';

import 'package:qpi_eng/views/corrective%20maiantance/CorrectiveMaintance.dart';

class Iconsrow extends StatelessWidget {
  const Iconsrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blueAccent,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home_filled),
              color: Colors.blue,
              iconSize: 30,
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CorrectiveMaintanance(),
                  ),
                );
              },
              icon: Icon(Icons.settings),
              color: Colors.brown,
              iconSize: 30,
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesNames.barcodeGenerator);
              },
              icon: Icon(Icons.create_outlined),
              color: Colors.blue,
              iconSize: 30,
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesNames.scanBarCode);
              },
              icon: Icon(Icons.barcode_reader),
              color: Colors.blue,
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
