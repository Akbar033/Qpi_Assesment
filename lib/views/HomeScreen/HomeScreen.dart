import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/viewmodel/adminiDashoboard/AdminVm.dart';
import 'package:qpi_eng/views/HomeScreen/widgets/HomeWidgets/UserWelcomeText.dart';
import 'package:qpi_eng/views/admin%20dashboard/widgets/admin%20Drawer/drawer.dart';
import 'package:qpi_eng/views/admin%20dashboard/widgets/realisticCard.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Adminvm>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: AdminDrawer(
        drawerFunc: () {
          vm.logOut(context);
        },
      ),

      body: Center(
        child: SafeArea(
          child: Card(
            elevation: 10,
            color: Colors.white,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.9,
              width: MediaQuery.sizeOf(context).width * 0.9,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.1,
                    color: const Color.fromARGB(0, 230, 227, 227),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Userwelcometext(),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                  RealisticCard(
                    color: const Color.fromARGB(255, 148, 179, 204),
                    title: ' Preventive maintenance ',
                    onTap: () {
                      Navigator.pushNamed(context, RoutesNames.prevenMn);
                    },
                    icon: Icons.create,
                  ),
                  SizedBox(height: 20),
                  RealisticCard(
                    title: 'Preventive History',
                    onTap: () {
                      Navigator.pushNamed(context, RoutesNames.prevenMnHistory);
                    },
                    icon: Icons.history,
                    color: const Color.fromARGB(255, 235, 196, 229),
                  ),
                  SizedBox(height: 20),
                  RealisticCard(
                    title: 'Scan barcode',
                    onTap: () {},
                    icon: Icons.scanner,
                    color: const Color.fromARGB(255, 208, 177, 177),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
