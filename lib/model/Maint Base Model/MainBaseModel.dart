// creating the base model for maintenance models which preventive and corrective will extendc

abstract class Mainbasemodel {
  final bool isFaultFixed;
  final DateTime startdate;
  final DateTime endDate;
  final String mainStatus;
  final bool sparepartsUsed;

  Mainbasemodel({
    required this.isFaultFixed,
    required this.startdate,
    required this.endDate,
    required this.mainStatus,
    this.sparepartsUsed = false,
  });
  // to show maintenance Status pending, process, completed
  Map<String, dynamic> toMap();
}
