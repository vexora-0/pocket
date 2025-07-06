import 'package:flutter/material.dart';
import '../models/conversation.dart';
import '../../utils/color_utils.dart';

abstract class ConversationService {
  Future<List<Conversation>> getConversations({
    String? categoryId,
    DateTime? date,
  });

  Future<List<ConversationType>> getCategories();

  Future<List<DateInfo>> getAvailableDates();

  Future<MiniPlayerData?> getCurrentPlayerData();

  Future<void> playConversation(String conversationId);

  Future<void> pauseConversation();
}

class ConversationServiceImpl implements ConversationService {
  // In a real implementation, this would make HTTP calls to your API

  @override
  Future<List<Conversation>> getConversations({
    String? categoryId,
    DateTime? date,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    final allConversations = _getMockConversations();

    // Filter by category if provided
    if (categoryId != null) {
      return allConversations
          .where((conv) => conv.type.id == categoryId)
          .toList();
    }

    // Filter by date if provided
    if (date != null) {
      return allConversations
          .where((conv) => _isSameDate(conv.createdAt, date))
          .toList();
    }

    return allConversations;
  }

  @override
  Future<List<ConversationType>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));

    return [
      ConversationType(
        id: 'meetings',
        title: 'Meetings',
        iconPath: 'assets/icons/meetings.svg',
      ),
      ConversationType(
        id: 'chats',
        title: 'Chats',
        iconPath: 'assets/icons/chats.svg',
      ),
      ConversationType(
        id: 'thoughts',
        title: 'Thoughts',
        iconPath: 'assets/icons/Thoughts.svg',
      ),
    ];
  }

  @override
  Future<List<DateInfo>> getAvailableDates() async {
    await Future.delayed(const Duration(milliseconds: 150));

    final dates = <DateInfo>[];
    final startDate = DateTime.now().subtract(const Duration(days: 3));

    for (int i = 0; i < 7; i++) {
      final date = startDate.add(Duration(days: i));
      dates.add(
        DateInfo(
          date: date,
          weekday: _getWeekdayAbbreviation(date.weekday),
          shortWeekday: _getShortWeekday(date.weekday),
          fullWeekday: _getFullWeekday(date.weekday),
        ),
      );
    }

    return dates;
  }

  @override
  Future<MiniPlayerData?> getCurrentPlayerData() async {
    await Future.delayed(const Duration(milliseconds: 100));

    // Return null if no active conversation
    // In a real app, this would check for currently playing content
    return MiniPlayerData(
      title: "Sayan's pocket",
      duration: '00:08:55',
      progress: 0.76,
      isPlaying: true,
      isProcessed: true,
    );
  }

  @override
  Future<void> playConversation(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Start playback for the given conversation
    debugPrint('Playing conversation: $conversationId');
  }

  @override
  Future<void> pauseConversation() async {
    await Future.delayed(const Duration(milliseconds: 100));
    // Pause current playback
    debugPrint('Pausing conversation');
  }

  // Helper methods
  List<Conversation> _getMockConversations() {
    final categories = [
      ConversationType(
        id: 'meetings',
        title: 'Meetings',
        iconPath: 'assets/icons/meetings.svg',
      ),
      ConversationType(
        id: 'chats',
        title: 'Chats',
        iconPath: 'assets/icons/chats.svg',
      ),
      ConversationType(
        id: 'thoughts',
        title: 'Thoughts',
        iconPath: 'assets/icons/Thoughts.svg',
      ),
    ];

    return [
      Conversation(
        id: '1',
        title: 'Morning thoughts',
        time: '10:48',
        type: categories[2], // Thoughts
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF8B5CF6),
          const Color(0xFFEC4899),
        ]),
        createdAt: DateTime.now(),
        duration: 8 * 60 + 55, // 8:55 in seconds
        progress: 0.76,
      ),
      Conversation(
        id: '2',
        title: '1:1 w/ Akshay',
        subtitle: 'Conversation with Akshay about product features',
        type: categories[0], // Meetings
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFEF4444),
          const Color(0xFFF97316),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        duration: 25 * 60, // 25 minutes
        progress: 1.0,
      ),
      Conversation(
        id: '3',
        title: '2025 predictions',
        subtitle: 'Thoughts on what might happen in 2025',
        type: categories[2], // Thoughts
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFEC4899),
          const Color(0xFF3B82F6),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        duration: 15 * 60 + 30, // 15:30
        progress: 0.45,
      ),
      Conversation(
        id: '4',
        title: 'Chat w/ Sarah',
        subtitle: 'Quick catch-up about weekend plans',
        type: categories[1], // Chats
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF10B981),
          const Color(0xFF059669),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        duration: 7 * 60 + 23, // 7:23
        progress: 1.0,
      ),
      Conversation(
        id: '5',
        title: 'Project review meeting',
        subtitle: 'Quarterly review with the engineering team',
        type: categories[0], // Meetings
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF6366F1),
          const Color(0xFF8B5CF6),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        duration: 45 * 60, // 45 minutes
        progress: 0.89,
      ),
      Conversation(
        id: '6',
        title: 'Evening reflections',
        subtitle: 'Daily journal entry and gratitude notes',
        type: categories[2], // Thoughts
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFFF59E0B),
          const Color(0xFFF97316),
        ]),
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        duration: 5 * 60 + 45, // 5:45
        progress: 1.0,
      ),
      Conversation(
        id: '7',
        title: 'Team standup',
        subtitle: 'Daily standup meeting notes',
        type: categories[0], // Meetings
        gradientColors: ColorUtils.colorsToInts([
          const Color(0xFF059669),
          const Color(0xFF10B981),
        ]),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        duration: 12 * 60, // 12 minutes
        progress: 1.0,
      ),
    ];
  }

  String _getWeekdayAbbreviation(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  String _getShortWeekday(int weekday) {
    const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return weekdays[weekday - 1];
  }

  String _getFullWeekday(int weekday) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[weekday - 1];
  }

  bool _isSameDate(DateTime? date1, DateTime date2) {
    if (date1 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
