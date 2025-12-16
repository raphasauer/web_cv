import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/intro_section.dart';
import 'widgets/impact_section.dart';
import 'widgets/world_map_section.dart';
import 'widgets/apps_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/work_history_section.dart';
import 'widgets/footer.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raphael de Castro - Software Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ResumePage(),
    );
  }
}

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= 400) {
      if (!_showBackToTop) setState(() => _showBackToTop = true);
    } else {
      if (_showBackToTop) setState(() => _showBackToTop = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F0F23),
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                ],
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            controller: _scrollController,
            child: const Column(
              children: [
                IntroSection(),
                ImpactSection(),
                WorldMapSection(),
                AppsSection(),
                SkillsSection(),
                WorkHistorySection(),
                Footer(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}