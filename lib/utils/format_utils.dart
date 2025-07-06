/// Utility class for formatting various data types into user-friendly strings.
class FormatUtils {
  /// Formats a [Duration] into MM:SS format.
  ///
  /// Example: Duration(minutes: 5, seconds: 23) -> "05:23"
  static String formatDuration(Duration duration) {
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Formats a [DateTime] into a human-readable relative string.
  ///
  /// Returns "Today", "Yesterday", "X days ago", or DD/MM/YYYY format.
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  /// Formats file size in bytes to human-readable format (B, KB, MB).
  ///
  /// Example: 1536 -> "1.5KB"
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '${bytes}B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)}KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
  }

  /// Generates a conversation title based on the time of day.
  ///
  /// Returns format: "[Morning/Afternoon/Evening] thoughts HH:MM"
  static String generateConversationTitle(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;

    String timeOfDay;
    if (hour < 12) {
      timeOfDay = 'Morning';
    } else if (hour < 17) {
      timeOfDay = 'Afternoon';
    } else {
      timeOfDay = 'Evening';
    }

    return '$timeOfDay thoughts ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
