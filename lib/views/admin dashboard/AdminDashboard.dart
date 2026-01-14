import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/viewmodel/adminiDashoboard/AdminVm.dart';

import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/views/Pending%20Maintenance/PenMaintenance.dart';
import 'package:qpi_eng/views/admin%20dashboard/widgets/admin%20Drawer/drawer.dart';
import 'package:qpi_eng/views/admin%20dashboard/widgets/adminText.dart';
import 'package:qpi_eng/views/admin%20dashboard/widgets/realisticCard.dart';

class Admindashboard extends StatelessWidget {
  const Admindashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final adminVm = Provider.of<Adminvm>(context);

    return Scaffold(
      appBar: AppBar(),
      drawer: AdminDrawer(
        drawerFunc: () {
          adminVm.logOut(context);
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 800,
            width: double.infinity,
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Welocome',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '  Admin',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Admintext(
                        title:
                            'This account is belong to admin\n Admin can have authority can \n \n‣ create user \n‣approve maintenace\n‣reject maintenacen\n‣can create maintenace ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),

                      const SizedBox(height: 50),
                      SingleChildScrollView(
                        child: StreamBuilder<int>(
                          stream: adminVm.notificationCount(),
                          builder: (context, snapshot) {
                            final count = snapshot.data ?? 0;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const PendingMaintenance(),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons
                                                .notification_important_rounded,
                                            color: Colors.blue,
                                            size: 60,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.sizeOf(
                                                context,
                                              ).height *
                                              0.0002,
                                        ),
                                        Text(
                                          'Pending',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (count > 0)
                                      Positioned(
                                        right: 0,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.red,
                                          child: Text(
                                            '$count',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          RoutesNames.createUser,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.person_add,
                                        color: Colors.blue,
                                        size: 50,
                                      ),
                                    ),
                                    Text(
                                      'Creare user',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      RealisticCard(
                        color: Colors.white,
                        title: 'create Maintenance',
                        onTap: () {
                          Navigator.pushNamed(context, RoutesNames.prevenMn);
                        },
                        icon: Icons.create,
                      ),
                      RealisticCard(
                        color: Colors.white,
                        title: ' Preventive History',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesNames.prevenMnHistory,
                          );
                        },
                        icon: Icons.history,
                      ),

                      RealisticCard(
                        color: Colors.white,
                        title: 'Scan Barcode',
                        onTap: () {
                          Navigator.pushNamed(context, RoutesNames.scanBarCode);
                        },
                        icon: Icons.scanner,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
