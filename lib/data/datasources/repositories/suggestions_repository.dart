import 'package:smart_assistant/data/datasources/remote/suggestions_api.dart';
import 'package:smart_assistant/data/models/suggestions_model.dart';

class SuggestionRepository {
  final SuggestionRemoteDataSource remote;

  SuggestionRepository(this.remote);

  Future<List<Suggestion>> getAllSuggestions() async {
    final raw = await remote.fetchAllSuggestions();

    return raw.map((e) => Suggestion.fromJson(e)).toList();
  }
}