import 'package:berkel_tracking_servise/models/table_row_data.dart';
import 'package:berkel_tracking_servise/models/user_plan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPlanService {
  final CollectionReference userPlansCollection =
      FirebaseFirestore.instance.collection('userplans');

  Future<void> addUserPlan(UserPlanModel plan) async {
    await userPlansCollection.add(plan.toMap());
  }

  Future<void> deleteUserPlanByTask(TableRowData task) async {
    final querySnapshot = await userPlansCollection
        .where('id', isEqualTo: task.id)
        .where('stationName', isEqualTo: task.location)
        .where('gonerNote', isEqualTo: task.note)
        .where('category', isEqualTo: task.category)
        .where('problem', isEqualTo: task.problem)
        .get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> deleteAllUserPlans() async {
    final querySnapshot = await userPlansCollection.get();
    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Stream<List<UserPlanModel>> get userPlansStream {
    return userPlansCollection.where('saveFault', isEqualTo: false).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserPlanModel.fromMap(data, doc.id);
      }).toList();
    });
  }

 Stream<List<UserPlanModel>> get reportFault {
  return userPlansCollection
      
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return UserPlanModel.fromMap(data, doc.id);
        }).toList();
      });
}


  Future<void> deleteUserPlanById(String docId) async {
    await userPlansCollection.doc(docId).delete();
  }

Future<UserPlanModel?> getUserPlanById(String docId) async {
  final docSnapshot = await userPlansCollection.doc(docId).get();

  if (!docSnapshot.exists) return null;

  final data = docSnapshot.data() as Map<String, dynamic>;
  return UserPlanModel.fromMap(data, docSnapshot.id);
}


  Future<void> updateUserPlanAssignedStatus(
    String docId,
    bool isAssigned,
  ) async {
    await userPlansCollection.doc(docId).update({'isAssigned': isAssigned});
  }

  Future<void> updateUserPlanDoneStatus(String docId, bool isDone, String gonerNote,DateTime fixedTime ) async {
    await userPlansCollection.doc(docId).update({'isDone': isDone,
    'saveFault': true,
    'gonerNote': gonerNote,
    'fixedTime': fixedTime,
 

    });
  }
  
  Future<void> updateUserPlanFields(String docId, Map<String, dynamic> updates) async {
  await userPlansCollection.doc(docId).update(updates);
}

}
