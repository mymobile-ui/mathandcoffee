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
    final progressValue = (_currentQuestionIndex + 1) / _questions.length;
    final isCurrentSelectionCorrect =
        _selectedOptionIndex == _currentQuestion.correctOptionIndex;
    final correctAnswerText = _currentQuestion.options[_currentQuestion.correctOptionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Açılar Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '180° = π radyan',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(value: progressValue),
            const SizedBox(height: 24),
            Text(
              'Soru ${_currentQuestionIndex + 1} / ${_questions.length}',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(
              _currentQuestion.prompt,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            ...List.generate(_currentQuestion.options.length, (index) {
              final option = _currentQuestion.options[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: RadioListTile<int>(
                  title: Text(option),
                  value: index,
                  groupValue: _selectedOptionIndex,
                  onChanged: _handleOptionChanged,
                ),
              );
            }),
            if (_isAnswerChecked)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  isCurrentSelectionCorrect
                      ? 'Harika! Doğru cevabı seçtiniz.'
                      : 'Yanıtınız yanlış. Doğru cevap: $correctAnswerText',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isCurrentSelectionCorrect
                        ? colorScheme.primary
                        : colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedOptionIndex != null && !_isAnswerChecked
                        ? _checkAnswer
                        : null,
                    child: const Text('Cevabı Kontrol Et'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isAnswerChecked ? _goToNextQuestion : null,
                    child: Text(
                      _currentQuestionIndex + 1 == _questions.length ? 'Sonuçlara Git' : 'Sonraki',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  static const routeName = 'result';

  final int totalQuestions;
  final int correctAnswers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (correctAnswers / totalQuestions * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sonuçlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Doğru Cevaplar: $correctAnswers / $totalQuestions',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Başarı Oranı: %$percentage',
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Başa dön'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == 'trig-subtopics' || route.isFirst);
              },
              child: const Text('Trigonometriye dön'),
            ),
          ],
        ),
      ),
    );
  }
}
