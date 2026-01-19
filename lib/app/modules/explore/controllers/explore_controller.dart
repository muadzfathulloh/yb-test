import 'package:get/get.dart';

class ExploreController extends GetxController {
  final categories = [
    'Technology',
    'Business',
    'Health',
    'Science',
    'Sports',
    'Entertainment',
    'Politics',
    'Education',
  ].obs;

  final trendingTopics = [
    '#FlutterDev',
    '#AIRevolution',
    '#SpaceX',
    '#CleanEnergy',
    '#GlobalEconomy',
    '#QuantumComputing',
  ].obs;

  final suggestedAuthors = [
    {'name': 'Alex Rivero', 'handle': '@arivero', 'bio': 'Tech Enthusiast'},
    {'name': 'Sarah Chen', 'handle': '@schen', 'bio': 'Journalist & Writer'},
    {'name': 'Marcus Wright', 'handle': '@mwright', 'bio': 'Political Analyst'},
  ].obs;

  void onSearch(String query) {
    // Implement search logic if needed
  }
}
