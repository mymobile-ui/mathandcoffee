import 'package:flutter/material.dart';

class Question {
  const Question({
    required this.prompt,
    required this.options,
    required this.correctOptionIndex,
  }) : assert(options.length == 4, 'Each question must have four options.');

  final String prompt;
  final List<String> options;
  final int correctOptionIndex;
}

class AnglesQuizScreen extends StatefulWidget {
  const AnglesQuizScreen({super.key});

  static const routeName = 'angles-quiz';

  @override
  State<AnglesQuizScreen> createState() => _AnglesQuizScreenState();
}

class _AnglesQuizScreenState extends State<AnglesQuizScreen> {
  final List<Question> _questions = const [
    Question(
      prompt: '30° kaç radyandır?',
      options: ['π/3', 'π/6', 'π/4', 'π/2'],
      correctOptionIndex: 1,
    ),
    Question(
      prompt: '120° açısını radyana çevirin.',
      options: ['2π/3', '3π/4', '5π/6', '7π/6'],
      correctOptionIndex: 0,
    ),
    Question(
      prompt: '225° açısı kaç radyandır?',
      options: ['3π/4', '5π/4', '7π/4', '5π/6'],
      correctOptionIndex: 1,
    ),
    Question(
      prompt: '315° açısını radyana çevirin.',
      options: ['11π/6', '7π/4', '3π/2', '5π/3'],
      correctOptionIndex: 1,
    ),
    Question(
      prompt: 'π/5 radyan kaç derecedir?',
      options: ['36°', '30°', '18°', '45°'],
      correctOptionIndex: 0,
    ),
  ];

  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _isAnswerChecked = false;
  int _correctAnswers = 0;

  Question get _currentQuestion => _questions[_currentQuestionIndex];

  void _handleOptionChanged(int? value) {
    if (!_isAnswerChecked) {
      setState(() {
        _selectedOptionIndex = value;
      });
    }
  }

  void _checkAnswer() {
    if (_selectedOptionIndex == null || _isAnswerChecked) {
      return;
    }

    final isCorrect = _selectedOptionIndex == _currentQuestion.correctOptionIndex;

    setState(() {
      _isAnswerChecked = true;
      if (isCorrect) {
        _correctAnswers += 1;
      }
    });

    final colorScheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            isCorrect ? 'Doğru cevap!' : 'Yanlış cevap, tekrar deneyin.',
          ),
          backgroundColor: isCorrect ? colorScheme.primary : colorScheme.error,
        ),
      );
  }

  void _goToNextQuestion() {
    if (!_isAnswerChecked) {
      return;
    }

    if (_currentQuestionIndex + 1 == _questions.length) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            totalQuestions: _questions.length,
            correctAnswers: _correctAnswers,
          ),
          settings: const RouteSettings(name: ResultScreen.routeName),
        ),
      );
      return;
    }

    setState(() {
      _currentQuestionIndex += 1;
      _selectedOptionIndex = null;
      _isAnswerChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Açılar Quiz'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            'Açılar quiz içeriği yakında burada olacak.',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onTertiaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
