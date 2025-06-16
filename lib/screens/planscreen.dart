import 'package:berkel_tracking_servise/widgets/main_screen_widgets/customerdrawe.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/modern_custome_appbar.dart';
import 'package:berkel_tracking_servise/widgets/plan_perparation_widgets/planTable_card.dart';
import 'package:flutter/material.dart';
import 'package:berkel_tracking_servise/firebase_services/firestoreservies.dart';
import 'package:berkel_tracking_servise/models/user_plan.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final UserPlanService userPlanService = UserPlanService();

  final List<String> users = ['abdelrahman', 'cihan bey', 'burak'];
  Future<void> assignTaskIfNotDone(String user, UserPlanModel plan) async {
    UserPlanModel? existingPlan = await userPlanService.getUserPlanById(
      plan.docId!,
    );

    if (existingPlan != null && !existingPlan.isAssigned) {
      await userPlanService.updateUserPlanFields(existingPlan.docId!, {
        'isAssigned': true,
        'gonerName': user,
        'gonerNote': "",
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task already assigned and pending')),
      );
    }
  }

  Future<void> deletTask(String docId) async {
    await userPlanService.deleteUserPlanById(docId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(name: 'Plan'),
      appBar: ModernAppBar2(title: 'plan', icon: Icon(Icons.checklist)),
      backgroundColor: Colors.white,
      body: StreamBuilder<List<UserPlanModel>>(
        stream: userPlanService.userPlansStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading user plans'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final plans = snapshot.data ?? [];

          if (plans.isEmpty) {
            return const Center(child: Text('No plans available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              
              itemCount: plans.length,
              itemBuilder: (context, index) {
                return UserPlanCard(
                  plan: plans[index],
                  users: users,
                  onAssign: assignTaskIfNotDone,
                  onDelete: deletTask,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
