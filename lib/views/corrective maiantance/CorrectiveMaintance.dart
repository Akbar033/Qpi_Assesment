import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qpi_eng/Utils/Routes/RoutesName.dart';
import 'package:qpi_eng/views/corrective%20maiantance/widgets/Next1.dart';
import 'package:qpi_eng/views/corrective%20maiantance/widgets/Next2.dart';
import 'package:qpi_eng/views/corrective%20maiantance/widgets/Next3.dart';
import 'package:qpi_eng/views/corrective%20maiantance/widgets/Next4.dart';
import 'package:qpi_eng/views/corrective%20maiantance/widgets/Next5.dart';
import 'package:qpi_eng/views/corrective%20maiantance/widgets/Next6.dart';
import 'package:qpi_eng/views/corrective%20maiantance/widgets/Next7.dart';
import 'package:qpi_eng/views/corrective%20maiantance/widgets/Next9.dart';

import 'package:qpi_eng/views/corrective%20maiantance/widgets/next8.dart';

class CorrectiveMaintanance extends StatefulWidget {
  const CorrectiveMaintanance({super.key});

  @override
  State<CorrectiveMaintanance> createState() => _CorrectiveMaintananceState();
}

class _CorrectiveMaintananceState extends State<CorrectiveMaintanance> {
  Map<String, dynamic> maintananceData = {
    'created_at': FieldValue.serverTimestamp(),
    'type': {'malfunctiontype': '', 'deviceType': '', 'reason': ''},
    'machine status': {
      'fault stop machine': false,
      'reason why stop machine': '',
    },
    'malfunction reason': {'reason': '', 'malfunction comment': ''},
    'fault fixed': {'is_fault_fixed': false, 'fault_fixed_comment': ''},
    'Spare_parts': {'sprareparts_comment': '', 'spare_parts_used': false},
    'start_date': {'maintenance_date': '', 'maintenance_comment': ''},
    'end_date': {'maintenance_end_date': '', 'end_date_comment': ''},
    'Description': {'report_description': '', 'Complete Description': ''},
    'timeCreation': {
      'created_at'
          '${Timestamp.now()}',
    },
  };
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //void add data
  Future<void> addData_to_Db() async {
    try {
      await firestore.collection('maintanance_data').add(maintananceData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('successfully add')),
        snackBarAnimationStyle: AnimationStyle(
          duration: Duration(seconds: 3),
          curve: Curves.bounceInOut,
        ),
      );
    } catch (e) {
      print('❌error is happeing:-🤦‍♂️$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error while adding data ')),
        snackBarAnimationStyle: AnimationStyle(
          reverseCurve: Curves.bounceInOut,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushNamed(context, RoutesNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        //color: Colors.white,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [Text('Overall Status'), Text("0")],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.08,
                        width: MediaQuery.sizeOf(context).width * 0.65,
                        // color: Colors.white,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: [Text('Pending '), Text('0')],
                                ),
                              ),

                              SingleChildScrollView(
                                child: Column(
                                  children: [Text('Progress '), Text('0')],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [Text('Completed '), Text('0')],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [Text('Completed '), Text('0')],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Next1(),
                SizedBox(height: 20),
                Next2(
                  onTextChanged: (value) {
                    maintananceData['type']['reason'] = value;
                  },
                  onDropDownChange: (value) =>
                      maintananceData['type']['deviceType'] = value,
                ),
                SizedBox(height: 10),
                Next3(
                  onYesNoChanged: (value) {
                    maintananceData['machine status']['fault stop machine'] =
                        value;
                  },
                  onReasonChanged: (reason) {
                    maintananceData['machine status']['reason why stop machine'] =
                        reason;
                  },
                ),

                SizedBox(height: 10),
                Next4(
                  onComment: (value) {
                    maintananceData['malfunction reason']['reason'] = value;
                  },
                  onReason: (value) {
                    maintananceData['malfunction reason']['malfunction comment'] =
                        value;
                  },
                ),
                SizedBox(height: 10),
                Next5(
                  onComment: (comment) {
                    maintananceData['fault fixed']['fault_fixed_comment'] =
                        comment;
                  },

                  isFixed: (yesNo) {
                    maintananceData['fault fixed']['is_fault_fixed'] = yesNo;
                  },
                ),
                SizedBox(height: 10),
                Next6(
                  sparePartsComment: (comment) {
                    maintananceData['Spare_parts']['sprareparts_comment'] =
                        comment;
                  },
                  usedOrNot: (yesNo) {
                    maintananceData['Spare_parts']['spare_parts_used'] = yesNo;
                  },
                ),
                SizedBox(height: 10),
                Next7(
                  selectStartDate: (dates) {
                    maintananceData['start_date']['maintenance_date'] =
                        "${dates.day}/${dates.month}/${dates.year}";
                  },
                  onComment: (commet) {
                    maintananceData['start_date']['maintenance_comment'] =
                        commet;
                  },
                ),
                SizedBox(height: 10),
                Next8(
                  endDate: (date) {
                    maintananceData['end_date']['maintenance_end_date'] =
                        '${date.day}/${date.month}/${date.year}';
                  },
                  onComment: (commentON) {
                    maintananceData['end_date']['end_date_comment'] = commentON;
                  },
                ),
                SizedBox(height: 10),
                Next9(
                  onTextSend: (value) {
                    maintananceData['Description']['report_description'] =
                        'Description';
                  },
                  onTxtfield: (txtValue) {
                    maintananceData['Description']['Complete Description'] =
                        txtValue;
                  },
                ),

                SizedBox(height: 30),
                TextButton(onPressed: addData_to_Db, child: Text('Save Data')),

                //SizedBox(height: 10),
                //Next7(),
                //SizedBox(height: 10),
                // Next9(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
