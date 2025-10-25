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

class AngleQuizScreen extends StatefulWidget {
  const AngleQuizScreen({super.key});

  static const routeName = 'angle-quiz';

  @override
  State<AngleQuizScreen> createState() => _AngleQuizScreenState();
}

class _AngleQuizScreenState extends State<AngleQuizScreen> {
  final List<Question> _questions = [
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
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;
    final hasSelection = _selectedOptionIndex != null;
    final isCorrectSelection =
        _selectedOptionIndex == _currentQuestion.correctOptionIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Açılar Quiz'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Soru ${_currentQuestionIndex + 1}/${_questions.length}',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _currentQuestion.prompt,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(
                      _currentQuestion.options.length,
                      (index) {
                        final option = _currentQuestion.options[index];
                        final isCorrectOption =
                            index == _currentQuestion.correctOptionIndex;
                        final isSelected =
                            _selectedOptionIndex == index && _isAnswerChecked;

                        Color? tileColor;
                        if (_isAnswerChecked && isCorrectOption) {
                          tileColor = colorScheme.primaryContainer;
                        } else if (_isAnswerChecked && isSelected) {
                          tileColor = colorScheme.errorContainer;
                        }

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == _currentQuestion.options.length - 1
                                ? 0
                                : 12,
                          ),
                          child: RadioListTile<int>(
                            value: index,
                            groupValue: _selectedOptionIndex,
                            onChanged:
                                _isAnswerChecked ? null : _handleOptionChanged,
                            title: Text(
                              option,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            tileColor: tileColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            activeColor: colorScheme.primary,
                          ),
                        );
                      },
                    ),
                    if (_isAnswerChecked) ...[
                      const SizedBox(height: 16),
                      Text(
                        isCorrectSelection
                            ? 'Harika! Doğru cevap.'
                            : 'Doğru cevap: ${_currentQuestion.options[_currentQuestion.correctOptionIndex]}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isCorrectSelection
                              ? colorScheme.primary
                              : colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: !_isAnswerChecked && hasSelection
                                ? _checkAnswer
                                : null,
                            child: const Text('Cevabı Kontrol Et'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isAnswerChecked ? _goToNextQuestion : null,
                            child: Text(
                              isLastQuestion ? 'Sonuçlara Git' : 'Sonraki Soru',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Doğru cevap sayısı: $_correctAnswers',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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

  static const routeName = 'angle-quiz-result';

  final int totalQuestions;
  final int correctAnswers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final score = totalQuestions == 0
        ? 0
        : (correctAnswers / totalQuestions * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Sonuçları'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            margin: const EdgeInsets.all(16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    size: 72,
                    color: colorScheme.secondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tebrikler!',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Doğru cevap sayısı: $correctAnswers / $totalQuestions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '%$score başarı',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 28),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AngleQuizScreen(),
                        settings: const RouteSettings(
                          name: AngleQuizScreen.routeName,
                        ),
                      ),
                    ),
                    child: const Text("Quiz'i Yeniden Dene"),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Trigonometri konularına dön'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
