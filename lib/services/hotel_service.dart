import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/hotel_model.dart';

class HotelService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference hotels = FirebaseFirestore.instance.collection(
    'hotels',
  );

  Future<List<Hotel>> getPaginateHotels(
    Timestamp? startAt,
    int size,
  ) async {
    QuerySnapshot<Object?> response = startAt == null
        ? await hotels
            .orderBy('creation_date', descending: true)
            .limit(size)
            .get()
        : await hotels
            .orderBy('creation_date', descending: true)
            .startAfter([startAt])
            .limit(size)
            .get();

    List<Hotel> data = [];

    for (var item in response.docs) {
      var json = item.data() as Map<String, dynamic>;
      data.add(Hotel.fromJson({
        ...json,
        'id': item.id,
      }));
    }
    return data;
  }

  Future<List<Hotel>> searchHotels(String name) async {
    final response = await hotels.where('name', isEqualTo: name).get();

    List<Hotel> data = [];

    for (var item in response.docs) {
      var json = item.data() as Map<String, dynamic>;
      data.add(Hotel.fromJson({
        ...json,
        'id': item.id,
      }));
    }

    return data;
  }

  Future<void> toogleHotelFav(String id, bool value) async {
    await hotels.doc(id).update({"favorite": value});
  }

  Stream<DocumentSnapshot<Object?>> getHotelById(String id) {
    return hotels.doc(id).snapshots();
  }
}
