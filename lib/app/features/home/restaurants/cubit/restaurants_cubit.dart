import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit()
      : super(const RestaurantsState(
          documents: [],
          errorMessage: '',
          isLoading: false,
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const RestaurantsState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('restaurants')
        .orderBy('rating', descending: true)
        .snapshots()
        .listen((data) {
      emit(
        RestaurantsState(
          isLoading: false,
          errorMessage: '',
          documents: data.docs,
        ),
      );
    })
      ..onError((error) {
        emit(
          RestaurantsState(
            isLoading: false,
            errorMessage: error.toString(),
            documents: [],
          ),
        );
      });
  }

  Future<void> delete({required String documentId}) async {
    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(documentId)
        .delete();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
