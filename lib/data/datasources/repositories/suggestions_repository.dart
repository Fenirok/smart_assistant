import 'package:smart_assistant/data/datasources/remote/suggestions_api.dart';
import 'package:smart_assistant/data/models/suggestions_model.dart';
import 'package:smart_assistant/data/models/suggestions_model.dart';

abstract class SuggestionRepository {
  Future<List<Suggestion>> getAllSuggestions();
}

class SuggestionRepositoryImpl implements SuggestionRepository{
  final SuggestionRemoteDataSource remote;

  SuggestionRepositoryImpl(this.remote);

  Future<List<Suggestion>> getAllSuggestions() async {
    final raw = await remote.fetchAllSuggestions();

    return raw.map((e) => Suggestion.fromJson(e)).toList();
  }
}