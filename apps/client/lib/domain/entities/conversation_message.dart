enum ConversationRole { teacher, learner }

class ConversationMessage {
  const ConversationMessage({
    required this.role,
    required this.text,
  });

  final ConversationRole role;
  final String text;
}
