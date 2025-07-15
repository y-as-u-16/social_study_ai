import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_theme.dart';

class LearningScreen extends StatefulWidget {
  final String subject;
  
  const LearningScreen({
    super.key,
    required this.subject,
  });

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool hasAnswered = false;
  List<bool> answerResults = [];
  int score = 0;
  bool isSessionCompleted = false;
  
  final List<Map<String, dynamic>> questions = [
    {
      'question': '江戸時代の身分制度で、武士の下に位置した身分を正しい順序で並べなさい。',
      'options': ['農民 → 工人 → 商人', '商人 → 農民 → 工人', '工人 → 商人 → 農民', '農民 → 商人 → 工人'],
      'correctAnswer': 0,
      'explanation': '江戸時代の身分制度は士農工商の順序で、武士の下は農民、工人、商人の順でした。',
      'category': '歴史',
      'difficulty': 'medium'
    },
    {
      'question': '日本の最高峰である富士山の標高は？',
      'options': ['3,776m', '3,677m', '3,867m', '3,967m'],
      'correctAnswer': 0,
      'explanation': '富士山の標高は3,776mで、日本最高峰の山です。',
      'category': '地理',
      'difficulty': 'easy'
    },
    {
      'question': '日本国憲法で保障される基本的人権のうち、「精神的自由権」に含まれないものはどれか？',
      'options': ['思想・良心の自由', '信教の自由', '表現の自由', '財産権'],
      'correctAnswer': 3,
      'explanation': '財産権は経済的自由権に分類され、精神的自由権には含まれません。',
      'category': '公民',
      'difficulty': 'hard'
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (isSessionCompleted) {
      return _buildResultScreen();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject}の学習'),
        backgroundColor: AppColors.getSubjectColor(widget.subject),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestionCard(),
                  const SizedBox(height: AppSizes.paddingL),
                  _buildAnswerOptions(),
                  const SizedBox(height: AppSizes.paddingL),
                  if (hasAnswered) _buildExplanation(),
                ],
              ),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / questions.length,
            backgroundColor: AppColors.borderLight,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.getSubjectColor(widget.subject)),
          ),
          const SizedBox(height: AppSizes.paddingS),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '進捗: ${((currentQuestionIndex + 1) / questions.length * 100).toInt()}%',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'スコア: $score/${answerResults.length}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    final question = questions[currentQuestionIndex];
    
    return Card(
      elevation: AppSizes.cardElevation,
      shadowColor: AppColors.cardShadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusL),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusL),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, AppColors.surfaceLight],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingL),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.getDifficultyColor(question['difficulty']),
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
                  ),
                  child: Text(
                    _getDifficultyText(question['difficulty']),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.getSubjectColor(widget.subject),
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
                  ),
                  child: Text(
                    question['category'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ),);
  }

  Widget _buildAnswerOptions() {
    final question = questions[currentQuestionIndex];
    
    return Column(
      children: List.generate(
        question['options'].length,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: hasAnswered ? null : () => _selectAnswer(index),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getOptionColor(index),
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
                border: Border.all(
                  color: _getOptionBorderColor(index),
                  width: 2,
                ),
                boxShadow: selectedAnswerIndex == index
                    ? [AppColors.cardShadow]
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getOptionNumberColor(index),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question['options'][index],
                      style: TextStyle(
                        fontSize: 16,
                        color: _getOptionTextColor(index),
                        fontWeight: selectedAnswerIndex == index ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (hasAnswered && index == question['correctAnswer'])
                    Icon(Icons.check_circle, color: AppColors.success, size: 24),
                  if (hasAnswered && selectedAnswerIndex == index && index != question['correctAnswer'])
                    Icon(Icons.cancel, color: AppColors.error, size: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExplanation() {
    final question = questions[currentQuestionIndex];
    
    return Card(
      elevation: AppSizes.cardElevation,
      shadowColor: AppColors.cardShadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusL),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusL),
          color: AppColors.info.withValues(alpha: 0.1),
          border: Border.all(
            color: AppColors.info.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.info,
                  size: 20,
                ),
                const SizedBox(width: AppSizes.paddingS),
                Text(
                  '解説',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.info,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.paddingS),
            Text(
              question['explanation'],
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    ),);
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: SizedBox(
        width: double.infinity,
        height: AppSizes.buttonHeight,
        child: ElevatedButton(
          onPressed: hasAnswered ? _nextQuestion : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.getSubjectColor(widget.subject),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
            ),
            elevation: AppSizes.cardElevation,
          ),
          child: Text(
            currentQuestionIndex == questions.length - 1 ? '結果を見る' : '次の問題へ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    final percentage = (score / questions.length * 100).round();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('学習結果'),
        backgroundColor: AppColors.getSubjectColor(widget.subject),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScoreCard(percentage),
            const SizedBox(height: 20),
            _buildDetailedResults(),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(int percentage) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              '学習完了！',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getSubjectColor(widget.subject),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: _getScoreColor(percentage),
              ),
            ),
            const SizedBox(height: AppSizes.paddingS),
            Text(
              '$score/${questions.length}問正解',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _getScoreMessage(percentage),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedResults() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '詳細結果',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              questions.length,
              (index) => _buildResultItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(int index) {
    final question = questions[index];
    final isCorrect = answerResults[index];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCorrect ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.red,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '問題${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  question['question'],
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.getSubjectColor(widget.subject),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'ダッシュボードに戻る',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                currentQuestionIndex = 0;
                selectedAnswerIndex = null;
                hasAnswered = false;
                answerResults.clear();
                score = 0;
                isSessionCompleted = false;
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _getSubjectColor(widget.subject)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'もう一度学習する',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getSubjectColor(widget.subject),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _selectAnswer(int index) {
    setState(() {
      selectedAnswerIndex = index;
      hasAnswered = true;
      
      final isCorrect = index == questions[currentQuestionIndex]['correctAnswer'];
      answerResults.add(isCorrect);
      
      if (isCorrect) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        hasAnswered = false;
      });
    } else {
      setState(() {
        isSessionCompleted = true;
      });
    }
  }

  Color _getSubjectColor(String subject) {
    return AppColors.getSubjectColor(subject);
  }

  // Color _getDifficultyColor(String difficulty) {
  //   return AppColors.getDifficultyColor(difficulty);
  // }

  String _getDifficultyText(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return '基礎';
      case 'medium':
        return '標準';
      case 'hard':
        return '応用';
      default:
        return '不明';
    }
  }

  Color _getOptionColor(int index) {
    if (!hasAnswered) {
      return selectedAnswerIndex == index ? Colors.blue[100]! : Colors.grey[50]!;
    }
    
    final correctIndex = questions[currentQuestionIndex]['correctAnswer'];
    if (index == correctIndex) {
      return Colors.green[100]!;
    } else if (selectedAnswerIndex == index) {
      return Colors.red[100]!;
    } else {
      return Colors.grey[50]!;
    }
  }

  Color _getOptionBorderColor(int index) {
    if (!hasAnswered) {
      return selectedAnswerIndex == index ? Colors.blue : Colors.grey[300]!;
    }
    
    final correctIndex = questions[currentQuestionIndex]['correctAnswer'];
    if (index == correctIndex) {
      return Colors.green;
    } else if (selectedAnswerIndex == index) {
      return Colors.red;
    } else {
      return Colors.grey[300]!;
    }
  }

  Color _getOptionNumberColor(int index) {
    if (!hasAnswered) {
      return selectedAnswerIndex == index ? Colors.blue : Colors.grey;
    }
    
    final correctIndex = questions[currentQuestionIndex]['correctAnswer'];
    if (index == correctIndex) {
      return Colors.green;
    } else if (selectedAnswerIndex == index) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  Color _getOptionTextColor(int index) {
    if (!hasAnswered) {
      return Colors.black;
    }
    
    final correctIndex = questions[currentQuestionIndex]['correctAnswer'];
    if (index == correctIndex) {
      return Colors.green[800]!;
    } else if (selectedAnswerIndex == index) {
      return Colors.red[800]!;
    } else {
      return Colors.grey[600]!;
    }
  }

  Color _getScoreColor(int percentage) {
    return AppColors.getScoreColor(percentage);
  }

  String _getScoreMessage(int percentage) {
    if (percentage >= 90) {
      return 'すばらしい！完璧な理解です！';
    } else if (percentage >= 80) {
      return 'よくできました！この調子で頑張りましょう！';
    } else if (percentage >= 60) {
      return 'もう少し頑張りましょう！復習をおすすめします。';
    } else {
      return '基礎から復習しましょう。諦めずに続けることが大切です。';
    }
  }
}