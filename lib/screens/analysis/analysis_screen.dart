import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_theme.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('学習分析'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 総合分析カード
            _buildOverallAnalysisCard(context),
            const SizedBox(height: AppSizes.paddingM),
            
            // 科目別分析カード
            _buildSubjectAnalysisCard(context),
            const SizedBox(height: AppSizes.paddingM),
            
            // 学習傾向カード
            _buildLearningTrendsCard(context),
            const SizedBox(height: AppSizes.paddingM),
            
            // 弱点分析カード
            _buildWeakPointsCard(context),
            const SizedBox(height: AppSizes.paddingM),
            
            // 学習進捗カード
            _buildProgressCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallAnalysisCard(BuildContext context) {
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
              Text(
                '総合分析',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAnalysisItem(context, '総問題数', '152', '問'),
                  _buildAnalysisItem(context, '平均正答率', '83.2%', ''),
                  _buildAnalysisItem(context, '総学習時間', '12.5', '時間'),
                ],
              ),
              const SizedBox(height: AppSizes.paddingM),
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSizes.paddingS),
                    Expanded(
                      child: Text(
                        '先週と比べて正答率が5.2%向上しました！',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectAnalysisCard(BuildContext context) {
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
              Text(
                '科目別分析',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              _buildSubjectAnalysisItem(context, '歴史', 0.85, '85%', '強い'),
              _buildSubjectAnalysisItem(context, '地理', 0.78, '78%', '普通'),
              _buildSubjectAnalysisItem(context, '公民', 0.92, '92%', '非常に強い'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectAnalysisItem(BuildContext context, String subject, double progress, String percentage, String level) {
    Color subjectColor = AppColors.getSubjectColor(subject);
    Color levelColor = _getLevelColor(level);
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingS,
                      vertical: AppSizes.paddingXS,
                    ),
                    decoration: BoxDecoration(
                      color: levelColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
                    ),
                    child: Text(
                      level,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: levelColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.paddingS),
                  Text(
                    percentage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: subjectColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingS),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.borderLight,
            valueColor: AlwaysStoppedAnimation<Color>(subjectColor),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningTrendsCard(BuildContext context) {
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
              Text(
                '学習傾向',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              _buildTrendItem(context, '最も得意な時間帯', '夕方 (16:00-18:00)', Icons.schedule),
              _buildTrendItem(context, '平均回答時間', '45秒/問', Icons.timer),
              _buildTrendItem(context, '学習頻度', '週5日', Icons.calendar_today),
              _buildTrendItem(context, '連続学習記録', '7日', Icons.local_fire_department),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendItem(BuildContext context, String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: AppSizes.paddingS),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeakPointsCard(BuildContext context) {
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
              Text(
                '弱点分析',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              _buildWeakPointItem(context, '地理', '気候と自然災害', 0.65, '65%'),
              _buildWeakPointItem(context, '歴史', '明治維新', 0.58, '58%'),
              _buildWeakPointItem(context, '公民', '経済システム', 0.72, '72%'),
              const SizedBox(height: AppSizes.paddingM),
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: AppSizes.paddingS),
                    Expanded(
                      child: Text(
                        '推奨：「気候と自然災害」の復習問題を重点的に学習しましょう',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeakPointItem(BuildContext context, String subject, String topic, double progress, String percentage) {
    Color subjectColor = AppColors.getSubjectColor(subject);
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$subject - $topic',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                percentage,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: subjectColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingXS),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.borderLight,
            valueColor: AlwaysStoppedAnimation<Color>(subjectColor),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
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
              Text(
                '学習進捗',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              _buildProgressItem(context, '今週の目標', 0.8, '8/10問'),
              _buildProgressItem(context, '今月の目標', 0.65, '65/100問'),
              _buildProgressItem(context, '年間目標', 0.32, '320/1000問'),
              const SizedBox(height: AppSizes.paddingM),
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: AppSizes.paddingS),
                    Expanded(
                      child: Text(
                        '今週の目標まで残り2問です！頑張りましょう！',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressItem(BuildContext context, String title, double progress, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingXS),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.borderLight,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(BuildContext context, String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSizes.paddingXS),
        RichText(
          text: TextSpan(
            text: value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: unit,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case '非常に強い':
        return AppColors.success;
      case '強い':
        return AppColors.primary;
      case '普通':
        return AppColors.warning;
      case '弱い':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }
}