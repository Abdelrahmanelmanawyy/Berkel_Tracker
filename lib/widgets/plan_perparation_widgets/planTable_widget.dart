import 'package:flutter/material.dart';
import 'package:berkel_tracking_servise/models/table_row_data.dart';
import 'package:berkel_tracking_servise/models/user_plan.dart';

class PlanTable extends StatefulWidget {
  final List<TableRowData> data;
  final List<String> users;
  final List<UserPlanModel> assignedPlans;
  final Future<void> Function(String user, TableRowData task) onAssign;

  const PlanTable({
    Key? key,
    required this.data,
    required this.users,
    required this.assignedPlans,
    required this.onAssign,
  }) : super(key: key);

  @override
  State<PlanTable> createState() => _PlanTableState();
}

class _PlanTableState extends State<PlanTable> {
  int? expandedIndex;
  late Map<String, String> rowAssignments;

  @override
  void initState() {
    super.initState();
    _initRowAssignments();
  }

  @override
  void didUpdateWidget(covariant PlanTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assignedPlans != widget.assignedPlans) {
      _initRowAssignments();
    }
  }

  void _initRowAssignments() {
    rowAssignments = {
      for (var plan in widget.assignedPlans) plan.docId!: plan.gonerName,
    };
    setState(() {});
  }

  Color _getRowColor(String rowId) {
    return rowAssignments.containsKey(rowId) ? Colors.lightBlue[100]! : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: const [
              Expanded(flex: 2, child: Center(child: Text("Date"))),
              Expanded(flex: 2, child: Center(child: Text("Name"))),
              Expanded(flex: 3, child: Center(child: Text("Problem"))),
              Expanded(flex: 3, child: Center(child: Text("Location"))),
              Expanded(flex: 3, child: Center(child: Text("Note"))),
            ],
          ),
        ),
        ...List.generate(widget.data.length, (index) {
          final row = widget.data[index];
          final isExpanded = expandedIndex == index;
          final assignedUser = rowAssignments[row.id];

          return Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    expandedIndex = isExpanded ? null : index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: _getRowColor(row.id),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Center(child: Text(row.date))),
                      Expanded(flex: 2, child: Center(child: Text(assignedUser ?? row.name))),
                      Expanded(flex: 3, child: Center(child: Text(row.problem))),
                      Expanded(flex: 3, child: Center(child: Text(row.location))),
                      Expanded(flex: 3, child: Center(child: Text(row.note))),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Wrap(
                    spacing: 10,
                    children: widget.users.map((user) {
                      final isSelected = assignedUser == user;
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
                          foregroundColor: isSelected ? Colors.white : Colors.black,
                        ),
                        onPressed: () async {
                          await widget.onAssign(user, row);
                          setState(() {
                            rowAssignments[row.id] = user;
                            expandedIndex = null;
                          });
                        },
                        child: Text(user),
                      );
                    }).toList(),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }
}
