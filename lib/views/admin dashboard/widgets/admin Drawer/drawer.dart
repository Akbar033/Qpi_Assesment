import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/viewmodel/adminiDashoboard/AdminVm.dart';

class AdminDrawer extends StatelessWidget {
  final VoidCallback drawerFunc;

  const AdminDrawer({super.key, required this.drawerFunc});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Adminvm>(context, listen: false);

    return Drawer(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(right: 40),
        decoration: const BoxDecoration(
          color: Color(0xFFF1F3F6),
          borderRadius: BorderRadius.horizontal(right: Radius.circular(28)),
        ),
        child: SafeArea(
          child: FutureBuilder(
            future: vm.fetchUserName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No user found'));
              }

              final data = snapshot.data as Map<String, dynamic>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(6, 6),
                          blurRadius: 12,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-6, -6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name'] ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(data['email'] ?? ''),
                        const SizedBox(height: 4),
                        Text(
                          "${data['role'] ?? ''}",
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Example Menu Item Card
                  _drawerItem(icon: Icons.dashboard, title: 'Dashboard'),
                  _drawerItem(icon: Icons.settings, title: 'Settings'),
                  InkWell(
                    onTap: drawerFunc,

                    child: _drawerItem(icon: Icons.logout, title: 'Logout'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _drawerItem({required IconData icon, required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(4, 4), blurRadius: 8),
          BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [Icon(icon), const SizedBox(width: 14), Text(title)],
      ),
    );
  }
}
