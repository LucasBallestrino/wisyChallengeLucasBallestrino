import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_challenge/app/services/firestore_service.dart';


final databaseProvider = Provider<FirestoreService?>((ref){
  return FirestoreService();
});