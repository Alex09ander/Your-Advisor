import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  final _items = <_ChatItem>[];
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  bool _isSending = false;

  static const _backendBaseUrl = 'https://hackheroes25-advice.fly.dev/advice'; // TODO

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _textController.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() {
      _items.add(_ChatTextItem(fromUser: true, text: text));
      _textController.clear();
      _isSending = true;
      _chipsVisible = false;
      _items.add(const _ChatTypingItem());
    });
    _scrollToBottom();

    try {
      final response = await _fetchAdvice(text);

      setState(() {
        _items.removeWhere((e) => e is _ChatTypingItem);
        _items.add(_ChatTextItem(fromUser: false, text: response.chatResponse));
        _items.add(_ChatAdviceItem(advice: response.advice));
      });
    } catch (e) {
      setState(() {
        _items.removeWhere((e) => e is _ChatTypingItem);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nie udało się pobrać odpowiedzi. Spróbuj ponownie.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        _scrollToBottom();
      }
    }
  }

  Future<AdviceResponsePayload> _fetchAdvice(String message) async {
    final uri = Uri.parse(_backendBaseUrl).replace(
      queryParameters: {
        'message': message,
        // 'user_id': 'demo-user-id', // TODO: podmień na prawdziwe ID
        'user_id': "a7a7f865-8abc-4197-bf92-33bd78d1b502"
      },
    );

    final res = await http.get(
      uri,
      headers: const {
        // 'Authorization': 'Bearer demo-token', // TODO: podmień na prawdziwy token
      },
    );

    if (res.statusCode != 200) {
      throw Exception('Backend error: ${res.statusCode}');
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return AdviceResponsePayload.fromJson(json);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    });
  }

  Future<void> _openAdviceLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nie udało się otworzyć linku.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 8,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Icon(
                Icons.psychology,
                size: 18,
                color: colors.onSecondaryContainer,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Twój asystent',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'Napisz, co Ci siedzi w głowie',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  if (item is _ChatTextItem) {
                    return _buildTextBubble(context, item);
                  } else if (item is _ChatAdviceItem) {
                    return _buildAdviceBubble(context, item);
                  } else if (item is _ChatTypingItem) {
                    return _buildTypingBubble(context);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            AnimatedSize(
              duration: Durations.medium1,
              curve: Curves.easeOut,
              child: _chipsVisible
                  ? Column(
                      children: [
                        _buildSuggestionChips(context),
                        const Gap(50),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            const Divider(height: 1),
            _buildInputBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChips(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final chipFont = Theme.of(context).textTheme.labelMedium!;
    final patrickHand =
        chipFont.copyWith(fontFamily: 'PatrickHand', fontWeight: FontWeight.w500);

    return Wrap(
      spacing: 15,
      runSpacing: 3,
      children: [
        ActionChip(
          avatar: const Icon(Icons.bolt_outlined, size: 16),
          label: Text(
            'Czuję, że stoję w miejscu',
            style: chipFont,
          ),
          onPressed: () => _sendChip(0),
        ),
        ActionChip(
          avatar: const Icon(Icons.noise_control_off_outlined, size: 16),
          label: Text(
            'Jestem przebodźcowany',
            style: chipFont,
          ),
          onPressed: () => _sendChip(1),
        ),
        ActionChip(
          avatar: const Icon(Icons.psychology_alt_outlined, size: 16),
          label: Text(
            'Szukam książki rozwojowej',
            style: chipFont,
          ),
          onPressed: () => _sendChip(2),
        ),
        ActionChip(
          avatar: const Icon(Icons.speed_outlined, size: 16),
          label: Text(
            'Chciałbym uczyć się szybciej',
            style: chipFont,
          ),
          onPressed: () => _sendChip(3),
        ),
        ActionChip(
          avatar: const Icon(Icons.psychology_alt_outlined, size: 16),
          label: Text(
            'Zaskocz mnie ciekawym pojęciem psychologicznym',
            style: chipFont,
          ),
          onPressed: () => _sendChip(4),
        ),
      ],
    );
  }

  final _chipPrompts = {
    0: 'Czuję, że się nie rozwijam, skąd wzięło się te uczucie? Chcę ruszyć dalej.',
    1: 'Jestem przebodźcowany i czasem nie wiem, co się dzieje wokół mnie.. Potrzebuję wskazówki..',
    2: 'Chcę przeczytać ciekawą książkę rozwojową. Czy znasz coś o nawykach lub zarządzaniu czasem?',
    3: 'Chcę wyraźnie przyspieszyć proces nauki.',
    4: 'Zaciekaw mnie jakimś pojęciem z psychologii; pokaż, jak wykorzystać to w praktyce.',
  };

  bool _chipsVisible = true;

  Future<void> _sendChip(int key) async {
    final mapped = _chipPrompts[key];
    if (mapped == null) return;

    _textController.text = mapped;
    await _send();
  }

  Widget _buildInputBar(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: 'Wyślij wiadomość...',
                  filled: true,
                  isDense: true,
                  fillColor: colors.surfaceContainer,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            M3Container(
              key: UniqueKey(),
              Shapes.c7_sided_cookie,
              height: 60,
              width: 60,
              clipBehavior: Clip.antiAlias,
              child: FilledButton(
                onPressed: _isSending ? null : _send,
                style: FilledButton.styleFrom(
                  // shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                ),
                child: _isSending
                    ? const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(strokeWidth: 2.3),
                      )
                    : const Icon(Icons.send_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextBubble(BuildContext context, _ChatTextItem item) {
    final colors = Theme.of(context).colorScheme;
    final isUser = item.fromUser;

    final backgroundColor = isUser ? colors.primaryContainer : colors.surfaceContainerLow;
    final textColor = isUser ? colors.onPrimaryContainer : colors.onSurfaceVariant;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: 4,
          bottom: 6,
          left: isUser ? 64 : 0,
          right: isUser ? 0 : 64,
        ),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 8),
                child: child,
              ),
            );
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isUser ? 20 : 6),
                bottomRight: Radius.circular(isUser ? 6 : 20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Text(
                item.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: textColor, height: 1.35),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdviceBubble(BuildContext context, _ChatAdviceItem item) {
    final colors = Theme.of(context).colorScheme;
    final advice = item.advice;

    final backgroundColor = colors.surfaceContainerLow;
    final textColor = colors.onSurfaceVariant;
    final label = _adviceKindLabel(advice.kind);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 12, right: 72),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeOutCubic,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 10),
                child: child,
              ),
            );
          },
          child: Card(
            color: backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lightbulb_rounded,
                        size: 18,
                        color: textColor.withOpacity(0.95),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: textColor.withOpacity(0.9),
                              letterSpacing: 0.3,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    advice.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (advice.author != null && advice.author!.trim().isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      advice.author!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textColor.withOpacity(0.9),
                          ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  if (advice.linkUrl != null && advice.linkUrl!.trim().isNotEmpty)
                    FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        backgroundColor: textColor,
                        foregroundColor: backgroundColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: const Size(0, 0),
                      ),
                      onPressed: () => _openAdviceLink(advice.linkUrl!),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.open_in_new_rounded, size: 16),
                          SizedBox(width: 6),
                          Text('Zobacz'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypingBubble(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 8, right: 72),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: _TypingDots(),
          ),
        ),
      ),
    );
  }

  String _adviceKindLabel(AdviceKind kind) {
    switch (kind) {
      case AdviceKind.book:
        return 'Książka';
      case AdviceKind.movie:
        return 'Film';
      case AdviceKind.music:
        return 'Muzyka';
      case AdviceKind.youtubeVideo:
        return 'Wideo';
      case AdviceKind.article:
        return 'Artykuł';
      case AdviceKind.habit:
        return 'Nawyk';
      case AdviceKind.advice:
        return 'Porada';
      case AdviceKind.concept:
        return 'Pojęcie';
      case AdviceKind.psychotherapy:
        return 'Psychoterapia';
      case AdviceKind.podcast:
        return 'Podcast';
      case AdviceKind.quote:
        return 'Cytat';
      case AdviceKind.person:
        return 'Osoba';
    }
  }
}

