import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:smart_assistant/data/models/suggestions_model.dart';
import '../data/datasources/repositories/suggestions_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final SuggestionRepository repository;

  HomeViewModel(this.repository) {
    _listenToConnectivity();
  }

  List<Suggestion> _allSuggestions = [];
  List<Suggestion> visibleSuggestions = [];

  int currentPage = 1;
  final int limit = 10;

  bool isLoading = false;
  bool hasNext = true;

  StreamSubscription? _subscription;

  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    try {
      _allSuggestions = await repository.getAllSuggestions();
      _resetPagination();
      _loadPage();
    } catch (e) {
      print("ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // CONNECTIVITY
  void _listenToConnectivity() {
    _subscription =
        Connectivity().onConnectivityChanged.listen((result) {
          if (result != ConnectivityResult.none) {
            refresh();
          }
        });
  }

  // RESET PAGINATION
  void _resetPagination() {
    currentPage = 1;
    visibleSuggestions.clear();
    hasNext = true;
  }

  // PAGINATION LOGIC
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

  Future<void> refresh() async {
    try {
      _allSuggestions = await repository.getAllSuggestions();
      _resetPagination();
      _loadPage();
      notifyListeners();
    } catch (e) {
      print("REFRESH ERROR: $e");
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}