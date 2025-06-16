import 'package:berkel_tracking_servise/widgets/plan_perparation_widgets/user_task_card.dart';
import 'package:flutter/material.dart';
import 'package:berkel_tracking_servise/firebase_services/firestoreservies.dart';
import 'package:berkel_tracking_servise/models/user_plan.dart';

class UserScreen extends StatefulWidget {
  final String userName;
  const UserScreen({required this.userName, Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserPlanService userPlanService = UserPlanService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: StreamBuilder<List<UserPlanModel>>(
        stream: userPlanService.userPlansStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Error loading tasks"));
          }

          final tasks = snapshot.data!
              .where((task) =>
                  task.gonerName == widget.userName && task.isAssigned== true )
              .toList();

          if (tasks.isEmpty) {
            return const Center(child: Text("No tasks assigned."));
          }

           return ListView.builder(
  itemCount: tasks.length,
  itemBuilder: (context, index) {
    final task = tasks[index];
    return UserTaskCard(
      task: task,
      userPlanService: userPlanService,
      
    );
  },
);
        },
      ),
    );
  }
}
