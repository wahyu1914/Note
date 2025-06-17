import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/constants.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.isInGrid, super.key});

  final bool isInGrid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: primary, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.5),
            offset: const Offset(4, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This is going to be a title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: gray900,
            ),
          ),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: gray100,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  margin: EdgeInsets.only(right: 4),
                  child: Text(
                    'First chip',
                    style: const TextStyle(fontSize: 12, color: gray700),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          if (isInGrid)
            Expanded(
              child: Text(
                'Some content',
                style: const TextStyle(color: gray700),
              ),
            )
          else
            Text(
              'Some content',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: gray700),
            ),
          Row(
            children: [
              Text(
                '14 June 2025',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: gray500,
                ),
              ),
              const Spacer(),
              FaIcon(FontAwesomeIcons.trash, color: gray500, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
