import 'package:flutter/material.dart';
import 'package:smart_assistant/data/models/suggestions_model.dart';
import '../data/datasources/repositories/suggestions_repository.dart';


class HomeViewModel extends ChangeNotifier {
  final SuggestionRepository repository;

  HomeViewModel(this.repository);

  List<Suggestion> _allSuggestions = [];
  List<Suggestion> visibleSuggestions = [];

  int currentPage = 1;
  final int limit = 10;

  bool isLoading = false;
  bool hasNext = true;

  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    _allSuggestions = await repository.getAllSuggestions();

    _loadPage();

    isLoading = false;
    notifyListeners();
  }

  void _loadPage() {
    final start = (currentPage - 1) * limit;
    final end = start + limit;

    if (start >= _allSuggestions.length) {
      hasNext = false;
      return;
    }

    final newItems = _allSuggestions.sublist(
      start,
      end > _allSuggestions.length ? _allSuggestions.length : end,
    );

    visibleSuggestions.addAll(newItems);

    hasNext = end < _allSuggestions.length;
  }

  void loadMore() {
    if (!hasNext || isLoading) return;

    currentPage++;
    _loadPage();
    notifyListeners();
  }
}