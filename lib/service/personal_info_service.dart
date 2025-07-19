import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalInfoService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('personal_information');

  Future<void> insertUserData (String fname, String mname, String lname, String email, String age, String address ) async {
    await usersCollection.add({
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'email': email,
      'age': age,
      'address': address,
      // 'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
