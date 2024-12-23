import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/progress_indicator.dart';
import '../widgets/multiple_selections.dart';
import '../widgets/result_card.dart';
import 'custom_page.dart';

class FindGenrePage extends StatefulWidget {
  const FindGenrePage({Key? key}) : super(key: key);

  @override
  State<FindGenrePage> createState() =>
      _FindYourFavoriteGenrePageState();
}

class _FindYourFavoriteGenrePageState extends State<FindGenrePage> {
  List<String> _randomGenres = [];
  List<Map<String, dynamic>> _comicOptions = [];
  List<Map<String, dynamic>> _imageOptions = [];
  int _currentQuestionIndex = 0;
  Map<int, List<String>> _answers = {}; // Store answers for each question
  String _statusMessage = "Loading questions...";
  bool _isLoadingComics = false;

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  Future<void> _fetchGenres() async {
    try {
      print("Fetching genres...");
      final response = await http.get(
        Uri.parse("http://localhost:5000/api/comics"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;

        // Flatten genres into a unique list
        final List<String> genres = [];
        for (var comic in data) {
          genres.addAll(comic["genres"].first.split(','));
        }

        final Set<String> uniqueGenres =
            genres.map((s) => s.trim()).toSet();
        final List<String> uniqueGenresList = uniqueGenres.toList()..shuffle();

        // Select 4 random genres
        setState(() {
          _randomGenres = uniqueGenresList.take(4).toList();
          _statusMessage = "";
        });
      } else {
        setState(() {
          _statusMessage = "Failed to load genres. Please try again later.";
        });
      }
    } catch (error) {
      setState(() {
        _statusMessage = "Error: Unable to fetch genres.";
      });
    }
  }

  Future<void> _fetchComicsByGenres(List<String> genres) async {
  setState(() {
    _isLoadingComics = true; // Indicate that comics are being loaded
  });

  try {
    final response = await http.get(
      Uri.parse("http://localhost:5000/api/comics"), // Replace with your API URL
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;

      // Filter comics based on selected genres
      final filteredComics = data.where((comic) {
        final List<String> comicGenres =
            (comic["genres"].first.split(',') as List<dynamic>)
                .map((genre) => genre.toString().trim())
                .toList();

        return genres.any((genre) => comicGenres.contains(genre));
      }).toList();

      filteredComics.shuffle();

      final selectedComics = filteredComics.take(4).map((comic) {
        return {
          "title": comic["title"].toString(), // Ensure all values are Strings
          "image": comic["imageUrl"].toString(),
        };
      }).toList();

      setState(() {
        _comicOptions = List<Map<String, String>>.from(selectedComics); // Cast explicitly
        _statusMessage = _comicOptions.isEmpty
            ? "No comics found for the selected genres."
            : "";
      });
    } else {
      setState(() {
        _statusMessage = "Failed to load comics. Please try again later.";
      });
    }
  } catch (error) {
    setState(() {
      _statusMessage = "Error: Unable to fetch comics.";
    });
  } finally {
    setState(() {
      _isLoadingComics = false; // Reset loading state
    });
  }
}

Future<void> _fetchImageOptions(List<String> genres) async {
  try {
    final response = await http.get(
      Uri.parse("http://localhost:5000/api/comics"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;

      // Filter comics for images
      final filteredComics = data.where((comic) {
        final List<String> comicGenres =
            (comic["genres"].first.split(',') as List<dynamic>)
                .map((genre) => genre.toString().trim())
                .toList();
        return genres.any((genre) => comicGenres.contains(genre));
      }).toList();

      filteredComics.shuffle();

      final selectedComics = filteredComics.take(4).map((comic) {
        return {
          "title": comic["title"].toString(), // Ensure all values are Strings
          "image": comic["imageUrl"].toString(),
        };
      }).toList();

      setState(() {
        _imageOptions = List<Map<String, String>>.from(selectedComics); // Cast explicitly
      });
    }
  } catch (error) {
    print("Error fetching image options: $error");
  }
}


  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "Find Your Favorite Genre",
      body: _isLoadingComics
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProgressIndicatorWidget(
                    currentQuestion: _currentQuestionIndex + 1,
                    totalQuestions: 3,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _buildQuestion(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentQuestionIndex > 0)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _currentQuestionIndex--;
                            });
                          },
                          child: const Text("Back"),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentQuestionIndex == 0) {
                            final selectedGenres =
                                _answers[0] ?? [];
                            _fetchComicsByGenres(selectedGenres);
                            setState(() {
                              _currentQuestionIndex++;
                            });
                          } else if (_currentQuestionIndex == 1) {
                            final selectedComics =
                                _answers[1] ?? [];
                            _fetchImageOptions(selectedComics);
                            setState(() {
                              _currentQuestionIndex++;
                            });
                          } else {
                            _showResult();
                          }
                        },
                        child: Text(
                          _currentQuestionIndex == 2 ? "Finish" : "Next",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildQuestion() {
  if (_currentQuestionIndex == 0) {
    return MultipleSelectionsQuestion(
      question: "Which genres are you most interested in?",
      options: _randomGenres.map((genre) => {"title": genre}).toList(),
      onSelectionsChanged: (selections) {
        setState(() {
          _answers[_currentQuestionIndex] = selections;
        });
      },
      containsImages: false,
    );
  } else if (_currentQuestionIndex == 1) {
    return MultipleSelectionsQuestion(
      question: "Which of the following comics have you read?",
      options: List<Map<String, String>>.from(_comicOptions), // Cast explicitly
      onSelectionsChanged: (selections) {
        setState(() {
          _answers[_currentQuestionIndex] = selections;
        });
      },
      containsImages: true,
    );
  } else if (_currentQuestionIndex == 2) {
    return MultipleSelectionsQuestion(
      question: "Which comic looks the most interesting to you?",
      options: List<Map<String, String>>.from(_imageOptions), // Cast explicitly
      onSelectionsChanged: (selections) {
        setState(() {
          _answers[_currentQuestionIndex] = selections;
        });
      },
      containsImages: true,
    );
  } else {
    return const Text("Unknown question");
  }
}

  void _showResult() {
    final allGenres = [
      ...(_answers[0] ?? []),
      ...(_answers[2] ?? []),
    ];
    final uniqueGenres = allGenres.toSet().toList();
    final randomGenre = (uniqueGenres..shuffle()).first;

    final selectedComic = _comicOptions.firstWhere(
      (comic) =>
          (comic["genres"] as List<dynamic>)
              .map((g) => g.toString().trim())
              .contains(randomGenre),
      orElse: () => {"title": "No recommendations available."},
    );

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ResultCard(
              genre: selectedComic["title"]!,
              description:
                  "Thanks for your responses! Based on your interests, we recommend this comic.",
            ),
          ),
        );
      },
    );
  }
}
