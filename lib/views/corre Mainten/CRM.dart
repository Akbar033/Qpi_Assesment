import 'package:flutter/material.dart';
import 'package:qpi_eng/enums/correMnenum.dart';

class CreateCorrectiveMaintenance extends StatefulWidget {
  const CreateCorrectiveMaintenance({super.key});

  @override
  State<CreateCorrectiveMaintenance> createState() =>
      _CreateCorrectiveMaintenanceState();
}

class _CreateCorrectiveMaintenanceState
    extends State<CreateCorrectiveMaintenance> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final machineTypeController = TextEditingController();
  final malfunctionReasonController = TextEditingController();
  final issuedReportController = TextEditingController();
  final sparePartsController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  bool isFaultFixed = false;

  MaintenanceStatus status = MaintenanceStatus.pending;

  Future<void> pickDate(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        isStart ? startDate = date : endDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Corrective Maintenance')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Machine Type
              TextFormField(
                controller: machineTypeController,
                decoration: const InputDecoration(labelText: 'Machine Type'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),

              // Malfunction Reason
              TextFormField(
                controller: malfunctionReasonController,
                decoration: const InputDecoration(
                  labelText: 'Malfunction Reason',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),

              // Issued Report
              TextFormField(
                controller: issuedReportController,
                decoration: const InputDecoration(labelText: 'Issued Report'),
              ),

              // Spare Parts Used
              TextFormField(
                controller: sparePartsController,
                decoration: const InputDecoration(
                  labelText: 'Spare Parts Used',
                ),
              ),

              const SizedBox(height: 12),

              // Start Date
              ListTile(
                title: Text(
                  startDate == null
                      ? 'Select Start Date'
                      : 'Start: ${startDate!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_month),
                onTap: () => pickDate(true),
              ),

              // End Date
              ListTile(
                title: Text(
                  endDate == null
                      ? 'Select End Date'
                      : 'End: ${endDate!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_month),
                onTap: () => pickDate(false),
              ),

              const SizedBox(height: 12),

              // Fault Fixed
              SwitchListTile(
                title: const Text('Fault Fixed'),
                value: isFaultFixed,
                onChanged: (v) {
                  setState(() => isFaultFixed = v);
                },
              ),

              // Status Dropdown
              DropdownButtonFormField<MaintenanceStatus>(
                value: status,
                decoration: const InputDecoration(
                  labelText: 'Maintenance Status',
                ),
                items: MaintenanceStatus.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (v) {
                  if (v != null) setState(() => status = v);
                },
              ),

              const SizedBox(height: 24),

              // Create Button
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  final model = {
                    'machine_type': machineTypeController.text,
                    'malfunction_reason': malfunctionReasonController.text,
                    'issued_reports': issuedReportController.text,
                    'spareparts_used': sparePartsController.text,
                    'start_date': startDate,
                    'end_date': endDate,
                    'is_fault_fixed': isFaultFixed,
                    'main_status': status.name,
                  };

                  // 👉 Call ViewModel / Firestore here
                  // vm.createCorrectiveMaintenance(model);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Maintenance Created')),
                  );
                },
                child: const Text('Create Maintenance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
