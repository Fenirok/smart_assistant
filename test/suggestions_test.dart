import 'package:flutter_test/flutter_test.dart';
import 'package:smart_assistant/view_model/suggestions_vm.dart';
import 'package:smart_assistant/data/models/suggestions_model.dart';
import 'package:smart_assistant/data/datasources/repositories/suggestions_repository.dart';

class FakeSuggestionRepo implements SuggestionRepository {
  @override
  Future<List<Suggestion>> getAllSuggestions() async {
    return List.generate(
      25,
          (i) => Suggestion(
        id: "$i",
        title: "What is Flutter $i?",
        description: "Explanation $i",
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("pagination should load next page correctly", () async {
    final vm = HomeViewModel(FakeSuggestionRepo());

    await vm.init();

    expect(vm.visibleSuggestions.length, 10);

    vm.loadMore();

    expect(vm.currentPage, 2);
    expect(vm.visibleSuggestions.length, greaterThan(10));
  });
}