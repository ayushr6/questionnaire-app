import 'package:flutter/material.dart';

class MultipleSelectionsQuestion extends StatefulWidget {
  final String question;
  final List<Map<String, String>> options;
  final ValueChanged<List<String>> onSelectionsChanged;
  final bool containsImages;

  const MultipleSelectionsQuestion({
    Key? key,
    required this.question,
    required this.options,
    required this.onSelectionsChanged,
    this.containsImages = false,
  }) : super(key: key);

  @override
  _MultipleSelectionsQuestionState createState() =>
      _MultipleSelectionsQuestionState();
}

class _MultipleSelectionsQuestionState
    extends State<MultipleSelectionsQuestion> {
  final Set<String> _selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two options per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            final option = widget.options[index];
            final isSelected = _selectedOptions.contains(option["title"]!);
            final hasImage =
                widget.containsImages && option["image"] != null && option["image"]!.isNotEmpty;

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedOptions.remove(option["title"]!);
                  } else {
                    _selectedOptions.add(option["title"]!);
                  }
                });
                widget.onSelectionsChanged(_selectedOptions.toList());
              },
              child: Card(
                color: isSelected
                    ? Colors.orange.withOpacity(0.8)
                    : Colors.white.withOpacity(0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (hasImage)
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          option["image"]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (hasImage) const SizedBox(height: 8), // Add spacing for images
                    Expanded(
                      flex: hasImage ? 1 : 2, // Adjust height based on content
                      child: Center(
                        child: Text(
                          option["title"]!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
