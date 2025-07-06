import 'package:flutter/material.dart';
import '../../utils/color_utils.dart';
import '../models/conversation.dart';
import '../../presentation/home/widgets/category_tabs.dart';
import '../../presentation/home/widgets/conversations/date_calendar.dart';

class MockDataSource {
  static List<ConversationType> getCategories() {
    return CategoryTabsFactory.createDefaultCategories();
  }

  static List<DateInfo> getDates() {
    return DateCalendarFactory.createWeekDates();
  }

  static List<Conversation> getConversations() {
    final categories = getCategories();

    return [
      Conversation(
        id: '1',
        title: 'Morning thoughts',
        time: '10:48',
        type: categories[2],
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF8B5CF6),
          const Color(0xFFEC4899),
        ]),
        createdAt: DateTime.now(),
        duration: 8 * 60 + 55,
        progress: 0.76,
      ),
      Conversation(
        id: '2',
        title: '1:1 w/ Akshay',
        subtitle: 'Conversation with Akshay about product features',
        type: categories[0],
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFEF4444),
          const Color(0xFFF97316),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        duration: 25 * 60,
        progress: 1.0,
      ),
      Conversation(
        id: '3',
        title: '2025 predictions',
        subtitle: 'Thoughts on what might happen in 2025',
        type: categories[2],
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFEC4899),
          const Color(0xFF3B82F6),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        duration: 15 * 60 + 30,
        progress: 0.45,
      ),
      Conversation(
        id: '4',
        title: 'Chat w/ Sarah',
        subtitle: 'Quick catch-up about weekend plans',
        type: categories[1],
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF10B981),
          const Color(0xFF059669),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        duration: 7 * 60 + 23,
        progress: 1.0,
      ),
      Conversation(
        id: '5',
        title: 'Project review meeting',
        subtitle: 'Quarterly review with the engineering team',
        type: categories[0],
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF6366F1),
          const Color(0xFF8B5CF6),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        duration: 45 * 60,
        progress: 0.89,
      ),
      Conversation(
        id: '6',
        title: 'Evening reflections',
        subtitle: 'Daily journal entry and gratitude notes',
        type: categories[2],
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFF59E0B),
          const Color(0xFFF97316),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        duration: 5 * 60 + 45,
        progress: 1.0,
      ),
      Conversation(
        id: '7',
        title: 'Evening reflections',
        subtitle: 'Daily journal entry and gratitude notes',
        type: categories[2],
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFF59E0B),
          const Color(0xFFF97316),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        duration: 5 * 60 + 45,
        progress: 1.0,
      ),
    ];
  }

  static MiniPlayerData? getMiniPlayerData() {
    final activeConversation = getConversations().firstOrNull;
    if (activeConversation == null) return null;

    return const MiniPlayerData(
      title: "Sayan's pocket",
      duration: '00:08:55',
      progress: 0.76,
      isPlaying: true,
      isProcessed: true,
    );
  }

  static List<Conversation> getOlderConversations() {
    final categories = getCategories();

    return [
      Conversation(
        id: '8',
        title: 'Team retrospective',
        subtitle: 'Quarterly team retrospective and planning session',
        type: categories[0], // Meetings
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF8B5CF6),
          const Color(0xFF3B82F6),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        duration: 35 * 60, // 35 minutes
        progress: 1.0,
      ),
      Conversation(
        id: '9',
        title: 'Weekend plans',
        subtitle: 'Planning weekend activities and events',
        type: categories[2], // Thoughts
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFEF4444),
          const Color(0xFFEC4899),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
        duration: 12 * 60 + 30, // 12:30
        progress: 0.67,
      ),
      Conversation(
        id: '10',
        title: 'Client feedback',
        subtitle: 'Review of client feedback and action items',
        type: categories[0], // Meetings
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF10B981),
          const Color(0xFF3B82F6),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        duration: 28 * 60, // 28 minutes
        progress: 1.0,
      ),
      Conversation(
        id: '11',
        title: 'Book insights',
        subtitle: 'Thoughts on recent book readings and takeaways',
        type: categories[2], // Thoughts
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFF59E0B),
          const Color(0xFFEF4444),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
        duration: 18 * 60 + 45, // 18:45
        progress: 0.89,
      ),
      Conversation(
        id: '12',
        title: 'Family catch-up',
        subtitle: 'Weekly family call and updates',
        type: categories[1], // Chats
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF6366F1),
          const Color(0xFF8B5CF6),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 14)),
        duration: 22 * 60, // 22 minutes
        progress: 1.0,
      ),
      Conversation(
        id: '13',
        title: 'Travel planning',
        subtitle: 'Planning upcoming vacation and destinations',
        type: categories[2], // Thoughts
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF059669),
          const Color(0xFF10B981),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 16)),
        duration: 15 * 60 + 20, // 15:20
        progress: 0.45,
      ),
    ];
  }

  static String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning, Sayan';
    if (hour < 17) return 'Good afternoon, Sayan';
    return 'Good evening, Sayan';
  }
}
