import 'package:flutter/material.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final String question;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const MultipleChoiceQuestion({
    Key? key,
    required this.question,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<MultipleChoiceQuestion> createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  String? _selectedOption;

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
        ...widget.options.map((option) {
          final isSelected = _selectedOption == option;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = option;
              });
              widget.onSelected(option);
            },
            child: Card(
              color: isSelected
                  ? Colors.orange.withOpacity(0.8)
                  : Colors.white.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
