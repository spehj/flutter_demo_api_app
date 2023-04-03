import 'package:flutter_demo_api_app/models/time.dart';

// Log class
class Log {
  final String? note;
  final DateTime date;
  final int duration;
  final String? projectName;
  final String? taskName;
  final String? clientName;
  final int projectInvoiceMethod;
  final bool projectArchived;
  final bool taskArchived;
  final String? customField1;
  final String? customField2;
  final String? customField3;
  final bool running;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<Time> times;
  final int status;
  final int invoiceId;
  final int projectId;
  final int taskId;
  final bool billable;
  final bool? inLockedPeriod;
  final double expense;
  final int userId;
  final double amount;
  final double rate;
  final double laborCost;
  final double laborRate;
  final int billableDuration;
  final double billableHours;
  final double laborHours;
  final List<dynamic> tags;
  final List<dynamic> attachments;
  final double billableAmount;
  final int id;

  Log({
    this.note,
    required this.date,
    required this.duration,
    this.projectName,
    this.taskName,
    this.clientName,
    required this.projectInvoiceMethod,
    required this.projectArchived,
    required this.taskArchived,
    this.customField1,
    this.customField2,
    this.customField3,
    required this.running,
    this.startTime,
    this.endTime,
    required this.times,
    required this.status,
    required this.invoiceId,
    required this.projectId,
    required this.taskId,
    required this.billable,
    this.inLockedPeriod,
    required this.expense,
    required this.userId,
    required this.amount,
    required this.rate,
    required this.laborCost,
    required this.laborRate,
    required this.billableDuration,
    required this.billableHours,
    required this.laborHours,
    required this.tags,
    required this.attachments,
    required this.billableAmount,
    required this.id,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    /// Factory constructor to create a Log object from JSON
    return Log(
      note: json['note'].toString(),
      date: DateTime.parse(json['date']),
      duration: json['duration'],
      projectName: json['projectName'].toString(),
      taskName: json['taskName'].toString(),
      clientName: json['clientName'].toString(),
      projectInvoiceMethod: json['projectInvoiceMethod'],
      projectArchived: json['projectArchived'],
      taskArchived: json['taskArchived'],
      customField1: json['customField1'].toString(),
      customField2: json['customField2'].toString(),
      customField3: json['customField3'].toString(),
      running: json['running'],
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      times: List<Time>.from(json['times'].map((time) => Time.fromJson(time))),
      status: json['status'],
      invoiceId: json['invoiceId'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      billable: json['billable'],
      inLockedPeriod: json['inLockedPeriod'],
      expense: json['expense'],
      userId: json['userId'],
      amount: json['amount'],
      rate: json['rate'],
      laborCost: json['laborCost'],
      laborRate: json['laborRate'],
      billableDuration: json['billableDuration'],
      billableHours: json['billableHours'],
      laborHours: json['laborHours'],
      tags: json['tags'],
      attachments: json['attachments'],
      billableAmount: json['billableAmount'],
      id: json['id'],
    );
  }
}