/// Typing indicator: 3 kropeczki pulsujące w bąbelku
class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double dotOpacity(int index) {
          final t = (_controller.value + index * 0.2) % 1.0;
          return 0.3 + 0.7 * Curves.easeInOut.transform(t);
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Opacity(
                opacity: dotOpacity(i),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: colors.onSurfaceVariant,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/* =======================
   MODELE POD BACKEND
   ======================= */

class AdviceResponsePayload {
  final AdviceDetailsResponse advice;
  final String chatResponse;

  AdviceResponsePayload({
    required this.advice,
    required this.chatResponse,
  });

  factory AdviceResponsePayload.fromJson(Map<String, dynamic> json) {
    return AdviceResponsePayload(
      advice: AdviceDetailsResponse.fromJson(
        json['advice'] as Map<String, dynamic>,
      ),
      chatResponse: json['chat_response'] as String,
    );
  }
}

class AdviceDetailsResponse {
  final String name;
  final AdviceKind kind;
  final String description;
  final String? llmDescription;
  final String? linkUrl;
  final String? imageUrl;
  final String? author;

  AdviceDetailsResponse({
    required this.name,
    required this.kind,
    required this.description,
    this.llmDescription,
    this.linkUrl,
    this.imageUrl,
    this.author,
  });

  factory AdviceDetailsResponse.fromJson(Map<String, dynamic> json) {
    return AdviceDetailsResponse(
      name: json['name'] as String,
      kind: AdviceKindParser.fromJson(json['kind'] as String),
      description: (json['description'] ?? '') as String,
      llmDescription: json['llm_description'] as String?,
      linkUrl: json['link_url'] as String?,
      imageUrl: json['image_url'] as String?,
      author: json['author'] as String?,
    );
  }
}

enum AdviceKind {
  book,
  movie,
  music,
  youtubeVideo,
  article,
  habit,
  advice,
  concept,
  psychotherapy,
  podcast,
  quote,
  person,
}

class AdviceKindParser {
  static AdviceKind fromJson(String value) {
    switch (value) {
      case 'book':
        return AdviceKind.book;
      case 'movie':
        return AdviceKind.movie;
      case 'music':
        return AdviceKind.music;
      case 'youtube_video':
        return AdviceKind.youtubeVideo;
      case 'article':
        return AdviceKind.article;
      case 'habit':
        return AdviceKind.habit;
      case 'advice':
        return AdviceKind.advice;
      case 'concept':
        return AdviceKind.concept;
      case 'psychotherapy':
        return AdviceKind.psychotherapy;
      case 'podcast':
        return AdviceKind.podcast;
      case 'quote':
        return AdviceKind.quote;
      case 'person':
        return AdviceKind.person;
      default:
        return AdviceKind.advice;
    }
  }
}

/* =======================
   MODELE CZATU (UI)
   ======================= */

abstract class _ChatItem {
  const _ChatItem();
}

class _ChatTextItem extends _ChatItem {
  final bool fromUser;
  final String text;

  const _ChatTextItem({
    required this.fromUser,
    required this.text,
  });
}

class _ChatAdviceItem extends _ChatItem {
  final AdviceDetailsResponse advice;

  const _ChatAdviceItem({required this.advice});
}

class _ChatTypingItem extends _ChatItem {
  const _ChatTypingItem();
}
