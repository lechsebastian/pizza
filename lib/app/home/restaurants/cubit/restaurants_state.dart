part of 'restaurants_cubit.dart';

@immutable
class RestaurantsState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const RestaurantsState(
      {required this.isLoading,
      required this.errorMessage,
      required this.documents});
}
