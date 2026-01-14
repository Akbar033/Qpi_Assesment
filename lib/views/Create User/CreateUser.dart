import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpi_eng/viewmodel/Admin%20Creatin/CreateuserVM.dart';

class CreateUser extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final roleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final createVm = Provider.of<CreateUserVM>(context);
    return Scaffold(
      body: SafeArea(
        child: Consumer<CreateUserVM>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,

                  child: Form(
                    key: widget.formKey,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Welc',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: 'O',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 40,
                                  ),
                                ),
                                TextSpan(
                                  text: 'me',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            'This account is for user who\n can make maintenace but\n wait for admin to approve\n or reject',
                          ),
                          SizedBox(height: 30),

                          //name textfiel,
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Enter Name',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // last name,
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                labelText: 'Enter last Name',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Email textfield
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Enter Email',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          //password textfield
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter password';
                                }
                                return null;
                              },
                              controller: passController,
                              decoration: InputDecoration(
                                labelText: 'Enter Password',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          //Role
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: roleController,
                              decoration: InputDecoration(
                                labelText: 'Enter Role',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: roleController,
                              decoration: InputDecoration(
                                labelText: 'Company Id',
                              ),
                            ),
                          ),
                          SizedBox(height: 30),

                          Consumer<CreateUserVM>(
                            builder: (context, vm, _) {
                              return TextButton(
                                onPressed: () {
                                  if (widget.formKey.currentState!.validate()) {
                                    vm.adminCreateUser(
                                      nameController.text.trim(),
                                      lastNameController.text.trim(),
                                      emailController.text.trim(),
                                      passController.text,
                                      context,
                                      roleController.text.trim(),
                                    );
                                  }
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
