import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../data/resume_data.dart';
import 'section_title.dart';

class ImpactSection extends StatefulWidget {
  const ImpactSection({super.key});

  @override
  State<ImpactSection> createState() => _ImpactSectionState();
}

class _ImpactSectionState extends State<ImpactSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return VisibilityDetector(
      key: const Key('impact-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          _isVisible = true;
          _controller.forward();
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: 80,
        ),
        child: Column(
          children: [
            const SectionTitle(
              title: 'Impact',
              subtitle: 'Numbers that tell my story',
            ),
            const SizedBox(height: 60),
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: ResumeData.impactStats.entries.map((entry) {
                return _buildStatCard(
                  entry.value['count'],
                  entry.value['label'],
                  _getIconForStat(entry.key),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForStat(String key) {
    switch (key) {
      case 'users':
        return Icons.people;
      case 'downloads':
        return Icons.download;
      case 'countries':
        return Icons.public;
      case 'reviews':
        return Icons.star;
      default:
        return Icons.analytics;
    }
  }

  Widget _buildStatCard(String count, String label, IconData icon) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _controller.value)),
          child: Opacity(
            opacity: _controller.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(30),
        decoration: AppTheme.glassDecoration,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                count,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}